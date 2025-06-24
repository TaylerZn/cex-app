import 'package:get/get.dart';
import '../controllers/mobile_bind_controller.dart';

class MySafeMobileBindBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeMobileBindController>(
      () => MySafeMobileBindController(),
    );
  }
}
