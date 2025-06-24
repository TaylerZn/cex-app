import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/my/safe/withdrawal/index/controllers/withdrawal_index_controller.dart';
import 'package:nt_app_flutter/app/modules/my/safe/withdrawal/index/views/withdrawal_index_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_mixin.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_top.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerDealOrderController extends GetxController with CustomerTimer {
  num? idNum;
  var model = CustomerOrderModel();
  Timer? refreshTimer;
  RefreshController refreshVC = RefreshController();
  @override
  void onInit() {
    super.onInit();
    idNum = Get.arguments?['id'];
    bool refresh = Get.arguments?['refresh'] ?? true;
    var paraModel = Get.arguments?['model'];

    if (paraModel == null) {
      getData();
      if (refresh) {
        refreshTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
          refreshOrder();
        });
      }
    } else {
      model = paraModel;
      initTimer(model.detailModel.limitTime, model.detailModel.appealTime, model.detailModel.remainTime,
          f: (limitTime, appealTime, remainTime) {
        model.detailModel.limitTime = limitTime;
        model.detailModel.appealTimeNum = appealTime;
      });
      getAdvertData();
    }
  }

  Future getData() {
    return Future.wait([getAdvertData(canUpdate: false), getOrder()]).then((value) => update());
  }

  Future getOrder() {
    return AFCustomer.getOrderhWithId(id: idNum).then((value) {
      model.detailModel = value;
      model.detailModel.idNum = idNum;
      initTimer(model.detailModel.limitTime, model.detailModel.appealTime, model.detailModel.remainTime,
          f: (limitTime, appealTime, remainTime) {
        model.detailModel.limitTime = limitTime;
        model.detailModel.appealTimeNum = appealTime;
      });
    });
  }

  Future getAdvertData({bool canUpdate = true}) {
    return AFCustomer.getAdvertChatWithId(id: idNum).then((value) {
      model.chartModel = value;
      if (canUpdate) update();
    });
  }

  Future refreshOrder() {
    return AFCustomer.getOrderhWithId(id: idNum).then((value) {
      model.detailModel = value;
      model.detailModel.idNum = idNum;

      update();
    });
  }

  cacelOrder() {
    CustomerAlterView.showSureCancelOrder(model.detailModel, () {
      AFCustomer.postOrderCancel(sequence: model.detailModel.sequenceStr).then((value) {
        if (value == null) {
          Get.toNamed(Routes.CUSTOMER_ORDER_CANCEL, arguments: {'id': idNum, 'model': model});
        }
      });
    });
  }

  goOrderTrade() {
    Get.toNamed(Routes.CUSTOMER_ORDER_HANDLE, arguments: {'id': idNum, 'model': model});
  }

  goOtherOrder() {
    Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
  }

  sellOrder() async {
    var data = await showMyBottomDialog(
        Get.context,
        const MySafeWithdrawalView(
          verifCount: 1,
        ),
        padding: EdgeInsets.fromLTRB(24.w, 34.h, 24.w, 16.h),
        isDismissible: false);

    Get.delete<MySafeWithdrawalController>();
    if (ObjectUtil.isEmpty(data)) {
      Get.back();
      return;
    }

    //{smsCode: , emailCode: 123456, googleCode: }

    String code = '';
    int checkType = -1;
    String? sms = data?['smsCode'];
    String? email = data?['emailCode'];
    String? google = data?['googleCode'];

    if (sms?.isNotEmpty == true) {
      code = sms!;
      checkType = 2;
    } else if (email?.isNotEmpty == true) {
      code = email!;
      checkType = 3;
    } else if (google?.isNotEmpty == true) {
      code = google!;
      checkType = 1;
    }
    if (checkType > 0) {
      AFCustomer.postOrderConfirm(sequence: model.detailModel.sequenceStr, checkType: checkType, code: code).then((value) {
        if (value == null) {
          Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
          UIUtil.showSuccess(LocaleKeys.c2c298.tr);
        }
      });
    }
  }

  bool get isBuy => model.detailModel.isBUy;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    resetTimer();
    refreshTimer?.cancel();
  }
}
