import 'package:get/get.dart';

import '../controllers/community_message_controller.dart';

class CommunityMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityMessageController>(
      () => CommunityMessageController(),
    );
  }
}
