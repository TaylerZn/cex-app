import 'package:get/get.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';

class DelAccountSuccessController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  onSubmit() async {
    Get.untilNamed(Routes.MAIN_TAB);
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
