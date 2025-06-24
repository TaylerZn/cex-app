import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/price_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodiy_entrust/controllers/commondiy_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/models/price_type.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_log_event_name.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_manager.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/dialog/warning_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../models/contract/req/create_order_req.dart';
import '../../../../utils/utilities/ui_util.dart';
import '../../../../widgets/components/transaction/transaction_switch_button.dart';
import '../../commodity_position/controllers/commodity_position_controller.dart';

extension CommodityCreateOrderControllerX on CommodityController {
  Future<void> _showWaringDialog() async {
    await WarningDialog.show(
      title: LocaleKeys.trade386.tr,
      icon: 'assets/images/trade/notice_warning.svg',
      okTitle: LocaleKeys.public76.tr,
    );
    stopWinTextController.clear();
    stopLossTextController.clear();
  }

  Future<void> createOrder(String side) async {
    if (state.contractInfo.value == null) return;
    String? expireTime = state.userConfig.value?.expireTime.toString();
    String triggerPrice = '';
    String amount = amountTextController.text.trim();

    /// 止盈止损
    if (!state.isMarketOrder.value) {
      if (priceTextController.text.trim().isEmpty) {
        UIUtil.showToast(LocaleKeys.trade8.tr);
        priceFocusNode.requestFocus();
        return;
      }
      triggerPrice = priceTextController.text.trim();
    }

    if (amountTextController.text.trim().isEmpty) {
      UIUtil.showToast(LocaleKeys.trade9.tr);
      amountFocusNode.requestFocus();
      return;
    }

    PriceInfo? priceInfo = CommodityDataStoreController.to
        .getPriceInfoBySubSymbol(state.contractInfo.value?.subSymbol ?? '');

    /// 标记价格
    String tagPrice =
        priceInfo?.tagPrice.toString() ?? state.contractInfo.value!.close;

    /// 开仓
    if (state.switchState.value == TransactionSwitchButtonValue.left) {
      /// 市价单 volume是金额
      int amoutPrecision = state.contractInfo.value?.coinResultVo?.minOrderMoney
              .numDecimalPlaces() ??
          2;
      if (state.isMarketOrder.value) {
        /// 百分比 就是可用余额
        if (state.percent.value != 0) {
          amount = (state.availableBalance.value.toDecimal() *
                  (state.userConfig.value?.getNowLevel() ?? 20).toDecimal() *
                  state.percent.value.toDecimal())
              .toPrecision(amoutPrecision);
        } else {
          if (state.amountUnitIndex.value == 0) {
            /// 金额 = 数量 * 标记价格 * (1+滑点)
            amount = (amountTextController.text.trim().toDecimal() *
                    tagPrice.toDecimal() *
                    (1 + state.contractInfo.value!.slippage).toDecimal())
                .toPrecision(amoutPrecision);
          } else {
            /// 金额 = 数量
            amount = amountTextController.text.trim();
          }
        }
      } else {
        /// 限价单 volume是张数、
        /// btc
        if (state.amountUnitIndex.value == 0) {
          if (state.percent.value != 0) {
            /// 百分比
            amount = (state.canOpenAmount.value.toDecimal() *
                    state.percent.value.toDecimal() /
                    state.contractInfo.value!.multiplier.toDecimal())
                .ceil()
                .toString();
          } else {
            // 张数 =
            amount = (amount.toDecimal() /
                    state.contractInfo.value!.multiplier.toDecimal())
                .ceil()
                .toString();
          }
        } else {
          /// usdt
          if (state.percent.value != 0) {
            /// 张数 = 可用余额 * 杠杆倍数 * 百分比 / 委托价格 / 合约面值
            amount = (state.availableBalance.value.toDecimal() *
                    (state.userConfig.value?.getNowLevel() ?? 20).toDecimal() *
                    state.percent.value.toDecimal() /
                    (triggerPrice.toDecimal() *
                        state.contractInfo.value!.multiplier.toDecimal()))
                .ceil()
                .toString();
          } else {
            /// 张数 = usdt数量/委托价格/合约面值
            amount = (amount.toDecimal() /
                    (triggerPrice.toDecimal() *
                        state.contractInfo.value!.multiplier.toDecimal()))
                .ceil()
                .toString();
          }
        }
      }

      /// 开仓设置平仓时的止盈止损
      if (state.isStopLoss.value) {
        if (state.isMarketOrder.value) {
          // 市价单
          if (side == 'BUY') {
            // 市价开多止盈：触发价格需要大于当前最新成交价格/标记价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopWinPriceNum = stopWinTextController.text.toDecimal();
            if (stopWinPriceNum != Decimal.zero) {
              Decimal targetPrice =
                  state.stopWinPriceType.value == StopWinLosePriceType.lastPrice
                      ? state.contractInfo.value!.close.toDecimal()
                      : tagPrice.toDecimal();
              if (stopWinPriceNum <= targetPrice) {
                _showWaringDialog();
                return;
              }
            }

            // 市价开多止损:触发价格需要小于当前最新成交价格/标记价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopLosePriceNum = stopLossTextController.text.toDecimal();
            if (stopLosePriceNum != Decimal.zero) {
              Decimal targetPrice = state.stopLossPriceType.value ==
                      StopWinLosePriceType.lastPrice
                  ? state.contractInfo.value!.close.toDecimal()
                  : tagPrice.toDecimal();
              if (stopLosePriceNum >= targetPrice) {
                _showWaringDialog();
                return;
              }
            }
          } else {
            //  市价开空止盈:触发价格需要小于当前最新成交价格/标记价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopWinPriceNum = stopWinTextController.text.toDecimal();
            if (stopWinPriceNum != Decimal.zero) {
              Decimal targetPrice =
                  state.stopWinPriceType.value == StopWinLosePriceType.lastPrice
                      ? state.contractInfo.value!.close.toDecimal()
                      : tagPrice.toDecimal();
              if (stopWinPriceNum >= targetPrice) {
                _showWaringDialog();
                return;
              }
            }
            //  市价开空止损：触发价格需要大于当前最新成交价格/标记价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopLosePriceNum = stopLossTextController.text.toDecimal();
            if (stopLosePriceNum != Decimal.zero) {
              Decimal targetPrice = state.stopLossPriceType.value ==
                      StopWinLosePriceType.lastPrice
                  ? state.contractInfo.value!.close.toDecimal()
                  : tagPrice.toDecimal();
              if (stopLosePriceNum <= targetPrice) {
                _showWaringDialog();
                return;
              }
            }
          }
        } else {
          // 限价单
          if (side == 'BUY') {
            // 限价开多止盈：触发价格需要大于委托价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            // 限价开多止损：触发价格需要小于委托价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopWinPriceNum = stopWinTextController.text.toDecimal();
            if (stopWinPriceNum != Decimal.zero) {
              if (stopWinPriceNum <= triggerPrice.toDecimal()) {
                _showWaringDialog();
                return;
              }
            }
            Decimal stopLosePriceNum = stopLossTextController.text.toDecimal();
            if (stopLosePriceNum != Decimal.zero) {
              if (stopLosePriceNum >= triggerPrice.toDecimal()) {
                _showWaringDialog();
                return;
              }
            }
          } else {
            // 限价开空止盈：触发价格需要小于委托价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            // 限价开空止损：触发价格需要大于委托价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopWinPriceNum = stopWinTextController.text.toDecimal();
            if (stopWinPriceNum != Decimal.zero) {
              if (stopWinPriceNum >= triggerPrice.toDecimal()) {
                _showWaringDialog();
                return;
              }
            }
            Decimal stopLosePriceNum = stopLossTextController.text.toDecimal();
            if (stopLosePriceNum != Decimal.zero) {
              if (stopLosePriceNum <= triggerPrice.toDecimal()) {
                _showWaringDialog();
                return;
              }
            }
          }
        }
      }
    } else {
      if (state.percent.value != 0) {
        /// 张数 = 可平*百分比/合约面值
        /// 平多和平空的区分
        if (side == 'BUY') {
          amount = (state.canCloseEmptyAmount.value.toDecimal() *
                  state.percent.value.toDecimal() /
                  state.contractInfo.value!.multiplier.toDecimal())
              .ceil()
              .toString();
        } else {
          amount = (state.canCloseMoreAmount.value.toDecimal() *
                  state.percent.value.toDecimal() /
                  state.contractInfo.value!.multiplier.toDecimal())
              .ceil()
              .toString();
        }
      } else {
        if (state.isMarketOrder.value) {
          if (state.amountUnitIndex.value == 0) {
            /// 张数 = btc数量 / 合约面值
            amount = (amount.toDecimal() /
                    state.contractInfo.value!.multiplier.toDecimal())
                .ceil()
                .toString();
          } else {
            /// 张数 = usdt / 标记价格 / 合约面值
            amount = (amount.toDecimal() /
                    (tagPrice.toDecimal() *
                        state.contractInfo.value!.multiplier.toDecimal()))
                .ceil()
                .toString();
          }
        } else {
          /// 止盈止损
          if (state.amountUnitIndex.value == 0) {
            /// 张数 = btc数量 / 合约面值
            amount = (amount.toDecimal() /
                    state.contractInfo.value!.multiplier.toDecimal())
                .ceil()
                .toString();
          } else {
            /// 张数 = usdt数量 / 委托价格 / 合约面值
            amount = (amount.toDecimal() /
                    (triggerPrice.toDecimal() *
                        state.contractInfo.value!.multiplier.toDecimal()))
                .ceil()
                .toString();
          }
        }
      }
    }

    try {
      int volume = amount.toInt();
      if (volume == 0) {
        UIUtil.showToast(LocaleKeys.trade9.tr);
        return;
      }
      if (isCreatingOrder) return;
      isCreatingOrder = true;

      List<AttachAlgoOrdsReq> attachAlgoOrds = [];
      if (state.isStopLoss.value) {
        if (stopWinTextController.text.trim().isNotEmpty) {
          AttachAlgoOrdsReq algoOrdsReq = AttachAlgoOrdsReq(
              triggerType: 2,
              triggerPrice: stopWinTextController.text.trim().toNum(),
              triggerPxType:
                  state.stopWinPriceType.value == StopWinLosePriceType.lastPrice
                      ? 'last'
                      : 'tag');
          attachAlgoOrds.add(algoOrdsReq);
        }
        if (stopLossTextController.text.trim().isNotEmpty) {
          AttachAlgoOrdsReq algoOrdsReq = AttachAlgoOrdsReq(
              triggerType: 1,
              triggerPrice: stopLossTextController.text.trim().toNum(),
              triggerPxType: state.stopLossPriceType.value ==
                      StopWinLosePriceType.lastPrice
                  ? 'last'
                  : 'tag');
          attachAlgoOrds.add(algoOrdsReq);
        }
      }

      String attachAlgoOrdsStr = jsonEncode(attachAlgoOrds);

      CreateOrderReq req = CreateOrderReq(
        contractId: state.contractInfo.value!.id,
        positionType: state.userConfig.value?.marginModel ?? 1,
        side: side,
        leverageLevel: state.userConfig.value?.getNowLevel() ?? 20,
        price: '',
        volume: amount.toInt(),
        open: state.switchState.value == TransactionSwitchButtonValue.left
            ? 'OPEN'
            : 'CLOSE',
        type: 2,
        isConditionOrder: !state.isMarketOrder.value,
        expireTime: expireTime,
        isOto: false,
        isCheckLiq: 1,
        triggerPrice: triggerPrice,
        attachAlgoOrds: attachAlgoOrdsStr,
      );
      AppsFlyerManager().logEvent(AFLogEventName.add_order,);
      CommodityApi.instance().createOrder(req);
      CommodityEntrustController.to.fetchData();
      UIUtil.showSuccess(LocaleKeys.trade10.tr);
    } on DioException catch (e) {
      UIUtil.showToast(e.error);
    } catch (e) {
      UIUtil.showToast(LocaleKeys.trade11.tr);
    } finally {
      clear();
      isCreatingOrder = false;
    }
  }

