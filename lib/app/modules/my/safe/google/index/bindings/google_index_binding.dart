import 'package:get/get.dart';
import '../controllers/google_index_controller.dart';

class MySafeGoogleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeGoogleController>(
      () => MySafeGoogleController(),
    );
  }
}
