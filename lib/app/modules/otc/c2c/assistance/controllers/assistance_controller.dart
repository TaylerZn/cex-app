import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/ctc_message_api.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/complain_countdown_dialog.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

class AssistanceController extends GetxController {
  CustomerOrderDetailModel? model;
  final count = 0.obs;
  int idNum = 0;
  num complaintId = 0;

  @override
  void onInit() {
    super.onInit();
    model = Get.arguments?['model'];
    idNum = Get.arguments?['id'] ?? 0;
  }

  Future<void> complaintOrder() async {
    EasyLoading.show();
    var detailValue = await AFCustomer.getOrderhWithId(id: idNum);
    model = detailValue;
    if (detailValue.complainId == null) {
      try {
        var res = await CtcMessageApi.instance().createProblem(detailValue.isBUy == true ? '8' : '9');
        num? complainId = res['complainId'];
        var value = await AFCustomer.getOrderComplaintWithId(id: idNum, complaintId: complainId);
        EasyLoading.dismiss();

        if (value == null) {
          Get.dialog(ComplainCountDownDialog(
              complainId: '$complainId',
              seconds: countdownTime(),
              goToCustomer: () {
                Get.offAndToNamed(Routes.C2C_APPEAL, arguments: '$complainId');
              }));
        }
      } on dio.DioException catch (e) {
        EasyLoading.dismiss();

        UIUtil.showError('${e.error}');
      }
    } else {
      if (detailValue.isComplainUser) {
        EasyLoading.dismiss();

        Get.toNamed(Routes.C2C_APPEAL, arguments: (detailValue.complainId ?? 0).toString());
      } else {
        if (detailValue.toComplainId == null) {
          try {
            var res = await CtcMessageApi.instance().createProblem('12');
            num? toComplaint = res['complainId'];
            var value = await AFCustomer.getOrderToComplaint(orderId: idNum, toComplaint: toComplaint);
            EasyLoading.dismiss();
            if (value == null) {
              Get.dialog(ComplainCountDownDialog(
                  complainId: '$toComplaint',
                  seconds: countdownTime(),
                  goToCustomer: () {
                    Get.offAndToNamed(Routes.C2C_APPEAL, arguments: '$toComplaint');
                  }));
            }
          } on dio.DioException catch (e) {
            UIUtil.showError('${e.error}');
          }
        } else {
          EasyLoading.dismiss();

          Get.dialog(ComplainCountDownDialog(
              complainId: '${detailValue.toComplainId}',
              seconds: countdownTime(),
              goToCustomer: () {
                Get.offAndToNamed(Routes.C2C_APPEAL, arguments: '${detailValue.toComplainId}');
              }));
        }
      }
    }

    // if (complaintId != 0) {
    //   Get.dialog(ComplainCountDownDialog(
    //       complainId: '$complaintId',
    //       seconds: countdownTime(),
    //       goToCustomer: () {
    //         Get.offAndToNamed(Routes.C2C_APPEAL, arguments: '$complaintId');
    //       }));
    //   return;
    // }

    // num id = model?.complainId ?? 0;
    // complaintId = id;
    // if (id == 0) {
    //   EasyLoading.show();
    //   dynamic data = await CtcMessageApi.instance().createProblem(model?.isBUy == true ? '8' : '9');
    //   id = data['complainId'];
    //   complaintId = id;

    //   try {
    //     dynamic response = await OtcApi.instance().getOrderComplaintWithId(
    //       id: '$idNum',
    //       complaintId: '$id',
    //     );
    //     EasyLoading.dismiss();
    //     if (response == null) {
    //       Get.dialog(ComplainCountDownDialog(
    //           complainId: '$id',
    //           seconds: countdownTime(),
    //           goToCustomer: () {
    //             Get.offAndToNamed(Routes.C2C_APPEAL, arguments: '$complaintId');
    //           }));
    //     } else {
    //       Get.dialog(ComplainCountDownDialog(
    //           complainId: '$id',
    //           seconds: countdownTime(),
    //           goToCustomer: () {
    //             Get.offAndToNamed(Routes.C2C_APPEAL, arguments: '$complaintId');
    //           }));
    //     }
    //   } on dio.DioException catch (e) {
    //     UIUtil.showError('${e.error}');
    //   }
    // } else {
    //   Get.dialog(ComplainCountDownDialog(
    //       complainId: '$complaintId',
    //       seconds: countdownTime(),
    //       goToCustomer: () {
    //         Get.offAndToNamed(Routes.C2C_APPEAL, arguments: '$complaintId');
    //       }));
    // }
  }

  int countdownTime() {
    int timestampToSeconds(int timestamp) {
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return date.second;
    }

    if (model?.isMerchant == true) {
      return timestampToSeconds(model?.buyerTimeOffset ?? 0);
    }
    return timestampToSeconds(model?.sellerTimeOffset ?? 0);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
