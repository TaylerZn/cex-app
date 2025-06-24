import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';

import '../controllers/community_info_controller.dart';

class CommunityInfoBinding extends Bindings {
  @override
  void dependencies() {
    String tag = TagCacheUtil().saveTag('CommunityInfoController');
    Get.lazyPut<CommunityInfoController>(() => CommunityInfoController(),
        tag: tag);
  }
}
