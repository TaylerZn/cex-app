import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderCancelController extends GetxController {
  num? idNum;
  var model = CustomerOrderModel();
  RefreshController refreshVC = RefreshController();

  CustomerOrderCancelController({CustomerOrderModel? argModel, num? argNum}) {
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
      getAdvertData();
    }
  }

  Future getData() {
    getAdvertData();
    return AFCustomer.getOrderhWithId(id: idNum).then((value) {
      model.detailModel = value;
      update();
    });
  }

  getAdvertData() {
    AFCustomer.getAdvertChatWithId(id: idNum).then((value) {
      model.chartModel = value;
      update();
    });
  }

  goOtherOrder() {
    Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
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
  }
}
