import 'package:get/get.dart';

import '../controllers/community_message_notification_controller.dart';

class CommunityMessageNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityMessageNotificationController>(
      () => CommunityMessageNotificationController(),
    );
  }
}
