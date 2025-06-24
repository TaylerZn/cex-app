import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/views/index.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/markets/market/controllers/markets_index_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_view.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/markets_top_view.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';

class MarketsIndexView extends GetView<MarketsIndexController> {
  const MarketsIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        child: Scaffold(
            body: SafeArea(
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          // marketsNav(),
        ];
      }, body: GetBuilder<AssetsGetx>(builder: (assetsGetx) {
        return GetBuilder(
            init: controller,
            builder: (b) {
              if (controller.marketFirstArray.isNotEmpty) {
                return Column(
                  children: <Widget>[
                    MarketsFirstTabbar(
                      dataArray: controller.marketFirstArray
                          .map((e) => e.firsttype.value)
                          .toList(),
                      controller: controller.tabController,
                      haveSearch: true,
                      rightPadding: 16,
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: controller.tabController,
                          children: controller.marketFirstArray
                              .map(
                                (firstModel) => firstModel.firsttype ==
                                        MarketFirstType.community
                                    ? CommunityIndexPage()
                                    : Column(
                                        children: <Widget>[
                                          MarketSecondTabbar(
                                            dataArray: firstModel
                                                .marketSecondArray
                                                .map((e) => e.secondType.value)
                                                .toList(),
                                            controller:
                                                firstModel.tabController,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 0.6.w,
                                            color: AppColor.colorBorderGutter,
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                                controller:
                                                    firstModel.tabController,
                                                children: firstModel
                                                    .marketSecondArray
                                                    .map((secondModel) =>
                                                        secondModel.tabController ==
                                                                null
                                                            ? MarketList(
                                                                firstModel:
                                                                    firstModel,
                                                                secondModel:
                                                                    secondModel,
                                                                controller:
                                                                    controller,
                                                              )
                                                            : Column(
                                                                children: <Widget>[
                                                                  MarketThirdTabbar(
                                                                    dataArray: secondModel
                                                                        .marketThirdArray
                                                                        .map((e) => e
                                                                            .thirdType
                                                                            .value)
                                                                        .toList(),
                                                                    controller:
                                                                        secondModel
                                                                            .tabController!,
                                                                  ),
                                                                  Expanded(
                                                                    child: TabBarView(
                                                                        controller: secondModel.tabController!,
                                                                        children: secondModel.marketThirdArray
                                                                            .map((thirdModel) => thirdModel.tabController == null
                                                                                ? MarketList(firstModel: firstModel, secondModel: secondModel, thirdModel: thirdModel, controller: controller)
                                                                                : Column(
                                                                                    children: <Widget>[
                                                                                      MarketFourTabbar(
                                                                                        dataArray: thirdModel.marketFourArray.map((e) => e.fourType.value).toList(),
                                                                                        controller: thirdModel.tabController!,
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: TabBarView(controller: thirdModel.tabController!, children: thirdModel.marketFourArray.map((fourModel) => MarketList(firstModel: firstModel, secondModel: secondModel, thirdModel: thirdModel, fourModel: fourModel, controller: controller)).toList()),
                                                                                      )
                                                                                    ],
                                                                                  ))
                                                                            .toList()),
                                                                  )
                                                                ],
                                                              ))
                                                    .toList()),
                                          )
                                        ],
                                      ),
                              )
                              .toList()),
                    )
                  ],
                );
              } else {
                return controller.isError == null
                    ? const FollowOrdersLoading(isSliver: false)
                    : FollowOrdersLoading(
                        isSliver: false,
                        isError: true,
                        onTap: () {
                          controller.getMarketData();
                        },
                      );
              }
            });
      })),
    )));
  }
}
