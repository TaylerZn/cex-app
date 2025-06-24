import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_mixin.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_top.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderHandleController extends GetxController with CustomerTimer {
  num? idNum;
  var model = CustomerOrderModel();
  RefreshController refreshVC = RefreshController();

  @override
  void onInit() {
    super.onInit();
    idNum = Get.arguments?['id'];
    var paraModel = Get.arguments?['model'];

    if (paraModel == null) {
      getData();
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
    getAdvertData();
    return AFCustomer.getOrderhWithId(id: idNum).then((value) {
      model.detailModel = value;
      model.detailModel.idNum = idNum;
      initTimer(model.detailModel.limitTime, model.detailModel.appealTime, model.detailModel.remainTime,
          f: (limitTime, appealTime, remainTime) {
        model.detailModel.limitTime = limitTime;
        model.detailModel.appealTimeNum = appealTime;
      });

      update();
    });
  }

  getAdvertData() {
    AFCustomer.getAdvertChatWithId(id: idNum).then((value) {
      model.chartModel = value;
      update();
    });
  }

  goOrderWait() {
    CustomerAlterView.showSurePay(() {
      AFCustomer.postOrderPayed(sequence: model.detailModel.sequenceStr, payment: model.detailModel.paymentKeyStr)
          .then((value) {
        if (value == null) {
          Get.toNamed(Routes.CUSTOMER_ORDER_WAIT, arguments: {'id': idNum, 'model': model});
        }
      });
    });
  }

  goOrderhelp() {
    Get.toNamed(Routes.ASSISTANCE, arguments: {'id': idNum, 'model': model.detailModel});
  }

  goOtherOrder() {
    Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    resetTimer();
  }
}
