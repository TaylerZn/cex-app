import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_home_traker/widget/follow_orders_cell.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_tabbar.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_list/model/follow_taker_list_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_tabbar.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/follow_taker_list_controller.dart';

class FollowTakerListView extends GetView<FollowTakerListController> {
  const FollowTakerListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorWhite,
        appBar: AppBar(
          leading: const MyPageBackWidget(),
        ),
        body: GetBuilder(
            init: controller,
            builder: (b) {
              return Column(
                children: [
                  EntrustTabbar(
                    dataArray: controller.navTabs.map((e) => e.value).toList(),
                    controller: controller.tabController,
                    haveTopBorder: false,
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: controller.tabController,
                        children: controller.navTabs
                            .map((navType) => navType == TakerListType.allTraders
                                ? Column(
                                    children: <Widget>[
                                      FollowOrdersTabbar(
                                          marginTop: 16,
                                          marginBottom: 8,
                                          labelStyle: AppTextStyle.f_12_500,
                                          unselectedLabelStyle: AppTextStyle.f_12_500,
                                          controller: controller.tabControllerFillter,
                                          dataArray: controller.fillterTabs.map((e) => e.value).toList()),
                                      Expanded(
                                        child: TabBarView(
                                            controller: controller.tabControllerFillter,
                                            children: controller.fillterTabs.map((type) {
                                              var currentModel = controller.tabsModel[0][type.index];
                                              var refreshVc = controller.tabsRefreshController[0][type.index];

                                              return currentModel.list?.isNotEmpty == true
                                                  ? SmartRefresher(
                                                      controller: refreshVc,
                                                      enablePullDown: true,
                                                      enablePullUp: true,
                                                      onRefresh: () async {
                                                        await controller.getData(isPullDown: true);
                                                        refreshVc.refreshToIdle();
                                                        refreshVc.loadComplete();
                                                      },
                                                      onLoading: () async {
                                                        if (currentModel.haveMore) {
                                                          currentModel.page++;
                                                          await controller.getData();
                                                          refreshVc.loadComplete();
                                                        } else {
                                                          refreshVc.loadNoData();
                                                        }
                                                      },
                                                      child: CustomScrollView(
                                                        key: PageStorageKey<int>(navType.index),
                                                        slivers: [
                                                          SliverList.builder(
                                                            itemCount: currentModel.list!.length,
                                                            itemBuilder: (context, index) {
                                                              return FollowOrdersCell(model: currentModel.list![index]);
                                                            },
                                                          )
                                                        ],
                                                      ))
                                                  : FollowOrdersLoading(
                                                      isSliver: false,
                                                      isError: currentModel.isError,
                                                      onTap: () {
                                                        controller.getData(isPullDown: true);
                                                      });
                                            }).toList()),
                                      )
                                    ],
                                  )
                                : Builder(builder: (context) {
                                    var currentModel = controller.tabsModel[navType.index].first;
                                    var refreshVc = controller.tabsRefreshController[navType.index].first;

                                    return currentModel.list?.isNotEmpty == true
                                        ? SmartRefresher(
                                            controller: refreshVc,
                                            enablePullDown: true,
                                            enablePullUp: true,
                                            onRefresh: () async {
                                              await controller.getData(isPullDown: true);
                                              refreshVc.refreshToIdle();
                                              refreshVc.loadComplete();
                                            },
                                            onLoading: () async {
                                              if (currentModel.haveMore) {
                                                currentModel.page++;
                                                await controller.getData();
                                                refreshVc.loadComplete();
                                              } else {
                                                refreshVc.loadNoData();
                                              }
                                            },
                                            child: CustomScrollView(
                                              key: PageStorageKey<int>(navType.index),
                                              slivers: [
                                                SliverList.builder(
                                                  itemCount: currentModel.list!.length,
                                                  itemBuilder: (context, index) {
                                                    return FollowOrdersCell(model: currentModel.list![index]);
                                                  },
                                                )
                                              ],
                                            ))
                                        : FollowOrdersLoading(
                                            isSliver: false,
                                            isError: currentModel.isError,
                                            onTap: () {
                                              controller.getData(isPullDown: true);
                                            });
                                  }))
                            .toList()),
                  )
                ],
              );
            }));
  }
}
