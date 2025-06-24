import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';

import '../controllers/follow_taker_info_controller.dart';

//

class FollowTakerInfoBinding extends Bindings {
  @override
  void dependencies() {
    String tag = TagCacheUtil().saveTag('FollowTakerInfoController');

    // Get.lazyPut<FollowTakerInfoController>(() => FollowTakerInfoController(), tag: '1');
    // Get.put(FollowTakerInfoController(), tag: 'assets', permanent: true);
  Get.lazyPut<FollowTakerInfoController>(() => FollowTakerInfoController(), tag: tag);
  }
}
