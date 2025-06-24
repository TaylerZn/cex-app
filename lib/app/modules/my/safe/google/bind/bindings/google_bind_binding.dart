import 'package:get/get.dart';
import '../controllers/google_bind_controller.dart';

class MySafeGoogleBindBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeGoogleBindController>(
      () => MySafeGoogleBindController(),
    );
  }
}
