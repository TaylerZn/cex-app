import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/trade/convert_create_order.dart';

class ImmediateExchangeDetailController extends GetxController {
  //TODO: Implement ImmediateExchangeDetailController

  ConvertCreateOrder? orderModel;
  @override
  void onInit() {
    super.onInit();
    orderModel = Get.arguments as ConvertCreateOrder?;
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
