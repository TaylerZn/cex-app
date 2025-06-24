import 'package:get/get.dart';

import '../controllers/message_list_controller.dart';


class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageListController>(
      () => MessageListController(),
    );
  }
}
