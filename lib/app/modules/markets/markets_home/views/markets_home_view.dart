import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_home/widget/market_home_list.dart';
import 'package:nt_app_flutter/app/utils/utilities/platform_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

import '../../../home/widgets/home_first_tab_bar.dart';
import '../controllers/markets_home_controller.dart';

class MarketsHomeView extends GetView<MarketsHomeController> {
  const MarketsHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MyPlatFormUtil.isIOS()
        ? const SizedBox.shrink()
        : GetBuilder<AssetsGetx>(builder: (assetsGetx) {
            return GetBuilder(
                init: controller,
                builder: (c) {
                  return SizedBox(
                      height: controller.height,
                      child: controller.marketFirstArray.isNotEmpty
                          ? Column(
                              children: [
                                HomeFirstTabBar(
                                  dataArray: controller.marketFirstArray
                                      .map((e) => e.firsttype.value)
                                      .toList(),
                                  controller: controller.tabController,
                                ),
                                Expanded(
                                  child: TabBarView(
                                      controller: controller.tabController,
                                      children: controller.marketFirstArray
                                          .map((firstModel) => Column(
                                                children: <Widget>[
                                                  8.verticalSpaceFromWidth,
                                                  Expanded(
                                                    child: TabBarView(
                                                        controller: firstModel
                                                            .tabController,
                                                        children: firstModel
                                                            .marketSecondArray
                                                            .map((secondModel) => secondModel
                                                                        .secondType !=
                                                                    MarketSecondType
                                                                        .standardContract
                                                                ? MarketHomeList(
                                                                    firstModel:
                                                                        firstModel,
                                                                    secondModel:
                                                                        secondModel,
                                                                    controller:
                                                                        controller,
                                                                  )
                                                                : Column(
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                        child: Obx(() => IndexedStack(
                                                                            index:
                                                                                secondModel.thiredCurrentIndex.value,
                                                                            children: secondModel.marketThirdArray.map((thirdModel) => MarketHomeList(firstModel: firstModel, secondModel: secondModel, thirdModel: thirdModel, controller: controller)).toList())),
                                                                      )
                                                                    ],
                                                                  ))
                                                            .toList()),
                                                  ),
                                                ],
                                              ))
                                          .toList()),
                                ),
                              ],
                            )
                          : const SizedBox()); //FollowOrdersLoading()
                });
          });
  }
}
