import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_advert.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_top.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerDealController extends GetxController with GetTickerProviderStateMixin {
  String? idStr;
  String? coinStr;
  String? coinSymbolStr;
  Function? callback;

  bool isBuy = true;
  var model = CustomerAdvertDetailModel();
  var str = ''.obs;
  var textController = TextEditingController().obs;
  var focusNode = FocusNode();
  var showError = false.obs;
  var selectIndex = (-1).obs;
  String get title => isBuy ? LocaleKeys.c2c203.tr : LocaleKeys.c2c266.tr;
  late Timer _timer;
  late AnimationController animationController;
  RefreshController refreshVC = RefreshController();

  @override
  void onInit() {
    super.onInit();
    idStr = Get.arguments?['id'];
    coinStr = Get.arguments?['coin'];
    coinSymbolStr = Get.arguments?['coinSymbol'];
    callback = Get.arguments?['callback'];

    isBuy = Get.arguments?['isBuy'];
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    focusNode.addListener(_onFocusChange);
    startPeriodicRefresh();
  }

  void _onFocusChange() {
    if (!focusNode.hasFocus) {
      checkText();
    }
  }

  checkText() {
    var text = textController.value.text.toDouble();
    model.valueNum = text;
    if (model.isBUy) {
      showError.value = textController.value.text.isEmpty ? false : (text > model.maxTradeNum || text < model.minTradeNum);
    } else {
      if (text > model.currentUserBalance) {
        showError.value = true;
      } else {
        showError.value = textController.value.text.isEmpty ? false : (text > model.maxTradeNum || text < model.minTradeNum);
      }
    }

    model.userBalanceStr.value = model.userBalance;
  }

  setMaxAmount() {
    if (model.maxTradeNum > model.remainValueNum) {
      textController.update((val) {
        val?.text = model.remainValueNum.toString();
        str.value = val?.text ?? '';
      });
    } else {
      textController.update((val) {
        val?.text = model.maxTradeNum.toString();
        str.value = val?.text ?? '';
      });
    }
    checkText();
  }

  Future getData() {
    return refreshPrice();
  }

  Future refreshPrice() {
    animationController.repeat();
    return AFCustomer.getAdertRefreshWithId(id: idStr, coin: coinStr).then((value) {
      if (value.price != null) {
        model.price = value.price!;
        checkText();
        update();
      }
      animationController.stop();
    });
  }

  void startPeriodicRefresh() {
    refreshPrice();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      refreshPrice();
    });
  }

  placeAnOrde() {
    // Get.toNamed(Routes.CUSTOMER_DEAL_ORDER, arguments: {'id': 50});
    // return;
    if (selectIndex.value > -1 && showError.value == false && model.avaiableNum.value.isNotEmpty) {
      if (model.isBUy) {
        AFCustomer.postAdvertPurchase(
                advertId: model.id,
                totalPrice: textController.value.text.toDouble(),
                price: model.price,
                payment: model.paymentList![selectIndex.value].key)
            .then((value) {
          if (value.id != null) {
            if (value.isCreateOrder) {
              callback?.call();
              Get.toNamed(Routes.CUSTOMER_DEAL_ORDER, arguments: {'id': value.id ?? 0, 'refresh': false});
            } else {
              CustomerAlterView.showProceedOrder(() {
                OtcConfigUtils.goOrderDetail(status: value.status ?? 1, orderId: value.id ?? 0, isBuy: value.isBUy);
              });
            }
          }
        });
      } else {
        AFCustomer.postAdvertSell(
          advertId: model.id,
          volume: textController.value.text.toDouble(),
          price: model.price,
          payment: model.paymentList![selectIndex.value].key,
        ).then((value) {
          if (value.id != null) {
            if (value.isCreateOrder) {
              callback?.call();
              Get.toNamed(Routes.CUSTOMER_DEAL_ORDER, arguments: {'id': value.id ?? 0});
            } else {
              CustomerAlterView.showProceedOrder(() {
                OtcConfigUtils.goOrderDetail(status: value.status ?? 1, orderId: value.id ?? 0, isBuy: value.isBUy);
              });
            }
          }
        });
      }
    }
  }

  getAdertData() {
    AFCustomer.getAdertWithId(id: idStr).then((value) {
      model = value;
      update();
    });
  }

  addpayment() {
    Get.toNamed(Routes.PAYMENT_CHANNEL, arguments: {'isReceiver': true});
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }
}
