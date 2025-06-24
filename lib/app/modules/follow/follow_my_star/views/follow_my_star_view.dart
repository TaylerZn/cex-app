import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/controllers/community_list_controller.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/views/community_list_view.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_my_star/model/follow_my_star_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_my_star/widget/follow_my_star_list.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_tabbar.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/follow_my_star_controller.dart';

class FollowMyStarView extends GetView<FollowMyStarController> {
  const FollowMyStarView({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      appBar: AppBar(leading: const MyPageBackWidget(), centerTitle: true, title: Text(LocaleKeys.follow4.tr)),
      body: Column(
        children: [
          EntrustTabbar(
            dataArray: controller.navTabs.map((e) => e.value).toList(),
            controller: controller.tabController,
            haveTopBorder: false,
            haveBottomBorder: true,
            isCenter: true,
          ),
          Expanded(
            child: TabBarView(
                controller: controller.tabController,
                children: controller.navTabs.map((type) {
                  return type == FollowMyStarType.trader
                      ? Obx(() => controller.model.value.list?.isNotEmpty == true
                          ? FollowMyStarList(list: controller.model.value.list!, controller: controller)
                          : FollowOrdersLoading(
                              isSliver: false,
                              isError: controller.model.value.isError,
                              onTap: () {
                                controller.getData(isPullDown: true);
                              }))
                      :
                      // GetBuilder<CommunityListController>(
                      //     id: e.symbol,
                      //     builder: (controller) {
                      //       MarketInfoModel info = SpotDataStoreController.to
                      //               .getMarketInfoBySymbol(e.symbol) ??
                      //           e;
                      //       return buildOptionItem(
                      //           info.firstName,
                      //           info.secondName,
                      //           info.priceStr,
                      //           info.roseStr,
                      //           info.backColor,
                      //           logic.addSpotList.contains(e.symbol), () {
                      //         if (logic.addSpotList.contains(e.symbol)) {
                      //           logic.addSpotList.remove(e.symbol);
                      //         } else {
                      //           logic.addSpotList.add(e.symbol);
                      //         }
                      //         logic.update();
                      //       });
                      //     });
                      GetBuilder<CommunityListController>(
                          init: CommunityListController(tagKey: 'myStar'),
                          tag: 'myStar',
                          builder: (controller) {
                            return const CommunityListView(tagKey: 'myStar');
                          });
                }).toList()),
          ),
        ],
      ),
    );
  }
}
