import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/community/widget/action_widget.dart';
import 'package:nt_app_flutter/app/modules/markets/market/views/markets_index_view.dart';
import 'package:nt_app_flutter/app/modules/transation/trades/views/trades_view.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/widgets/components/after_layout.dart';

import '../../../widgets/components/keep_alive_wrapper.dart';
import '../../assets/assets_main/views/assets_main_view.dart';
import '../../follow/follow_orders/views/follow_orders_view.dart';
import '../../home/controllers/home_index_controller.dart';
import '../../home/views/home_index_view.dart';
import '../controllers/main_tab_controller.dart';
import '../widgets/home_buttom_widget.dart';

class MainTabView extends GetView<MainTabController> {
  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) async {
        if (didpop) {
          return;
        }
        if (controller.closeOnConfirm()) {
          SystemNavigator.pop();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: const [
                  HomeIndexView(),
                  MarketsIndexView(),
                  TradesView(),
                  FollowOrdersView(),
                  AssetsMainView()
                ].map((e) => KeepAliveWrapper(child: e)).toList()),
            bottomNavigationBar: AfterLayout(
              callback: (RenderAfterLayout ral) {
                controller.centerBtnBottom = ral.offset.dy + 30.h;
              },
              child: Obx(() {
                return BottomNavigationBar(
                  selectedLabelStyle: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  selectedItemColor: AppColor.color111111,
                  unselectedItemColor: AppColor.colorBBBBBB,
                  currentIndex: controller.tabIndex.value,
                  type: BottomNavigationBarType.fixed,
                  onTap: controller.changeTabIndex,
                  items: controller.tabs
                      .asMap()
                      .keys
                      .map(
                        (i) => BottomNavigationBarItem(
                          icon: i == 0
                              ? HomeButtonWidget(
                                  key: MyCommunityUtil.homeButton,
                                  selected: controller.tabIndex.value == 0,
                                  onTap: (isScroll) {
                                    if (isScroll) {
                                      Get.find<HomeIndexController>()
                                          .scrollController
                                          .animateTo(
                                            0,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                      return;
                                    }
                                    controller.changeTabIndex(0);
                                  })
                              : Lottie.asset(controller.tabs[i]['lottie'],
                                  controller:
                                      controller.homeTabAnimationControllers[i],
                                  width: 24.w,
                                  height: 24.w,
                                  repeat: false, onLoaded: (composition) {
                                  controller.homeTabAnimationControllers[i]
                                      .duration = composition.duration;
                                }),
                          label: controller.tabs[i]['label'].toString().tr,
                        ),
                      )
                      .toList(),
                );
              }),
            ),
          ),
          CommunityActionWidget()
        ],
      ),
    );
  }
}
