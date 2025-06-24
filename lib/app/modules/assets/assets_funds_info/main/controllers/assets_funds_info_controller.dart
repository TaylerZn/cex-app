import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_funds.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds_info/main/enum/c2c_transaction_enum.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds_info/main/model/assets_funds_tab_model.dart';

import 'package:nt_app_flutter/app/modules/assets/assets_spots_info/model/assets_spots_info_model.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/models/community/activity.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';

class AssetsFundsInfoController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int currentIndex = 0;
  AssetsFundsAllCoinMapModel data = Get.arguments['data'];
  int fundsIndex = Get.arguments['index'];

  late TabController tabController;
  final RefreshController refreshController = RefreshController();
  final List<AssetsFundsTabModel> tabList = [
    AssetsFundsTabModel(
        name: LocaleKeys.assets108.tr, source: C2cTransactionEnum.all.value),
    AssetsFundsTabModel(
        name: LocaleKeys.assets144.tr,
        source: C2cTransactionEnum.quickBuy.value),
    AssetsFundsTabModel(name: 'C2C', source: C2cTransactionEnum.c2c.value),
    AssetsFundsTabModel(
        name: LocaleKeys.assets7.tr, source: C2cTransactionEnum.transfer.value)
  ];
  final List<bool> haveMoreLit = List<bool>.generate(4, (index) => false);
  var haveAd = false.obs;

  RxList<CmsAdvertListModel?> aDlist = <CmsAdvertListModel?>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabList.length, vsync: this);

    //广告位接口暂无
    Future.delayed(const Duration(seconds: 2), () {
      haveAd.value = true;
    });
    //获取活动列表
    getCmsAdvertList();
  }

  //获取活动
  getCmsAdvertList() async {
    try {
      CmsAdvertModel? res = await CommunityApi.instance()
          .getCmsAdvertList(ActivityEnumn.assetsSpotsInfo.position, '0');
      if (res != null) {
        aDlist = res.list!.obs;
      }
      update();
    } catch (e) {
      Get.log('error when getCmsAdvertList: $e');
    }
  }

  @override
  void onReady() {
    print(UserGetx.to.user?.token);
    super.onReady();
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.changeLang, (data) {});
    super.onClose();
  }
}
