import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';

import '../controllers/community_video_info_controller.dart';

class CommunityVideoInfoBinding extends Bindings {
  @override
  void dependencies() {
    String tag = TagCacheUtil().saveTag('CommunityVideoInfoController');
    Get.lazyPut<CommunityVideoInfoController>(
        () => CommunityVideoInfoController(),
        tag: tag);
  }
}
