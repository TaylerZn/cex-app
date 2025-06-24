import 'package:get/get.dart';

import '../controllers/coupon_card_list_controller.dart';

class CouponCardListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponCardListController>(
      () => CouponCardListController(),
    );
  }
}
