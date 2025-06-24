import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/app_remote_config_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/contract_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/spot_favorite_controller.dart';

import '../../../getX/home_banner_swiper_Getx.dart';
import '../../../getX/quick_entry_expansion_get_x.dart';
import '../../home/controllers/home_index_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppRemoteConfigController(), permanent: true);
    Get.put(ContractOptionController(), permanent: true);
    Get.put(SpotOptionController(), permanent: true);
    Get.put(CommodityOptionController(), permanent: true);
    Get.put(ContractDataStoreController(), permanent: true);
    Get.put(SpotDataStoreController(), permanent: true);
    Get.put(CommodityDataStoreController(), permanent: true);
    Get.put<SplashController>(SplashController());
    Get.put<HomeBannerSwiperGetX>(HomeBannerSwiperGetX());
    Get.put<QuickEntryExpansionGetx>(QuickEntryExpansionGetx());
    Get.put(HomeIndexController());
  }
}
