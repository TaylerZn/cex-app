import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/price_info.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_operate_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_postion/controllers/contract_position_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../getX/assets_Getx.dart';
import '../../../../getX/user_Getx.dart';
import '../../../../models/contract/req/create_order_req.dart';
import '../../../../utils/appsflyer/apps_flyer_log_event_name.dart';
import '../../../../utils/appsflyer/apps_flyer_manager.dart';
import '../../../../utils/utilities/ui_util.dart';
import '../../../../widgets/components/transaction/transaction_switch_button.dart';
import '../../../../widgets/dialog/warning_dialog.dart';
import '../../contract_entrust/controllers/contract_entrust_controller.dart';
import '../models/order_type.dart';
import '../models/price_type.dart';

extension ContractOperateControllerCreateOrder on ContractOperateController {
  Future<void> _showWaringDialog() async {
    await WarningDialog.show(
      title: LocaleKeys.trade386.tr,
      icon: 'assets/images/trade/notice_warning.svg',
      okTitle: LocaleKeys.public76.tr,
    );
    stopWinTextController.clear();
    stopLossTextController.clear();
  }

  createOrder(String side) async {
    if (contractInfo.value == null) return;
    // 委托价
    var price = '0';
    // 过期时间
    String? expireTime = userConfig.value?.expireTime.toString();
    // 触发价
    String? triggerPrice;
    String amount = amountTextController.text.trim();
    bool isConditionOrder = false;

    switch (orderType.value) {
      case OrderType.limit:
        price = limitPriceTextController.text.trim();
        isConditionOrder = false;
        if (price.isEmpty) {
          UIUtil.showToast(LocaleKeys.trade64.tr);
          limitPriceFocusNode.requestFocus();
          return;
        }
        if (amount.isEmpty) {
          UIUtil.showToast(LocaleKeys.trade65.tr);
          amountFocusNode.requestFocus();
          return;
        }

        break;
      case OrderType.limitStop:
        price = limitEntrustPriceTextController.text.trim();
        triggerPrice = limitTriggerPriceTextController.text.trim();
        isConditionOrder = true;
        if (triggerPrice.isEmpty) {
          UIUtil.showToast(LocaleKeys.trade66.tr);
          limitTriggerPriceFocusNode.requestFocus();
          return;
        }
        if (price.isEmpty) {
          UIUtil.showToast(LocaleKeys.trade66.tr);
          limitEntrustPriceFocusNode.requestFocus();
          return;
        }
        if (amount.isEmpty) {
          UIUtil.showToast(LocaleKeys.trade65.tr);
          amountFocusNode.requestFocus();
          return;
        }
        break;
      case OrderType.market:
        isConditionOrder = false;
        if (amount.isEmpty) {
          UIUtil.showToast(LocaleKeys.trade65.tr);
          amountFocusNode.requestFocus();
          return;
        }
        break;
      case OrderType.marketStop:
        triggerPrice = marketTriggerPriceTextController.text.trim();
        isConditionOrder = true;
        if (triggerPrice.isEmpty) {
          UIUtil.showToast(LocaleKeys.trade66.tr);
          marketTriggerPriceFocusNode.requestFocus();
          return;
        }
        if (amount.isEmpty) {
          UIUtil.showToast(LocaleKeys.trade65.tr);
          amountFocusNode.requestFocus();
          return;
        }
        break;
    }

    PriceInfo? priceInfo = ContractDataStoreController.to
        .getPriceInfoBySubSymbol(contractInfo.value!.subSymbol);
    String tagPrice =
        priceInfo?.tagPrice.toString() ?? contractInfo.value!.close;

    // 平仓
    if (switchState.value == TransactionSwitchButtonValue.right) {
      // 市价单 volume 是 btc数量
      if (orderType.value.type == 2) {
        // 市价单 volume 是 btc数量
        if (amountUnitIndex.value == 0) {
          // 张数 = btc数量 / 合约面值
          amount =
              (amount.toDecimal() / contractInfo.value!.multiplier.toDecimal())
                  .ceil()
                  .toString();
        } else {
          // 张数 = usdt / 标记价格 / 合约面值
          amount = (amount.toDecimal() /
                  (tagPrice.toDecimal() *
                      contractInfo.value!.multiplier.toDecimal()))
              .ceil()
              .toString();
        }
      } else {
        if (amountUnitIndex.value == 0) {
          // 限价单 volume 是 btc数量
          // 张数 = btc数量 / 合约面值
          amount =
              (amount.toDecimal() / contractInfo.value!.multiplier.toDecimal())
                  .ceil()
                  .toString();
        } else {
          // 限价单 volume 是 usdt数量
          // 张数 = usdt数量 / 委托价格 / 合约面值
          amount = (amount.toDecimal() /
                  (price.toDecimal() *
                      contractInfo.value!.multiplier.toDecimal()))
              .ceil()
              .toString();
        }
      }
    } else {
      // 开仓
      // 市价单 volume 是 usdt数量
      if (orderType.value.type == 2) {
        if (amountUnitIndex.value == 0) {
          // btc
          // usdt数量 = 数量 * 标记价格
          amount = (amount.toDecimal() *
                  tagPrice.toDecimal() *
                  (1 + contractInfo.value!.slippage).toDecimal())
              .ceil()
              .toString();
        } else {
          // usdt
          // volume 是 usdt数量
          amount = amount.toString();
        }
      } else {
        // btc
        if (amountUnitIndex.value == 0) {
          /// 张数 = 数量/合约面值
          amount =
              (amount.toDecimal() / contractInfo.value!.multiplier.toDecimal())
                  .ceil()
                  .toString();
        } else {
          // usdt
          /// 张数 = usdt数量/委托价格/合约面值
          amount = (amount.toDecimal() /
                  (price.toDecimal() *
                      contractInfo.value!.multiplier.toDecimal()))
              .ceil()
              .toString();
        }
      }

      // 下单止盈止损的
      /// 开仓设置平仓时的止盈止损
      if (isStopLoss.value) {
        if (orderType.value.type == 2) {
          // 市价单
          if (side == 'BUY') {
            // 市价开多止盈：触发价格需要大于当前最新成交价格/标记价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopWinPriceNum = stopWinTextController.text.toDecimal();
            if (stopWinPriceNum != Decimal.zero) {
              Decimal targetPrice =
                  state.stopWinPriceType.value == StopWinLosePriceType.lastPrice
                      ? contractInfo.value!.close.toDecimal()
                      : tagPrice.toDecimal();
              if (stopWinPriceNum <= targetPrice) {
                await _showWaringDialog();
                return;
              }
            }

            // 市价开多止损:触发价格需要小于当前最新成交价格/标记价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopLosePriceNum = stopLossTextController.text.toDecimal();
            if (stopLosePriceNum != Decimal.zero) {
              Decimal targetPrice = state.stopLossPriceType.value ==
                      StopWinLosePriceType.lastPrice
                  ? contractInfo.value!.close.toDecimal()
                  : tagPrice.toDecimal();
              if (stopLosePriceNum >= targetPrice) {
                await _showWaringDialog();
                return;
              }
            }
          } else {
            //  市价开空止盈:触发价格需要小于当前最新成交价格/标记价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopWinPriceNum = stopWinTextController.text.toDecimal();
            if (stopWinPriceNum != Decimal.zero) {
              Decimal targetPrice =
                  state.stopWinPriceType.value == StopWinLosePriceType.lastPrice
                      ? contractInfo.value!.close.toDecimal()
                      : tagPrice.toDecimal();
              if (stopWinPriceNum >= targetPrice) {
                await _showWaringDialog();
                return;
              }
            }
            //  市价开空止损：触发价格需要大于当前最新成交价格/标记价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopLosePriceNum = stopLossTextController.text.toDecimal();
            if (stopLosePriceNum != Decimal.zero) {
              Decimal targetPrice = state.stopLossPriceType.value ==
                      StopWinLosePriceType.lastPrice
                  ? contractInfo.value!.close.toDecimal()
                  : tagPrice.toDecimal();
              if (stopLosePriceNum <= targetPrice) {
                await _showWaringDialog();
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
              if (stopWinPriceNum <= price.toDecimal()) {
                await _showWaringDialog();
                return;
              }
            }
            Decimal stopLosePriceNum = stopLossTextController.text.toDecimal();
            if (stopLosePriceNum != Decimal.zero) {
              if (stopLosePriceNum >= price.toDecimal()) {
                await _showWaringDialog();
                return;
              }
            }
          } else {
            // 限价开空止盈：触发价格需要小于委托价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            // 限价开空止损：触发价格需要大于委托价格，否则提示【您设置的止盈止损价格不合理，请重新设置】
            Decimal stopWinPriceNum = stopWinTextController.text.toDecimal();
            if (stopWinPriceNum != Decimal.zero) {
              if (stopWinPriceNum >= price.toDecimal()) {
                await _showWaringDialog();
                return;
              }
            }
            Decimal stopLosePriceNum = stopLossTextController.text.toDecimal();
            if (stopLosePriceNum != Decimal.zero) {
              if (stopLosePriceNum <= price.toDecimal()) {
                await _showWaringDialog();
                return;
              }
            }
          }
        }
      }
    }
    try {
      if (isCreateOrdering) return;
      isCreateOrdering = true;

      List<AttachAlgoOrdsReq> attachAlgoOrds = [];
      if (isStopLoss.value) {
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
        contractId: contractInfo.value!.id,
        positionType: userConfig.value?.marginModel ?? 1,
        side: side,
        leverageLevel: userConfig.value?.getNowLevel() ?? 20,
        price: price,
        volume: amount.toInt(),
        open: switchState.value == TransactionSwitchButtonValue.left
            ? 'OPEN'
            : 'CLOSE',
        type: orderType.value.type,
        isConditionOrder: isConditionOrder,
        expireTime: expireTime,
        isOto: false,
        isCheckLiq: 1,
        triggerPrice: triggerPrice,
        attachAlgoOrds: attachAlgoOrdsStr,
      );
      await ContractApi.instance().createOrder(req);
      AppsFlyerManager().logEvent(AFLogEventName.add_order);
      UIUtil.showSuccess(LocaleKeys.trade10.tr);
      Future.wait([
        ContractEntrustController.to.fetchData(),
        AssetsGetx.to.getTotalAccountBalance()
      ]);
      ContractPositionController.to.fetchData();
    } on DioException catch (e) {
      UIUtil.showToast(e.error);
    } catch (e) {
      UIUtil.showToast(LocaleKeys.trade11.tr);
    } finally {
      clear();
      isCreateOrdering = false;
    }
  }
}
