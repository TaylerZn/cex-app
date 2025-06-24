import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/asset_list_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/models/price_type.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/spot_goods/spot_goods_api.dart';
import '../../../../getX/assets_Getx.dart';
import '../../../../models/assets/assets_spots.dart';
import '../../../../utils/utilities/ui_util.dart';
import '../../../../widgets/components/transaction/transaction_switch_button.dart';

class SpotGoodsOperateController extends GetxController {
  static SpotGoodsOperateController get to =>
      Get.put(SpotGoodsOperateController(), permanent: true);

  /// 开单类型
  final priceType = StandPriceType.limit.obs;
  final coUnit = ''.obs;

  bool isCreatingOrder = false;

  setPriceType(StandPriceType type) {
    priceType.value = type;
    _clear();
  }

  /// 买入卖出
  var switchState = TransactionSwitchButtonValue.left.obs;

  setSwitchState(TransactionSwitchButtonValue value) {
    switchState.value = value;
    _clear();
  }

  RxDouble rightViewHeight = 380.h.obs;

  RxDouble amountPercent = 0.0.obs;

  setAmountPercent(double percent) {
    if (UserGetx.to.goIsLogin()) {
      amountPercent.value = percent;
      if (percent == 0) {
        amountTextController.clear();
        limitTurnoverTextController.clear();
        buyFee.value = '--';
        sellFee.value = '--';
        return;
      }
      _isUpdating = true;
      amountTextController.text = '${(percent * 100).toInt()}%';
      if (marketInfoModel == null) return;
      if (switchState.value == TransactionSwitchButtonValue.left) {
        /// 买入
        limitTurnoverTextController.value = TextEditingValue(
            text: (canBuyBalance.value.toDecimal() * percent.toDecimal())
                .toPrecision(
                    marketInfoModel?.spotOrderRes?.pricePrecision ?? 2));
      } else {
        /// 卖出
        limitTurnoverTextController.value = TextEditingValue(
            text: (canSellAmount.value.toDecimal() * percent.toDecimal())
                .toPrecision(
                    marketInfoModel?.spotOrderRes?.pricePrecision ?? 2));
      }
      _isUpdating = false;
      _calculateCanBuyFee();
      _calculateCanSellFee();
    }
  }

  // 数量输入框
  late TextEditingController amountTextController;
  FocusNode amountFocusNode = FocusNode();

  /// 价格
  late TextEditingController limitPriceTextController;
  FocusNode limitPriceFocusNode = FocusNode();

  /// 成交金额
  late TextEditingController limitTurnoverTextController;
  FocusNode limitTurnoverFocusNode = FocusNode();

  /// 可买
  final RxString canBuyAmount = '--'.obs;

  /// 手续费
  final RxString buyFee = '--'.obs;

  /// 可卖
  final RxString canSellAmount = '--'.obs;

  /// 手续费
  final RxString sellFee = '--'.obs;

  /// 当前币对可买可用余额
  Rx<String> canBuyBalance = '--'.obs;

  /// 可卖可用余额
  Rx<String> canSellBalance = '--'.obs;

  bool _isUpdating = false;

