import 'package:get/get.dart';

class AssociatedAccountController extends GetxController {
  final type = "".obs;
  final data = "".obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      type.value = Get.arguments['type'];
      data.value = Get.arguments['data'];
    }
    super.onInit();
  }
}
