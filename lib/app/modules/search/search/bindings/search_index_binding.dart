import 'package:get/get.dart';

import '../controllers/search_index_controller.dart';

class SearchIndexBinding extends Bindings {
  @override
  void dependencies() {
    int currentIndex = Get.arguments?['currentIndex'] ?? 0;
    String searchText = Get.arguments?['searchText'] ?? '';
    dynamic argumentTabs = Get.arguments?['argumentTabs'];

    Get.lazyPut<SearchIndexController>(
      () => SearchIndexController(
          currentIndex: currentIndex,
          searchText: searchText,
          argumentTabs: argumentTabs),
    );
  }
}