  @override
  void onInit() {
    limitPriceTextController = TextEditingController()
      ..addListener(() {
        var limitPrice = limitPriceTextController.text.trim();
        if (limitPrice.isNotEmpty) {
          _calculateCanBuyAmount();
          var amount = amountTextController.text.trim().formatDot();
          if (amount.isNotEmpty) {
            limitTurnoverTextController.text =
                (limitPrice.toDecimal() * amount.toDecimal())
                    .toString()
                    .toPrecision(
                        marketInfoModel?.spotOrderRes?.pricePrecision ?? 2);
            _calculateCanSellFee();
            _calculateCanBuyFee();
          }
        } else {
          canBuyAmount.value = '--';
          buyFee.value = '--';
          sellFee.value = '--';
          canSellAmount.value = '--';
          canSellBalance.value = '--';
        }
      });

    /// 数量获取焦点时，清除百分比
    amountFocusNode.addListener(() {
      if (amountFocusNode.hasFocus && amountPercent.value != 0) {
        amountPercent.value = 0;
        amountTextController.clear();
        limitTurnoverTextController.clear();
      }
    });
    amountTextController = TextEditingController()
      ..addListener(() {
        if (!_isUpdating) {
          Get.log('amountTextController +++++++');
          var limitPrice = limitPriceTextController.text.trim();
          var amount = amountTextController.text.trim();

          if (limitPrice.isNotEmpty && amount.isNotEmpty) {
            // 不是百分计算
            if (amountPercent.value == 0) {
              var turnover = (limitPrice.toDecimal() * amount.toDecimal())
                  .toString()
                  .toPrecision(
                      marketInfoModel?.spotOrderRes?.pricePrecision?.toInt() ??
                          2);
              _updateLimitTurnover(turnover);
            } else {
              // 百分比计算
            }
          } else {
            _clearLimitTurnover();
          }
        }
      });

    limitTurnoverTextController = TextEditingController()
      ..addListener(() {
        if (!_isUpdating) {
          Get.log('limitTurnoverTextController +++++++');
          var limitPrice = limitPriceTextController.text.trim();
          var turnover = limitTurnoverTextController.text.trim();

          if (limitPrice.isNotEmpty && turnover.isNotEmpty) {
            var amount = (turnover.toDecimal() / limitPrice.toDecimal())
                .toDecimal(
                    scaleOnInfinitePrecision:
                        marketInfoModel?.volume.toInt() ?? 2)
                .toPrecision(
                    marketInfoModel?.spotOrderRes?.volumePrecision ?? 2);
            _updateAmount(amount);
          }
        }
      });

    super.onInit();
    Bus.getInstance().on(EventType.login, (data) {
      _calculateCanBuyAmount();
    });
    Bus.getInstance().on(EventType.signOut, (data) {
      canBuyAmount.value = '--';
      buyFee.value = '--';
      sellFee.value = '--';
      canSellAmount.value = '--';
      canSellBalance.value = '--';
    });
    Bus.getInstance().on(EventType.refreshAsset, (data) {
      _getCurrentCoinAsset();
    });
  }

  @override
  void onClose() {
    limitPriceTextController.dispose();
    amountTextController.dispose();
    limitTurnoverTextController.dispose();
    super.onClose();
  }

  MarketInfoModel? marketInfoModel;

  changeMarketInfo(MarketInfoModel info) {
    marketInfoModel = info;
    _clear();
    coUnit.value = info.firstName;
    _getCurrentCoinAsset();
  }

  _getCurrentCoinAsset() {
    if (marketInfoModel == null) return;
    AssetSpotsAllCoinMapModel? model =
        AssetsGetx.to.assetSpots?.allCoinMap['USDT'];
    if (model != null) {
      canBuyBalance.value = (model.totalBalance!.toDecimal() -
              (model.lockBalance?.toDecimal() ?? Decimal.zero))
          .toPrecision(marketInfoModel?.spotOrderRes?.pricePrecision ?? 2);
      _calculateCanBuyAmount();
    }
  }

  _calculateCanSellFee() {
    if (marketInfoModel == null || !UserGetx.to.isLogin) return;

    /// 计算可卖
    switch (priceType.value) {
      case StandPriceType.limit:
        var limitTurnover = limitTurnoverTextController.text.trim().formatDot();
        if (limitTurnover.isEmpty) return;
        sellFee.value = (limitTurnover.toDecimal() *
                (marketInfoModel!.quoteFeeRate?.toDecimal() ?? Decimal.one))
            .toPrecision(marketInfoModel?.spotOrderRes?.pricePrecision ?? 2);
        break;
      case StandPriceType.market:
        var amount = amountTextController.text.trim().formatDot();
        if (amount.isEmpty) return;
        sellFee.value = (amount.toDecimal() *
                marketInfoModel!.close.toDecimal() *
                (marketInfoModel!.quoteFeeRate?.toDecimal() ?? Decimal.one))
            .toPrecision(
                marketInfoModel?.spotOrderRes?.pricePrecision?.toInt() ?? 2);
        break;
    }
  }

