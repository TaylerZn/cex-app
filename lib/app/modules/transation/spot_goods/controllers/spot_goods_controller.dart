import 'package:flutter/cupertino.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/spot_goods/spot_goods_api.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/asset_list_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_depth_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_goods_operate_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';

import '../../../../widgets/components/guide/guide_index_view.dart';

class SpotGoodsController extends GetxController {
  static SpotGoodsController get to => Get.find();
  late BuildContext context;

  Rxn<MarketInfoModel> marketInfo = Rxn<MarketInfoModel>();

  @override
  void onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.login, (data) {
      Get.forceAppUpdate();
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    if (SpotDataStoreController.to.spotList.isEmpty) {
      await SpotDataStoreController.to.getPublicInfoMarket();
    }
    MarketInfoModel? info = SpotDataStoreController.to.spotList.safeFirst;
    if (info != null) {
      changeMarketInfo(info);
    }
  }

  void showGuideView() {
    if (UserGetx.to.isLogin) {
      Intro.of(context).start(reset: false, group: AppGuideType.spot.name);
    }
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.login, (data) {});
    super.onClose();
  }
}

extension SpotGoodsControllerExt on SpotGoodsController {
  Future<void> changeMarketInfo(MarketInfoModel info) async {
    try {
      await _fetchMarketDetail(info);
    } catch (e) {}
    marketInfo.value = info;
    AssetListController.to.getCurrentCoinMap();
    SpotDepthController.to.changeMarketInfo(info);
    SpotEntrustController.to.changeMarketInfo(info);
    SpotGoodsOperateController.to.changeMarketInfo(info);
  }

  Future<void> _fetchMarketDetail(MarketInfoModel info) async {
    final res = await SpotGoodsApi.instance().orderListNew(
      null,
      null,
      1,
      10,
      info.symbol,
    );
    info.spotOrderRes = res;
  }
}
