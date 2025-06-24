import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/ctc_message_api.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_main/controllers/assets_main_controller.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_mixin.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_top.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderWaitController extends GetxController with CustomerTimer {
  num? idNum;
  var model = CustomerOrderModel();
  Timer? refreshTimer;
  RefreshController refreshVC = RefreshController();

  CustomerOrderWaitController({CustomerOrderModel? argModel, num? argNum}) {
    if (argModel != null) {
      model = argModel;
    }
    if (argNum != null) {
      idNum = argNum;
    }
  }

  @override
  void onInit() {
    super.onInit();
    idNum = idNum ?? Get.arguments?['id'];
    CustomerOrderModel? paraModel = model.detailModel.sequence != null ? model : Get.arguments?['model'];

    if (paraModel == null) {
      getData();
    } else {
      model = paraModel;
      initTimer(model.detailModel.limitTime, model.detailModel.appealTime, model.detailModel.remainTime,
          f: (limitTime, appealTime, remainTime) {
        model.detailModel.limitTime = limitTime;
        model.detailModel.appealTimeNum = appealTime;
        model.detailModel.remainTime = remainTime;
      });
      getAdvertData();
    }

    refreshTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      refreshOrder();
    });
  }

  Future refreshOrder() {
    return AFCustomer.getOrderhWithId(id: idNum).then((value) {
      model.detailModel = value;
      model.detailModel.idNum = idNum;

      update();
    });
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
        model.detailModel.remainTime = remainTime;
      });
    });
  }

  Future getAdvertData({bool canUpdate = true}) {
    return AFCustomer.getAdvertChatWithId(id: idNum).then((value) {
      model.chartModel = value;
      if (canUpdate) update();
    });
  }

  goOrderAppeal() async {
    CustomerAlterView.showAppeal(appealTimeStr, () async {
      EasyLoading.show();
      var orderModel = await AFCustomer.getOrderhWithId(id: idNum);

      if (orderModel.complainId == null) {
        var res = await CtcMessageApi.instance().createProblem(model.detailModel.isBUy ? '8' : '9');
        num? complainId = res['complainId'];
        var value = await AFCustomer.getOrderComplaintWithId(id: idNum, complaintId: complainId);
        EasyLoading.dismiss();
        if (value == null) {
          Get.toNamed(Routes.C2C_APPEAL, arguments: (complainId ?? 0).toString());
        }
      } else {
        if (orderModel.isComplainUser) {
          Get.toNamed(Routes.C2C_APPEAL, arguments: (orderModel.complainId ?? 0).toString());
        } else {
          if (orderModel.toComplainId != null) {
            Get.toNamed(Routes.C2C_APPEAL, arguments: (orderModel.toComplainId ?? 0).toString());
          } else {
            var res = await CtcMessageApi.instance().createProblem('12');
            num? toComplaint = res['complainId'];

            var value = await AFCustomer.getOrderToComplaint(orderId: idNum, toComplaint: toComplaint);
            EasyLoading.dismiss();
            if (value == null) {
              Get.toNamed(Routes.C2C_APPEAL, arguments: (toComplaint ?? 0).toString());
            }
          }
        }
      }

      // CtcMessageApi.instance().createProblem(model.detailModel.isBUy ? '8' : '9').then((res) {
      //   num? complainId = res['complainId'];

      //   AFCustomer.getOrderComplaintWithId(id: idNum, complaintId: complainId).then((value) {
      //     if (value == null) {
      //       Get.toNamed(Routes.C2C_APPEAL, arguments: (complainId ?? 0).toString());
      //     }
      //   });
      // }).catchError((e) {
      //   UIUtil.showToast(e.error);
      // });
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

  goOtherOrder() {
    Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
  }

  goAsset() {
    Get.until((route) => Get.currentRoute == Routes.MAIN_TAB);
    MainTabController.to.jumpPage(4);
    AssetsMainController.navigateToFunding();
  }

  goOrderhelp() {
    Get.toNamed(Routes.ASSISTANCE, arguments: {'id': idNum, 'model': model.detailModel});
  }

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