  _calculateCanBuyAmount() {
    if (marketInfoModel == null || !UserGetx.to.isLogin) return;

    /// 计算可买
    switch (priceType.value) {
      case StandPriceType.limit:
        if (limitPriceTextController.text.trim().isNotEmpty) {
          Decimal price = limitPriceTextController.text.trim().toDecimal();
          if (price != Decimal.zero) {
            canBuyAmount.value = (canBuyBalance.value.toDecimal() / price)
                .toDecimal(
                    scaleOnInfinitePrecision:
                        marketInfoModel?.spotOrderRes?.volumePrecision ?? 2)
                .toString();
          } else {
            canBuyAmount.value = '0';
          }
        }
        break;
      case StandPriceType.market:
        if (marketInfoModel!.close.toDecimal() != Decimal.zero) {
          canBuyAmount.value = (canBuyBalance.value.toDecimal() /
                  marketInfoModel!.close.toDecimal())
              .toDecimal(scaleOnInfinitePrecision: 4)
              .toString();
        } else {
          canBuyAmount.value = '0';
        }
        break;
    }
  }

  _calculateCanBuyFee() {
    if (marketInfoModel == null || !UserGetx.to.isLogin) return;
    var limitTurnover = limitTurnoverTextController.text.trim();
    var amount = amountTextController.text.trim();

    /// 计算可买手续费
    switch (priceType.value) {
      case StandPriceType.limit:
        buyFee.value = (limitTurnover.toDecimal() *
                (marketInfoModel!.quoteFeeRate ?? '1').toDecimal() /
                marketInfoModel!.close.toDecimal())
            .toDecimal(scaleOnInfinitePrecision: 10)
            .toPrecision(marketInfoModel?.spotOrderRes?.pricePrecision ?? 2);
        break;
      case StandPriceType.market:
        if (amountPercent.value == 0) {
          buyFee.value = (amount.toDecimal() *
                  (marketInfoModel!.quoteFeeRate ?? '1').toDecimal() /
                  marketInfoModel!.close.toDecimal())
              .toDecimal(scaleOnInfinitePrecision: 10)
              .toPrecision(marketInfoModel?.spotOrderRes?.pricePrecision ?? 2);
        } else {
          buyFee.value = (canBuyAmount.value.toDecimal() *
                  amountPercent.value.toDecimal() /
                  marketInfoModel!.close.toDecimal())
              .toDecimal(scaleOnInfinitePrecision: 10)
              .toPrecision(marketInfoModel?.spotOrderRes?.pricePrecision ?? 2);
        }
        break;
    }
  }

  _clear() {
    amountTextController.clear();
    limitTurnoverTextController.clear();
    limitPriceTextController.text = getPrice();
    amountPercent.value = 0.0;
    buyFee.value = '--';
    sellFee.value = '--';
  }

  String getPrice() {
    if (marketInfoModel != null) {
      int precision = marketInfoModel?.spotOrderRes?.pricePrecision ?? 2;
      return marketInfoModel!.close.toNum().toPrecision(precision);
    } else {
      return '';
    }
  }

