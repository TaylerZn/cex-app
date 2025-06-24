import 'package:get/get.dart';
import '../controllers/email_bind_controller.dart';

class MySafeEmailBindBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeEmailBindController>(
      () => MySafeEmailBindController(),
    );
  }
}
