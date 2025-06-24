import 'package:get/get.dart';
import '../controllers/follow_orders_controller.dart';

//

class FollowOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FollowOrdersController>(FollowOrdersController());
  }
}
