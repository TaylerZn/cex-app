import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_home_traker/views/follow_home_traker_view.dart';
import 'package:nt_app_flutter/app/modules/home/controllers/home_index_controller.dart';
import 'package:nt_app_flutter/app/modules/home/widgets/search_view.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_home/views/markets_home_view.dart';
import 'package:nt_app_flutter/app/modules/my/quick_entry/views/quick_entry_view.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/package_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_eyes.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_profit.dart';
import 'package:nt_app_flutter/app/widgets/components/easy_refresher_header.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../network/logger/src/ui.dart';
import '../../../utils/utilities/route_util.dart';
import '../../../widgets/components/assets/assets_exchange_rate_home.dart';
import '../../assets/assets_overview/controllers/assets_overview_controller.dart';
import '../../assets/assets_overview/widget/account_view.dart';
import '../../otc/b2c/widget/otc_open_bottom_dialog.dart';
import '../widgets/home_banner_tips.dart';
import '../widgets/home_not_login_widget.dart';
import '../widgets/home_post_list.dart';

class HomeIndexView extends GetView<HomeIndexController> {
  const HomeIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    if (apiType != ApiType.prod) {
      NetworkLoggerOverlay.attachTo(context, rootOverlay: false, bottom: 300);
    }
    return MySystemStateBar(
      color: SystemColor.black,
      child: SafeArea(
        child: Column(
          children: [
            topView(),
            Expanded(
              child: EasyRefresh.builder(
                  controller: controller.refreshController,
                  header: EasyRefresherHeader(),
                  onRefresh: () async {
                    controller.getOnRefresh();
                  },
                  childBuilder: (context, physics) {
                    return ScrollConfiguration(
                      behavior: const ERScrollBehavior(),
                      child: ExtendedNestedScrollView(
                        controller: controller.scrollController,
                        physics: physics,
                        onlyOneScrollInBody: true,
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return <Widget>[
                            const HeaderLocator.sliver(clearExtent: false),
                            SliverToBoxAdapter(
                              child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      16.verticalSpaceFromWidth,
                                      GetBuilder<UserGetx>(builder: (userGetx) {
                                        return userGetx.isLogin
                                            ? GetBuilder<AssetsGetx>(
                                                builder: (assetsGetx) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 339.w,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: moneyWidget(
                                                                assetsGetx),
                                                          ),
                                                          lineChart(),
                                                        ],
                                                      ),
                                                    ),
                                                    24.verticalSpaceFromWidth,
                                                    buttons(context),
                                                  ],
                                                );
                                              })
                                            : const HomeNotLoginWidget();
                                      }),
                                      24.verticalSpaceFromWidth,
                                    ],
                                  )),
                            ),
                            SliverToBoxAdapter(
                              child: GetBuilder<UserGetx>(
                                builder: (userGetx) {
                                  return commonUse(isMain: true, isEdit: false);
                                },
                              ),
                            ),

                            /// 热门交易员 轮播
                            SliverToBoxAdapter(
                                child: Padding(
                              padding: EdgeInsets.only(top: 12.w),
                              child: const FollowHomeTrakerView(),
                            )),
                            SliverToBoxAdapter(
                                child: 12.verticalSpaceFromWidth),

                            /// 首页 公告滚动
                            const SliverToBoxAdapter(child: HomeBannerTips()),

                            /// 自选
                            const SliverToBoxAdapter(child: MarketsHomeView()),