  /// 计算可开仓数量
  void calculateCanOpenAmount() {
    if (!UserGetx.to.isLogin || state.contractInfo.value == null) {
      state.canOpenAmount.value = '--';
      return;
    }

    Decimal price = Decimal.zero;

    /// 市价单
    if (state.isMarketOrder.value) {
      ContractInfo? contractInfo = CommodityDataStoreController.to
          .getContractInfoByContractId(state.contractInfo.value!.id);
      if (contractInfo == null || contractInfo.esPrice == '0') {
        return;
      }
      if (contractInfo.esPrice != '0') {
        price = contractInfo.esPrice.toDecimal();
      } else if (contractInfo.close != '0') {
        price = contractInfo.close.toDecimal();
      }
    } else {
      if (priceTextController.text.trim().isEmpty) {
        state.canOpenAmount.value = '0';
        return;
      }
      price = priceTextController.text.trim().toDecimal();
    }
    if (price == Decimal.zero) {
      state.canOpenAmount.value = '0';
      return;
    }

    /// 单位是btc
    if (state.amountUnitIndex.value == 0) {
      state.canOpenAmount.value = ((state.availableBalance.value.toDecimal() *
                  (state.userConfig.value?.getNowLevel() ?? 20).toDecimal()) /
              price)
          .toDecimal(scaleOnInfinitePrecision: 10)
          .toPrecision(
              state.contractInfo.value?.multiplier.numDecimalPlaces() ?? 2)
          .toString();
    } else {
      /// 单位是usdt
      state.canOpenAmount.value = (state.availableBalance.value.toDecimal() *
              (state.userConfig.value?.getNowLevel() ?? 20).toDecimal())
          .toPrecision(state
                  .contractInfo.value?.coinResultVo?.symbolPricePrecision
                  .toInt() ??
              4);
    }
    // setAmountText();
  }

