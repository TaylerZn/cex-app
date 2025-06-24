import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/controllers/community_list_controller.dart';

class CommunityListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityListController>(() {
      var uid = Get.arguments['uid'];
      return CommunityListController(
        uid: uid,
      );
    });
  }
}
