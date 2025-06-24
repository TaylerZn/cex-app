import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/captcha_Getx.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/public_Getx.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/getX/videoEditor_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/contract_favorite_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_manager.dart';
import 'package:nt_app_flutter/app/utils/fcm/fcm_utils.dart';
import 'package:nt_app_flutter/app/utils/lang_cache/lang_cache_manager.dart';
import 'package:nt_app_flutter/app/utils/utilities/device_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';

import '../../../getX/notify_Getx.dart';
import '../../../global/dataStore/commodity_data_store_controller.dart';
import '../../../global/dataStore/spot_data_store_controller.dart';
import '../../../global/favorite/spot_favorite_controller.dart';

class SplashController extends GetxController {
  bool hasNavigated = false;

  @override
  void onInit() {
    ///设备的相关信息初始化
    DeviceUtil.init();

    //Public初始化
    Get.put<PublicGetx>(PublicGetx());

    //LinksGetx初始化
    Get.put<LinksGetx>(LinksGetx());

    //用户信息初始化
    Get.put<UserGetx>(UserGetx());

    //资产初始化
    Get.put<AssetsGetx>(AssetsGetx());

    //验证器初始化
    Get.put(CaptchaService()).init(language: 'en');

    //areaCode初始化
    Get.put<AreaGetx>(AreaGetx());

    //获取safe初始化
    Get.put<SafeGetx>(SafeGetx());

    //视频剪辑初始化
    Get.put<VideoEditorGetx>(VideoEditorGetx());

    //公告初始化
    Get.put<NoticeGetx>(NoticeGetx());
    super.onInit();

  }

  @override
  Future<void> onReady() async {
    super.onReady();

    /// 根据用户信息加载相应的语言包
    try {
      AppsFlyerManager().init();
      ContractDataStoreController.to.fetchPublicInfo();
      SpotDataStoreController.to.getPublicInfoMarket();
      CommodityDataStoreController.to.fetchPublicInfo();
      OtcConfigUtils.getPublicInfo(); //OTC
      if (UserGetx.to.isLogin) {
        ContractOptionController.to.fetchOptionContractIdList();
        SpotOptionController.to.fetchOptionSpotSymbolList();
        CommodityOptionController.to.fetchOptionContractIdList();
        FcmUtils.updateToken(sToken);
        AppGuideView.getUserNewGuide();
      }
    } catch (e) {
      AppLogUtil.e(e.toString());
    } finally {
      if (!hasNavigated) {
        hasNavigated = true;
        Get.offAllNamed(Routes.MAIN_TAB);
      }
    }
  }
}
