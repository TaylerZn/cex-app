import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';

import '../controllers/hot_detail_topic_controller.dart';

class HotDetailTopicBinding extends Bindings {
  @override
  void dependencies() {
    String tag= TagCacheUtil().saveTag('HotDetailTopicController');

    Get.lazyPut<HotDetailTopicController>(
      tag: tag,
      () => HotDetailTopicController(),
    );
  }
}
