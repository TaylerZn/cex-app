import 'package:get/get.dart';

import '../controllers/follow_user_review_controller.dart';

class FollowUserReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowUserReviewController>(
      () => FollowUserReviewController(),
    );
  }
}
