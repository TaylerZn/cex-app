import 'package:get/get.dart';
import '../controllers/mobile_index_controller.dart';

class MySafeMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeMobileController>(
      () => MySafeMobileController(),
    );
  }
}