  Future<void> createOrder() async {
    EasyLoading.show();
    try {
      if (marketInfoModel == null) return;
      var price = '';
      var amount = amountTextController.text.trim();

      if (switchState.value == TransactionSwitchButtonValue.left) {
        /// 买入
        if (priceType.value == StandPriceType.limit) {
          /// 限价
          if (limitPriceTextController.text.trim().isEmpty) {
            limitPriceFocusNode.requestFocus();
            UIUtil.showToast(LocaleKeys.trade64.tr);
            return;
          }
          price = limitPriceTextController.text.trim();
          if (amount.isEmpty) {
            amountFocusNode.requestFocus();
            UIUtil.showToast(LocaleKeys.trade65.tr);
            return;
          }

          /// 百分比
          if (amountPercent.value != 0) {
            amount = (canBuyAmount.value.toDecimal() *
                    amountPercent.value.toDecimal())
                .toString();
          } else {
            amount = amount;
          }
        } else {
          /// 市价
          if (amount.isEmpty) {
            amountFocusNode.requestFocus();
            UIUtil.showToast(LocaleKeys.trade65.tr);
            return;
          }
          price = '0';
          if (amountPercent.value != 0) {
            amount = (canBuyBalance.value.toDecimal() *
                    amountPercent.value.toDecimal())
                .toString();
          } else {
            amount = amount;
          }
        }
      } else {
        /// 卖出
        if (priceType.value == StandPriceType.limit) {
          /// 限价
          if (limitPriceTextController.text.trim().isEmpty) {
            limitPriceFocusNode.requestFocus();
            UIUtil.showToast(LocaleKeys.trade64.tr);
            return;
          }
          price = limitPriceTextController.text.trim();
          if (amount.isEmpty) {
            amountFocusNode.requestFocus();
            UIUtil.showToast(LocaleKeys.trade65.tr);
            return;
          }

          /// 百分比
          if (amountPercent.value != 0) {
            amount = (canSellBalance.value.toDecimal() *
                    amountPercent.value.toDecimal())
                .toString();
          } else {
            amount = amount;
          }
        } else {
          /// 市价
          if (amount.isEmpty) {
            amountFocusNode.requestFocus();
            UIUtil.showToast(LocaleKeys.trade65.tr);
            return;
          }
          price = '0';
          if (amountPercent.value != 0) {
            amount = (canSellBalance.value.toDecimal() *
                    amountPercent.value.toDecimal())
                .toString();
          } else {
            amount = amount;
          }
        }
      }

      if (isCreatingOrder) return;
      isCreatingOrder = true;
      int amountPrecision = priceType.value == StandPriceType.limit
          ? (marketInfoModel!.spotOrderRes!.volumePrecision ?? 1)
          : (marketInfoModel!.spotOrderRes!.pricePrecision ?? 1);
      final res = await SpotGoodsApi.instance().orderCreate(
        amount.toPrecision(amountPrecision),
        price.toPrecision(marketInfoModel?.spotOrderRes?.pricePrecision ?? 2),
        priceType.value.type,
        marketInfoModel!.symbol.replaceAll('-', '').toLowerCase(),
        switchState.value == TransactionSwitchButtonValue.left ? 'BUY' : 'SELL',
      );
      if (ObjectUtil.isNotEmpty(res)) {
        UIUtil.showSuccess(LocaleKeys.trade71.tr);
        SpotEntrustController.to.fetchData();
        AssetListController.to.refreshSpotAccountBalance();
        _clear();
        AssetsGetx.to.getRefresh();
      }
    } on DioException catch (e) {
      UIUtil.showError(e.error);
    } catch (e) {
      UIUtil.showError(LocaleKeys.trade72.tr);
      Get.log('error: $e');
    } finally {
      EasyLoading.dismiss();
      isCreatingOrder = false;
    }
  }
}

extension SpotGoodsOperateControllerX on SpotGoodsOperateController {
  void _updateLimitTurnover(String turnover) {
    _isUpdating = true;
    limitTurnoverTextController.value = TextEditingValue(text: turnover);
    _isUpdating = false;
    _calculateCanBuyFee();
    _calculateCanSellFee();
  }

  void _clearLimitTurnover() {
    _isUpdating = true;
    limitTurnoverTextController.clear();
    _isUpdating = false;
  }

  void _updateAmount(String amount) {
    _isUpdating = true;
    amountTextController.value = TextEditingValue(text: amount);
    _isUpdating = false;
    _calculateCanBuyFee();
    _calculateCanSellFee();
  }
}
