import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_contract/controllers/assets_contract_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_follow/controllers/assets_follow_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/controllers/assets_overview_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots/controllers/assets_spots_controller.dart';

import '../../../assets/assets_main/controllers/assets_main_controller.dart';

class AssetsMainBinding extends Bindings {
  @override
  void dependencies() {
    if (UserGetx.to.isLogin) {
      Get.put(AssetsFollowController());
      Get.put(AssetsContractController());
      Get.put(AssetsOverviewController());
      Get.put(AssetsSpotsController());
    }
    Get.put(AssetsMainController(), permanent: true);
  }
}
