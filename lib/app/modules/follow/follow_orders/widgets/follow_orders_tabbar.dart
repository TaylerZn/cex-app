// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class FollowOrdersTabbar extends StatelessWidget {
  const FollowOrdersTabbar(
      {super.key,
      required this.dataArray,
      required this.controller,
      this.height = 20,
      this.marginTop = 12,
      this.marginBottom = 12,
      this.radius = 4,
      this.unselectedLabelStyle,
      this.labelStyle,
      this.labelPadding = 10,
      this.rightWidget});
  final List<String> dataArray;
  final TabController controller;
  final double height;
  final double marginTop;
  final double marginBottom;
  final double radius;
  final double labelPadding;
  final Widget? rightWidget;

  final TextStyle? unselectedLabelStyle;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      // color: Colors.red,
      padding: EdgeInsets.fromLTRB(0, marginTop.h, 0, marginBottom.h),
      alignment: Alignment.centerLeft,
      // margin: EdgeInsets.only(left: 16.w, right: 16.w),
      height: (height + marginTop + marginBottom).h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabBar(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            controller: controller,
            isScrollable: true,
            unselectedLabelColor: AppColor.colorABABAB,
            labelColor: AppColor.color111111,
            labelStyle: labelStyle ?? AppTextStyle.f_15_500,
            unselectedLabelStyle: unselectedLabelStyle ?? AppTextStyle.f_15_400,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.only(left: 0, right: 0, top: 0.h, bottom: 0.h),
            labelPadding: EdgeInsets.only(left: labelPadding.w, right: labelPadding.w, top: 2.h, bottom: 0),
            indicator: BoxDecoration(
              color: AppColor.colorEEEEEE,
              borderRadius: BorderRadius.circular(radius.r),
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
          rightWidget ?? const SizedBox()
        ],
      ),
    );
  }
}

class FollowOrdersFutureTabbar extends StatelessWidget {
  const FollowOrdersFutureTabbar({super.key, required this.dataArray, required this.controller});
  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 20.w),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
          ),
        ),
      ),
      height: 38.w,
      width: double.infinity,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_14_500,
        unselectedLabelStyle: AppTextStyle.f_14_500,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColor.colorBlack,
            width: 2.h,
          ),
        ),
        labelPadding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
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

class FollowOrdersFutureSelect extends StatelessWidget {
  const FollowOrdersFutureSelect({
    super.key,
    required this.currentIndex,
    required this.dataArray,
    required this.callback,
  });
  final int currentIndex;
  final List<String> dataArray;
  final Function(int) callback;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColor.colorWhite),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showFollowFilterSheetView(dataArray, currentIndex, callback);
            },
            child: Container(
                margin: EdgeInsets.only(left: 16.w, top: 10.w, bottom: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
                decoration: ShapeDecoration(
                  color: AppColor.colorF9F9F9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Row(
                  children: [
                    Text(dataArray[currentIndex], style: AppTextStyle.f_12_400.color666666),
                    MyImage('flow/follow_filter_arrow'.svgAssets(), width: 12.w, height: 12.w)
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

showFollowFilterSheetView(List<String> array, int selectIndex, Function(int)? back) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: false,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CustomFollowBottomSheet(array: array, selectIndex: selectIndex, callback: back),
      );
    },
  );
}

class CustomFollowBottomSheet extends StatelessWidget {
  const CustomFollowBottomSheet({super.key, required this.array, this.callback, required this.selectIndex});
  final List<String> array;
  final Function(int)? callback;
  final int selectIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 20.w, 16.w, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...List.generate(
              array.length,
              (index) => GestureDetector(
                  onTap: () {
                    Get.back();
                    callback?.call(index);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                    decoration: ShapeDecoration(
                      color: selectIndex == index ? AppColor.colorF9F9F9 : Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          array[index],
                          style: AppTextStyle.f_15_600.color111111,
                        ),
                        selectIndex == index
                            ? MyImage(
                                'flow/follow_filter_sure'.svgAssets(),
                                width: 24.w,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16.w, 0, 16.w),
            child: Row(
              children: [
                Expanded(
                  child: MyButton.borderWhiteBg(
                    height: 48.w,
                    text: LocaleKeys.public2.tr,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom)
        ],
      ),
    );
  }
}
