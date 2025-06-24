import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/ctc_message_api.dart';
import 'package:nt_app_flutter/app/modules/my/safe/withdrawal/index/views/withdrawal_index_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_top.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderAppealController extends GetxController {
  num? idNum;
  var model = CustomerOrderModel();
  RefreshController refreshVC = RefreshController();

  CustomerOrderAppealController({CustomerOrderModel? argModel, num? argNum}) {
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

    var complainUserId = paraModel?.detailModel.complainUserId;

    if (complainUserId != null && complainUserId != -1) {
      model = paraModel!;
      getAdvertData();
    } else {
      getData();
    }
  }

  Future getData() {
    getAdvertData();
    return AFCustomer.getOrderhWithId(id: idNum).then((value) {
      model.detailModel = value;
      model.detailModel.idNum = idNum;
      update();
    });
  }

  getAdvertData() {
    AFCustomer.getAdvertChatWithId(id: idNum).then((value) {
      model.chartModel = value;
      update();
    });
  }

  goOrderCancelAppeal() {
    CustomerAlterView.showAppealCancel(() {
      AFCustomer.postOrderComplainCancel(id: idNum).then((value) {
        if (value == null) {
          Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
          UIUtil.showSuccess(LocaleKeys.c2c299.tr);
        }
      });
    });
  }

  goOrderhelp() async {
    if (model.detailModel.isComplainUser) {
      Get.toNamed(Routes.C2C_APPEAL, arguments: (model.detailModel.complainId ?? 0).toString());
    } else {
      if (model.detailModel.toComplainId != null) {
        Get.toNamed(Routes.C2C_APPEAL, arguments: (model.detailModel.toComplainId ?? 0).toString());
      } else {
        EasyLoading.show();
        var res = await CtcMessageApi.instance().createProblem('12');
        num? toComplaint = res['complainId'];
        model.detailModel.toComplainId = toComplaint;
        var value = await AFCustomer.getOrderToComplaint(orderId: idNum, toComplaint: toComplaint);
        EasyLoading.dismiss();

        if (value == null) {
          Get.toNamed(Routes.C2C_APPEAL, arguments: (toComplaint ?? 0).toString());
        }
      }
    }
  }

  goOtherOrder() {
    Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
  }

  // goOrderSurePay() async {
  //   var data = await showMyBottomDialog(
  //       Get.context,
  //       const MySafeWithdrawalView(
  //         verifCount: 1,
  //       ),
  //       padding: EdgeInsets.fromLTRB(24.w, 34.h, 24.w, 16.h),
  //       isDismissible: false);

  //   //{smsCode: , emailCode: 123456, googleCode: }

  //   String code = '';
  //   int checkType = -1;
  //   String? sms = data?['smsCode'];
  //   String? email = data?['smsemailCodeCode'];
  //   String? google = data?['googleCode'];

  //   if (sms?.isNotEmpty == true) {
  //     code = sms!;
  //     checkType = 2;
  //   } else if (email?.isNotEmpty == true) {
  //     code = email!;
  //     checkType = 3;
  //   } else if (google?.isNotEmpty == true) {
  //     code = google!;
  //     checkType = 1;
  //   }

  //   AFCustomer.postOrderConfirm(sequence: model.detailModel.sequenceStr, checkType: checkType, code: code).then((value) {
  //     if (value == null) {
  //       Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
  //       UIUtil.showSuccess(LocaleKeys.c2c298.tr);
  //     }
  //   });
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
