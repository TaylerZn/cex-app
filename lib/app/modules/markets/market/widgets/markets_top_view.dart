import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_search_textField.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_model.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_home/model/market_home_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../widgets/basic/my_tab_shape_widget.dart';
import '../../../home/widgets/search_view.dart';

SliverAppBar marketsNav() {
  return SliverAppBar(
    backgroundColor: AppColor.colorWhite,
    automaticallyImplyLeading: false,
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: GestureDetector(
          onTap: () => Get.toNamed(Routes.SEARCH_INDEX),
          child: Container(
              height: 32.w,
              margin: const EdgeInsets.only(left: 16, right: 10),
              decoration: BoxDecoration(
                color: AppColor.colorF5F5F5,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: SearchTextField(
                    height: 32,
                    enabled: false,
                    haveTopPadding: false,
                    hintText: LocaleKeys.public9.tr,
                  )),
                  SizedBox(width: 9.w),
                ],
              )),
        ),
      )
    ]),
    titleSpacing: 0,
  );
}

class MarketsFirstTabbar extends StatelessWidget {
  const MarketsFirstTabbar(
      {super.key,
      required this.dataArray,
      required this.controller,
      this.haveBottom = true,
      this.haveSearch = false,
      this.rightPadding = 0});

  final List<String> dataArray;
  final bool haveBottom;
  final TabController controller;
  final bool haveSearch;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          haveSearch
              ? GestureDetector(
                  onTap: () => Get.toNamed(Routes.SEARCH_INDEX),
                  child: Container(
                    color: AppColor.colorWhite,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                    child: const SearchView(),
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: 40.w,
            child: TabBar(
              controller: controller,
              isScrollable: true,
              unselectedLabelColor: AppColor.colorABABAB,
              unselectedLabelStyle: AppTextStyle.f_15_500,
              labelColor: AppColor.color111111,
              labelStyle: AppTextStyle.f_15_500,
              // labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp, ),
              // labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp, ),
              labelPadding: EdgeInsets.only(left: rightPadding.w),
              indicator: const BoxDecoration(),
              // labelPadding:
              //     EdgeInsets.only(left: 16.w, right: 4.w, top: 0, bottom: 0),
              tabs: dataArray
                  .map((f) => Tab(
                        child: f == LocaleKeys.markets3.tr
                            ? communityWidget(f)
                            : Align(
                                alignment: Alignment.center,
                                child: Text(f),
                              ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  communityWidget(String f) {
    return Tab(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(f),
          ),
          Positioned(
              right: -4.w,
              top: 6.w,
              child: MyImage(
                'trade/hot'.svgAssets(),
                width: 15.w,
                height: 10.w,
              )),
        ],
      ),
    );
  }
}

class MarketSecondTabbar extends StatelessWidget {
  const MarketSecondTabbar({super.key, required this.dataArray, required this.controller, this.haveBackground = false});

  final List<String> dataArray;
  final TabController controller;
  final bool haveBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColor.upColor,
      color: AppColor.colorWhite,

      padding: EdgeInsets.symmetric(horizontal: 16.h),
      alignment: Alignment.centerLeft,
      height: haveBackground ? 42.h : 32.w,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.colorTextPrimary,
        labelStyle: haveBackground ? AppTextStyle.f_12_500 : AppTextStyle.f_13_500,
        unselectedLabelStyle: haveBackground ? AppTextStyle.f_12_500 : AppTextStyle.f_13_500,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.only(left: 0, right: 12),
        labelPadding: EdgeInsets.only(left: haveBackground ? 10.w : 0, right: haveBackground ? 10.w : 12.w, top: 0, bottom: 0),
        indicatorWeight: 1,
        indicatorColor: AppColor.colorTextPrimary,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColor.colorTextPrimary,
            width: 2.w,
          ),
        ),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class MarketThirdTabbar extends StatelessWidget {
  const MarketThirdTabbar({super.key, required this.dataArray, required this.controller});

  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColor.colorWhite,
      alignment: Alignment.centerLeft,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(vertical: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 22.w,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorTextDisabled,
        labelColor: AppColor.colorTextPrimary,
        labelStyle: AppTextStyle.f_12_400,
        unselectedLabelStyle: AppTextStyle.f_12_400,
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: const EdgeInsets.only(left: 0, right: 4),
        labelPadding: EdgeInsets.zero,
        indicator: MyUnderShapeTabIndicator(
          color: AppColor.colorBackgroundTertiary,
          radius: (6.r),
        ),
        tabs: dataArray
            .map((f) => Tab(
                  child: Container(
                    margin: EdgeInsets.only(right: 4.w),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 8.w,right: 8.w,top: 2.w),
                    child: Text(f, style: AppTextStyle.f_12_400),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class MarketFourTabbar extends StatelessWidget {
  const MarketFourTabbar({super.key, required this.dataArray, required this.controller});

  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      // color: Colors.yellow,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
      height: 32.h,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_12_500,
        unselectedLabelStyle: AppTextStyle.f_12_500,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.w, bottom: 0),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: const Color(0xFFF3F3F5),
        ),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class MarketFiveTabbar extends StatelessWidget {
  const MarketFiveTabbar({super.key, required this.model, required this.callback, this.top = 4});

  final MarketsFiveModel model;
  final Function(int, MarketFourFilter) callback;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      color: AppColor.colorWhite,

      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 4.h, top: top.w),
        child: Row(
          children: <Widget>[
            getTag(model.array[0].tr, 0, haveRight: true),
            getTag(model.array[1].tr, 1),
            const Spacer(),
            getTag(model.array[2].tr, 2),
            18.horizontalSpace,
            getTag(model.array[3].tr, 3)
          ],
        ),
      ),
    );
  }

  getTag(String name, int currentIndex, {bool haveRight = false}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        for (var i = 0; i < model.filterArray.length; i++) {
          if (currentIndex == i) {
            if (model.filterArray[i].value == MarketFourFilter.defaultFilter) {
              model.filterArray[i].value = MarketFourFilter.downFilter;
            } else if (model.filterArray[i].value == MarketFourFilter.downFilter) {
              model.filterArray[i].value = MarketFourFilter.upFilter;
            } else {
              model.filterArray[i].value = MarketFourFilter.defaultFilter;
            }
          } else {
            model.filterArray[i].value = MarketFourFilter.defaultFilter;
          }
        }
        callback(currentIndex, model.filterArray[currentIndex].value);
      },
      child: Row(
        children: [
          Text(name, style: AppTextStyle.f_12_400.color999999),
          SizedBox(
            width: 2.w,
          ),
          Obx(() => MyImage(
                'contract/${model.filterArray[currentIndex].value.index == 0 ? 'market_filter' : model.filterArray[currentIndex].value.index == 1 ? 'market_filter_down' : 'market_filter_up'}'
                    .svgAssets(),
              )),
          haveRight
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    '/',
                    style: AppTextStyle.f_12_400.colorTextTips,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class MarketHomeFourTabbar extends StatelessWidget {
  const MarketHomeFourTabbar({super.key, required this.model, this.callback, this.hiddenSort = false});

  final MarketsHomeSecondModel model;
  final bool hiddenSort;

  final Function(int, MarketFourFilter)? callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 4.w, bottom: 4.w),
      child: Row(
        children: <Widget>[
          getTag(getTitle(), haveRight: model.secondType == MarketSecondType.standardContract),
          const Spacer(),
          hiddenSort
              ? const SizedBox()
              : Row(
                  children: <Widget>[
                    getTag(model.array[1].tr),
                    SizedBox(width: 32.w),
                    getTag(model.array[2].tr),
                  ],
                )
        ],
      ),
    );
  }

  String getTitle() {
    if (model.secondType == MarketSecondType.standardContract) {
      return model.marketThirdArray[model.thiredCurrentIndex.value].thirdType.value;
    } else {
      return model.array[0].tr;
    }
  }

  getTag(String name, {bool haveRight = false}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!haveRight) return;
        showGrabOrderDisplaySheetView(
            model.marketThirdArray.map((e) => e.thirdType.value).toList(), model.thiredCurrentIndex.value, (i) {
          model.thiredCurrentIndex.value = i;
          model.callBack?.call(i);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name,
            style: AppTextStyle.f_12_400.color999999,
          ),
          if (haveRight)
            MyImage(
              'home/market_filter_home'.svgAssets(),
            ).marginOnly(left: 2.w)
        ],
      ),
    );
  }

  showGrabOrderDisplaySheetView(List array, int current, Function(int) callback) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 21.h),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: array.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      callback(index);
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: index == current ? AppColor.colorF5F5F5 : Colors.transparent),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.transparent),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(array[index], style: AppTextStyle.f_15_600.color111111),
                            index == current ? const Icon(Icons.check) : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: MyButton(
                  text: LocaleKeys.public2.tr,
                  backgroundColor: AppColor.colorFFFFFF,
                  color: AppColor.color111111,
                  height: 48.w,
                  border: Border.all(width: 1, color: AppColor.colorF5F5F5),
                  borderRadius: BorderRadius.circular(100.r),
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        );
      },
    );
    // MediaQuery.of(context).padding.bottom
  }
}

class MarketStockTabbar extends StatelessWidget {
  const MarketStockTabbar({super.key, required this.dataArray, required this.controller});

  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(height: 30, width: 400, color: Colors.red);

    Container(
      color: AppColor.colorWhite,
      // color: Colors.yellow,
      alignment: Alignment.centerLeft,
      // color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 22.h,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        // labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, ),
        // unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, ),

        labelStyle: AppTextStyle.f_12_500,
        unselectedLabelStyle: AppTextStyle.f_12_500,
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: EdgeInsets.only(left: 0, right: 0, top: 4.h, bottom: 4.h),
        labelPadding: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.w, bottom: 0),
        indicator: BoxDecoration(
            // color: AppColor.colorEEEEEE,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: AppColor.color111111)),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
