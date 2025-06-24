import 'package:get/get.dart';

import '../controllers/webview_controller.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    String url = Get.arguments['url'];
    String? title = Get.arguments['title'];

    Get.lazyPut<WebPageController>(
      () => WebPageController(url: url, title: title ?? ''),
    );
  }
}
