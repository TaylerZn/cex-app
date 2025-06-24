import 'package:get/get.dart';
import '../controllers/email_index_controller.dart';

class MySafeEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeEmailController>(
      () => MySafeEmailController(),
    );
  }
}