                            SliverAppBar(
                              expandedHeight: 0,
                              floating: true,
                              flexibleSpace: const SizedBox.shrink(),
                              pinned: true,
                              bottom: PreferredSize(
                                preferredSize: Size.fromHeight(36.w),
                                child: GetBuilder<HomeIndexController>(
                                    builder: (logic) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    height: 36.w,
                                    child: TabBar(
                                      controller: controller.tabController,
                                      isScrollable: true,
                                      labelColor: AppColor.color111111,
                                      indicator: ShapeDecoration(
                                          color: AppColor.colorFFFFFF,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          )),
                                      indicatorColor: Colors.transparent,
                                      labelStyle: AppTextStyle
                                          .f_15_600.colorTextPrimary,
                                      unselectedLabelStyle: AppTextStyle
                                          .f_15_500.colorTextDisabled,
                                      tabs: [
                                        Tab(text: LocaleKeys.public38.tr),
                                        if (UserGetx.to.isLogin)
                                          Tab(text: LocaleKeys.community43.tr),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ];
                        },
                        body: HomePostList(physics: physics),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _buildTab() {
    return Container(
      height: 36.w,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              labelColor: AppColor.color111111,
              indicator: ShapeDecoration(
                  color: AppColor.colorFFFFFF,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  )),
              indicatorColor: Colors.transparent,
              labelStyle: AppTextStyle.f_15_600.colorTextPrimary,
              unselectedLabelStyle: AppTextStyle.f_15_500.colorTextDisabled,
              tabs: [
                Tab(text: LocaleKeys.community42.tr),
                Tab(text: LocaleKeys.community43.tr),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column moneyWidget(AssetsGetx assetsGetx) {
    String text = NumberUtil.mConvert(
      assetsGetx.totalBalance,
      isEyeHide: true,
      isRate: IsRateEnum.usdt,
      count: 2,
      isShowLogo: false,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.assets5.tr,
              style: AppTextStyle.f_12_400.colorTextPrimary,
            ),
            8.horizontalSpace,
            AssetsEyes()
          ],
        ),
        2.verticalSpaceFromWidth,
        Container(
          constraints: BoxConstraints(
            maxWidth: 240.w,
            minWidth: 10.w,
            maxHeight: 48.w,
            minHeight: 48.w,
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: AutoSizeText(
                  text,
                  style: AppTextStyle.f_32_600,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: text.length > 8 ? 6.w : 8.w, left: 4.w),
                child: const AssetsExchangeRateHome(),
              ),
            ],
          ),
        ),
        2.verticalSpaceFromWidth,

        /// 今日盈亏
        AssetsProfit(
          valueNum: assetsGetx.pnlAmount,
          title: LocaleKeys.assets12.tr,
          value: NumberUtil.mConvert(assetsGetx.pnlAmount,
              isEyeHide: true,
              isShowLogo: false,
              isRate: IsRateEnum.usdt,
              count: 2),
          percent: assetsGetx.pnlRate,
        ),
      ],
    );
  }

  Row buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyButton(
          backgroundColor: AppColor.colorBackgroundTertiary,
          minWidth: 165.5.w,
          height: 36.w,
          borderRadius: BorderRadius.circular(60.w),
          text: LocaleKeys.otc2.tr,
          color: AppColor.colorTextSecondary,
          textStyle: AppTextStyle.f_14_600,
          onTap: () {
            RouteUtil.goTo('/otc-b2c');
          },
        ),
        MyButton(
          minWidth: 165.5.w,
          height: 36.w,
          backgroundColor: AppColor.colorBackgroundInversePrimary,
          borderRadius: BorderRadius.circular(60.w),
          text: LocaleKeys.otc1.tr,
          textStyle: AppTextStyle.f_14_600,
          onTap: () {
            otcBottomDialog(context);
          },
        ),
      ],
    );
  }

  GetBuilder<AssetsOverviewController> lineChart() {
    Get.put(AssetsOverviewController());
    return GetBuilder<AssetsOverviewController>(
      builder: (controller) {
        if (controller.klineArr == null || controller.klineArr!.isEmpty) {
          return const SizedBox.shrink();
        }
        return GestureDetector(
          onTap: () {
            if (controller.defaltHeight < controller.topHeight) {
              controller.height.value = controller.topHeight;
            }
          },
          child: Container(
              margin: EdgeInsets.only(top: 17.5.w),
              width: 95.w,
              height: 39.9.w,
              child: AssetsStockChart(
                profitRateList: controller.klineArr,
              )),
        );
      },
    );
  }

  Widget topView() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GetBuilder<UserGetx>(builder: (userGetx) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.MY_ME_INDEX);
                    },
                    child: MyImage(
                      'home/application_menu'.pngAssets(),
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                  14.5.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SEARCH_INDEX);
                      },
                      child: const SearchView(
                        searchIconColor: AppColor.colorTextDisabled,
                        backgroundColor: AppColor.colorBackgroundSecondary,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          12.horizontalSpace,
          Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.WEAL_INDEX);
                },
                child: Lottie.asset(
                  'assets/json/gift_we.json',
                  fit: BoxFit.fill,
                  width: 26.w,
                  height: 26.w,
                ).marginOnly(bottom: 3.w),
              ),
              16.horizontalSpace,

              /// 消息
              InkWell(
                onTap: () {
                  if (UserGetx.to.goIsLogin()) {
                    UserGetx.to.messageUnreadCount = 0;
                    UserGetx.to.update();
                    Get.toNamed(Routes.COMMUNITY_MESSAGE,
                        arguments: {'messageType': 0});
                  }
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    MyImage(
                      'home/message'.svgAssets(),
                      width: 20.w,
                      height: 20.w,
                    ),
                    GetBuilder<UserGetx>(builder: (userGetx) {
                      return userGetx.unreadCount > 0
                          ? Positioned(
                              right: -3.5.w,
                              top: 5.5.w,
                              bottom: 5.5.w,
                              child: ClipOval(
                                child: Container(
                                  color: AppColor.colorBackgroundPrimary,
                                  padding: EdgeInsets.all(1.5.w),
                                  child: ClipOval(
                                    child: Container(
                                      color: AppColor.colorTextError,
                                      width: 6.w,
                                      height: 6.w,
                                    ),
                                  ),
                                ),
                              ))
                          : Container();
                    })
                  ],
                ),
              ).marginSymmetric(vertical: 3.w),
            ],
          )
        ],
      ),
    );
  }
}