  /// 计算可平仓数量
  void calculateCanCloseAmount() {
    if (state.contractInfo.value == null) return;
    Decimal openMore = Decimal.zero;
    Decimal openEmpty = Decimal.zero;
    for (var element in CommodityPositionController.to.positionList) {
      if (element.contractId == state.contractInfo.value?.id) {
        if (element.orderSide == "BUY") {
          openMore += element.canCloseVolume.toDecimal();
        } else {
          openEmpty += element.canCloseVolume.toDecimal();
        }
      }
    }
    state.canCloseMoreAmount.value =
        (openMore * state.contractInfo.value!.multiplier.toDecimal())
            .toPrecision(state
                    .contractInfo.value?.coinResultVo?.symbolPricePrecision
                    .toInt() ??
                4);
    state.canCloseEmptyAmount.value =
        (openEmpty * state.contractInfo.value!.multiplier.toDecimal())
            .toPrecision(state
                    .contractInfo.value?.coinResultVo?.symbolPricePrecision
                    .toInt() ??
                4);
    // setAmountText();
  }

  /// 计算保证金
  /// 保证金 = 价格 * 数量 / 杠杆
  void calculateMargin() {
    if (state.contractInfo.value == null) {
      return;
    }

    Decimal price = Decimal.zero;

    /// 市价单
    if (state.isMarketOrder.value) {
      ContractInfo? contractInfo = CommodityDataStoreController.to
          .getContractInfoByContractId(state.contractInfo.value!.id);
      if (contractInfo == null || contractInfo.close == '0') {
        state.margin.value = null;
        return;
      }
      price = contractInfo.esPrice.toDecimal();
    } else {
      if (priceTextController.text.trim().isEmpty) {
        state.margin.value = null;
        return;
      }
      price = priceTextController.text.trim().toDecimal();
    }
    if (price == Decimal.zero) {
      state.margin.value = null;
      return;
    }

    Decimal amount = Decimal.zero;
    if (amountTextController.text.trim().isEmpty) {
      state.margin.value = null;
      return;
    }

    /// 百分比
    // if (amountTextController.text.trim().contains('%')) {
    if (state.percent.value != 0) {
      state.margin.value = (state.availableBalance.value.toDecimal() *
              (state.percent.value.toDecimal()))
          .toString()
          .toNum();
    } else {
      /// 数量
      amount = amountTextController.text.trim().toDecimal();

      /// 单位是btc,保证金 = 价格 * 数量 / 杠杆
      if (state.amountUnitIndex.value == 0) {
        state.margin.value = (price *
                amount /
                (state.userConfig.value?.getNowLevel() ?? 20).toDecimal())
            .toString()
            .toNum();
      } else {
        /// 单位是usdt,保证金 = 数量 / 杠杆
        state.margin.value =
            (amount / (state.userConfig.value?.getNowLevel() ?? 20).toDecimal())
                .toString()
                .toNum();
      }
    }
  }
}
