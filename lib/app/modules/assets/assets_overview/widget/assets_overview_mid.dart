import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../../../assets/assets_overview/controllers/assets_overview_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsOverviewMid extends StatelessWidget {
  const AssetsOverviewMid({super.key, required this.controller});

  final AssetsOverviewController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      sliver: SliverToBoxAdapter(
          child: controller.isEmptyView
              ? const SizedBox()
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ...List.generate(
                              controller.actionsArray.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      controller.handleActionWithType(controller.actionsArray[index]);
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.all(13.w),
                                            margin: EdgeInsets.only(bottom: 8.w),
                                            decoration: const ShapeDecoration(
                                              shape: OvalBorder(
                                                side: BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                                              ),
                                            ),
                                            child: MyImage(
                                              'assets/${controller.actionsArray[index].image}'.svgAssets(),
                                              width: 20.w,
                                              height: 20.w,
                                            )),
                                        Text(controller.actionsArray[index].value, style: AppTextStyle.f_12_500.color4D4D4D)
                                      ],
                                    ),
                                  ))
                        ],
                      ),
                    ),
                    controller.walletHistoryArr.isEmpty
                        ? SizedBox(height: 12.w)
                        : InkWell(
                            onTap: () {
                              Get.toNamed(Routes.WALLET_HISTORY, arguments: 0);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              margin: EdgeInsets.symmetric(vertical: 12.w),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  MyImage(
                                    'assets/asset_noti'.svgAssets(),
                                    width: 12.w,
                                    height: 12.w,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(getTitle(), style: AppTextStyle.f_11_400.color4D4D4D),
                                  ),
                                  // Container(
                                  //   width: 6.w,
                                  //   height: 6.w,
                                  //   margin: EdgeInsets.only(right: 10.w),
                                  //   decoration: const ShapeDecoration(
                                  //     color: AppColor.upColor,
                                  //     shape: OvalBorder(),
                                  //   ),
                                  // ),
                                  MyImage(
                                    'assets/assets_go'.svgAssets(),
                                    width: 12.w,
                                  )
                                ],
                              ),
                            ),
                          )
                  ],
                )),
    );
  }

  String getTitle() {
    var m = controller.walletHistoryArr.first;
    var type = m.type == '1' ? LocaleKeys.assets209.tr : LocaleKeys.assets64.tr;
    return '${m.account}$type${m.amount} ${m.coinSymbol} ';
  }
}

class AssetsOverviewBottom extends StatelessWidget {
  const AssetsOverviewBottom({super.key, required this.controller});
  final AssetsOverviewController controller;

  @override
  Widget build(BuildContext context) {
    // return SliverPinnedHeader(
    return SliverToBoxAdapter(
        child: controller.isEmptyView
            ? const SizedBox()
            : Container(
                padding: EdgeInsets.only(left: 16.w),
                decoration: const BoxDecoration(
                  color: AppColor.colorWhite,
                  // border: Border(
                  //   bottom: BorderSide(width: 1, color: AppColor.colorF5F5F5),
                  // ),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: TabBar(
                        labelPadding: EdgeInsets.only(right: 30.w),
                        isScrollable: true,
                        labelColor: AppColor.color111111,
                        unselectedLabelColor: AppColor.colorABABAB,
                        controller: controller.tabController,
                        labelStyle: AppTextStyle.f_16_600,
                        unselectedLabelStyle: AppTextStyle.f_16_500,
                        indicator: MyUnderlineTabIndicator(
                          borderSide: BorderSide(width: 2.h, color: AppColor.color111111),
                        ),
                        tabs: controller.tabs.map((e) => Tab(text: e.tr)).toList(),
                      ),
                    ),
                    Positioned(
                        top: 6.w,
                        right: 16.w,
                        bottom: 6.w,
                        child: Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF1F1F1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Obx(() => Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.currentIndex.value = 0;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        decoration: ShapeDecoration(
                                          color: controller.currentIndex.value == 0 ? AppColor.colorWhite : Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: MyImage(
                                          'assets/asset_list'.svgAssets(),
                                          width: 16.w,
                                          height: 16.w,
                                          color:
                                              controller.currentIndex.value == 0 ? AppColor.color111111 : AppColor.colorABABAB,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.currentIndex.value = 1;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        decoration: ShapeDecoration(
                                          color: controller.currentIndex.value == 1 ? AppColor.colorWhite : Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: MyImage(
                                          'assets/asset_pie'.svgAssets(),
                                          width: 16.w,
                                          height: 16.w,
                                          color:
                                              controller.currentIndex.value == 1 ? AppColor.color111111 : AppColor.colorABABAB,
                                        ),
                                      ),
                                    ),
                                  ],
                                )))),
                  ],
                ),
              ));
  }
}
