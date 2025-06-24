import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_apply_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/merchant/controllers/merchant_apply_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_handle/widget/customer_handle_list.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class MerchantApplyTop extends StatelessWidget {
  const MerchantApplyTop({super.key, required this.controller});
  final MerchantApplyController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 20.w, 9.w, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(LocaleKeys.c2c319.tr, style: AppTextStyle.f_28_600.colorWhite),
                          Text(LocaleKeys.c2c320.tr, style: AppTextStyle.f_24_600.colorWhite),
                          Text(LocaleKeys.c2c321.tr, style: AppTextStyle.f_14_300.colorWhite),
                        ],
                      ),
                    ),
                    MyImage(
                      'otc/c2c/c2c_aaply_top'.svgAssets(),
                      width: 126.w,
                      height: 97.h,
                    ),
                  ],
                ).paddingOnly(bottom: 30.w),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: MyImage(
                        'otc/c2c/c2c_merchant_lineL'.svgAssets(),
                        height: 5.h,
                      ),
                    ),
                    Text(LocaleKeys.c2c322.tr, style: AppTextStyle.f_18_600.colorWhite).paddingSymmetric(horizontal: 30.w),
                    Expanded(
                      child: MyImage(
                        'otc/c2c/c2c_merchant_lineR'.svgAssets(),
                        height: 5.h,
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 8.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: LocaleKeys.c2c323.tr, style: AppTextStyle.f_12_400.colorCCCCCC),
                            TextSpan(
                                text: ' ${LocaleKeys.c2c324.tr} ',
                                style: AppTextStyle.f_12_400.copyWith(color: const Color(0xFFFFD428))),
                            TextSpan(text: LocaleKeys.c2c325.tr, style: AppTextStyle.f_12_400.colorCCCCCC),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 30.w),
              ],
            ),
          ),
          SizedBox(
            height: 140.w,
            child: Stack(
              children: [
                // Swiper(
                //   controller: controller.swiperController,
                //   viewportFraction: 0.92,
                //   onIndexChanged: (index) {
                //     // controller.currentIndex.value = index;

                //     // Estimate the page offset based on the current index and viewport fraction
                //     // double viewportFraction = 0.92; // The same value as used in Swiper
                //     // double scale = 1.0 - (index - index).abs() * 0.2;
                //     // double pageOffset = (index - index) * (1 - viewportFraction);
                //     // controller.pageOffset.value = pageOffset;
                //   },
                //   itemBuilder: (BuildContext context, int index) {
                //     return Container(
                //         margin: EdgeInsets.symmetric(horizontal: 5.w),
                //         decoration: const BoxDecoration(
                //             image: DecorationImage(
                //                 image: AssetImage('assets/images/otc/c2c/c2c_merchant_0.png'), fit: BoxFit.fill)),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Row(
                //               children: [
                //                 Container(
                //                     alignment: Alignment.center,
                //                     margin: EdgeInsets.only(top: 16.w),
                //                     padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.w),
                //                     decoration: BoxDecoration(
                //                       borderRadius: const BorderRadius.only(
                //                         topLeft: Radius.circular(9),
                //                         bottomRight: Radius.circular(9),
                //                       ),
                //                       border: Border.all(color: AppColor.color999999),
                //                     ),
                //                     child: Text('当前', style: AppTextStyle.small3_500.colorCCCCCC)),
                //               ],
                //             ),
                //             Text('黄金商家', style: AppTextStyle.h5_600.colorWhite).paddingOnly(top: 12.w, left: 24.w),
                //             Text('成为黄金商家，享受更多权益', style: AppTextStyle.small_300.color999999).paddingOnly(top: 6.w, left: 24.w)
                //           ],
                //         ));
                //   },
                //   itemCount: 5,
                //   autoplay: false,
                //   loop: false,
                // ),

                PageView.builder(
                    itemCount: controller.merchantTypeList.length,
                    controller: controller.pageController,
                    itemBuilder: (c, index) {
                      var model = controller.merchantTypeList[index];
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                              // color: Colors.amber,
                              image: DecorationImage(
                                  image: AssetImage('assets/images/otc/c2c/c2c_merchant_$index.png'), fit: BoxFit.fill)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              controller.applyInfo?.merchantType == index
                                  ? Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: 16.w),
                                            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.w),
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(9),
                                                bottomRight: Radius.circular(9),
                                              ),
                                              border: Border.all(color: AppColor.color999999),
                                            ),
                                            child: Text(LocaleKeys.follow173.tr, style: AppTextStyle.f_10_500.colorCCCCCC)),
                                      ],
                                    )
                                  : SizedBox(height: 34.w),
                              Text(model.title, style: AppTextStyle.f_20_600.colorWhite).paddingOnly(top: 12.w, left: 24.w),
                              Text(model.des, style: AppTextStyle.f_12_300.color999999).paddingOnly(top: 6.w, left: 24.w)
                            ],
                          ));
                      // );
                    }),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0,
                  child: MyImage(
                    'assets/images/otc/c2c/c2c_merchant_bottom.png',
                    height: 31.w,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
          getView(context),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MyImage(
                  'otc/c2c/c2c_merchant_lineL'.svgAssets(),
                  height: 5.h,
                ),
              ),
              Text(LocaleKeys.c2c340.tr, style: AppTextStyle.f_18_600.colorWhite).paddingSymmetric(horizontal: 30.w),
              Expanded(
                child: MyImage(
                  'otc/c2c/c2c_merchant_lineR'.svgAssets(),
                  height: 5.h,
                ),
              ),
            ],
          ).paddingOnly(top: 14.w, bottom: 20.w),
          Container(
            height: 206.w,
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.color232323, width: 1),
                bottom: BorderSide(color: AppColor.color232323, width: 1),
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                    width: 104.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(LocaleKeys.c2c341.tr, maxLines: 1, minFontSize: 4, style: AppTextStyle.f_14_600.colorWhite)
                            .paddingOnly(top: 18.w, bottom: 30.w),
                        Text(LocaleKeys.c2c342.tr, style: AppTextStyle.f_12_300.colorDDDDDD),
                        Text(LocaleKeys.c2c343.tr, style: AppTextStyle.f_12_300.colorDDDDDD)
                            .paddingOnly(top: 30.w, bottom: 30.w),
                        Text(LocaleKeys.c2c344.tr, style: AppTextStyle.f_12_300.colorDDDDDD),
                      ],
                    )),
                Expanded(
                  child: Scrollbar(
                    controller: controller.scrollController1,
                    child: SingleChildScrollView(
                      controller: controller.scrollController1,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          ...List.generate(controller.merchantTypeList.length, (index) {
                            return Container(
                                width: 89.w,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: AppColor.color232323, width: 1),
                                  ),
                                ),
                                padding: EdgeInsets.only(top: 18.w),
                                child: Column(
                                  children: <Widget>[
                                    AutoSizeText(controller.merchantTypeList[index].rowTitle,
                                            maxLines: 1, minFontSize: 4, style: AppTextStyle.f_14_600.colorWhite)
                                        .paddingOnly(bottom: 24.w),

                                    // Text(controller.merchantTypeList[index].rowTitle, style: AppTextStyle.medium_600.colorWhite)
                                    //     .paddingOnly(bottom: 24.w),
                                    MyImage(
                                      'otc/c2c/c2c_merchant_star_$index'.svgAssets(),
                                      height: 28.h,
                                    ),
                                    MyImage(
                                      'otc/c2c/c2c_merchant_check_w'.svgAssets(),
                                      height: 10.w,
                                      width: 14.w,
                                    ).paddingOnly(top: 22.w, bottom: 28.w),
                                    MyImage(
                                      'otc/c2c/c2c_merchant_check_w'.svgAssets(),
                                      height: 10.w,
                                      width: 14.w,
                                    ),
                                  ],
                                ));
                          })
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Text(LocaleKeys.c2c345.tr, style: AppTextStyle.f_14_600.colorWhite),
              Container(
                width: 28.w,
                height: 13.w,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 4.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0XFFF54058)),
                child: Text('HOT'.tr, style: AppTextStyle.f_9_800.colorWhite),
              ),
            ],
          ).paddingOnly(left: 24.w, top: 18.w, bottom: 11.w, right: 24.w),
          Container(
            height: 206.w,
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.color232323, width: 1),
                bottom: BorderSide(color: AppColor.color232323, width: 1),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                    width: 104.w,
                    padding: EdgeInsets.only(left: 24.w, right: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(LocaleKeys.c2c346.tr, style: AppTextStyle.f_12_300.colorDDDDDD)
                            .paddingOnly(top: 18.w, bottom: 30.w),
                        Text(LocaleKeys.c2c347.tr, style: AppTextStyle.f_12_300.colorDDDDDD),
                        Text(LocaleKeys.c2c377.tr, style: AppTextStyle.f_12_300.colorDDDDDD).paddingOnly(top: 30.w),
                      ],
                    )),
                Expanded(
                  child: Scrollbar(
                    controller: controller.scrollController2,
                    child: SingleChildScrollView(
                      controller: controller.scrollController2,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          ...List.generate(controller.merchantTypeList.length, (index) {
                            return Container(
                                width: 89.w,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: AppColor.color232323, width: 1),
                                  ),
                                ),
                                padding: EdgeInsets.only(top: 26.w),
                                child: Column(
                                  children: <Widget>[
                                    Text('2${LocaleKeys.c2c348.tr}', style: AppTextStyle.f_12_300.colorDDDDDD)
                                        .paddingOnly(bottom: 44.w),
                                    Text('2${LocaleKeys.c2c348.tr}', style: AppTextStyle.f_12_300.colorDDDDDD)
                                        .paddingOnly(bottom: 44.w),
                                    Text(controller.merchantTypeList[index].amountStr,
                                        style: AppTextStyle.f_12_300.colorDDDDDD),
                                  ],
                                ));
                          })
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MyImage(
                  'otc/c2c/c2c_merchant_lineL'.svgAssets(),
                  height: 5.h,
                ),
              ),
              Text(LocaleKeys.c2c349.tr, style: AppTextStyle.f_18_600.colorWhite).paddingSymmetric(horizontal: 30.w),
              Expanded(
                child: MyImage(
                  'otc/c2c/c2c_merchant_lineR'.svgAssets(),
                  height: 5.h,
                ),
              ),
            ],
          ).paddingOnly(top: 30.w, bottom: 24.w),
          const MerchantBottomView()
        ],
      ),
    );
  }

  Widget getView(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    var h = 194.w;
    var last = 0.0;

    return SizedBox(
      height: h,
      width: w,
      child: Stack(
        children: [
          ...List.generate(
              controller.merchantTypeList.length,
              (index) => Obx(() {
                    bool isRight = controller.pageOffset.value > last;

                    if (controller.pageOffset.value == index * 1.0) {
                      return Positioned(
                          top: 0,
                          left: 0,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                ...controller.merchantTypeList[index].desList.map((e) => Container(
                                      width: 375.w,
                                      padding: EdgeInsets.only(left: 24.w, top: 20.w, right: 24.w),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MyImage(
                                            'otc/c2c/c2c_merchant_check'.svgAssets(),
                                            height: 10.w,
                                            width: 14.w,
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(text: e.first, style: AppTextStyle.f_13_500.colorWhite),
                                                  TextSpan(
                                                      text: e.last,
                                                      style: AppTextStyle.f_13_500.copyWith(color: const Color(0xFFFFD428))),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ));
                    } else if (controller.pageOffset > index) {
                      var opacity = 1 - (controller.pageOffset.value % 1) * (isRight ? 2 : 1);
                      var pageOffset = (controller.pageOffset.value - index);
                      var top = isRight ? pageOffset : pageOffset * 1;

                      return Positioned(
                          top: top * h,
                          left: 0,
                          child: Opacity(
                            opacity: opacity > 1
                                ? 1
                                : opacity < 0.4
                                    ? 0
                                    : opacity,
                            child: Column(
                              children: <Widget>[
                                ...controller.merchantTypeList[index].desList.map((e) => Container(
                                      width: 375.w,
                                      padding: EdgeInsets.only(left: 24.w, top: 20.w, right: 24.w),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MyImage(
                                            'otc/c2c/c2c_merchant_check'.svgAssets(),
                                            height: 10.w,
                                            width: 14.w,
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(text: e.first, style: AppTextStyle.f_13_500.colorWhite),
                                                  TextSpan(
                                                      text: e.last,
                                                      style: AppTextStyle.f_13_500.copyWith(color: const Color(0xFFFFD428))),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ));
                    } else {
                      var opacity = (controller.pageOffset.value % 1) * (isRight ? 2 : 1);
                      var offset = opacity < 1 ? opacity : 1;
                      var top = index - controller.pageOffset.value.floor() - offset;
                      last = controller.pageOffset.value;

                      // if (index == 2) {
                      //   print('hhhhhhhhh----------22------${controller.pageOffset.value}  offset:$offset  top:$top');
                      // }

                      return Positioned(
                          top: top * h,
                          left: 0,
                          child: Opacity(
                            opacity: opacity > 1
                                ? 1
                                : opacity < 0.6
                                    ? 0
                                    : opacity,
                            child: Column(
                              children: <Widget>[
                                ...controller.merchantTypeList[index].desList.map((e) => Container(
                                      width: 375.w,
                                      padding: EdgeInsets.only(left: 24.w, top: 20.w, right: 24.w),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MyImage(
                                            'otc/c2c/c2c_merchant_check'.svgAssets(),
                                            height: 10.w,
                                            width: 14.w,
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(text: e.first, style: AppTextStyle.f_13_500.colorWhite),
                                                  TextSpan(
                                                      text: e.last,
                                                      style: AppTextStyle.f_13_500.copyWith(color: const Color(0xFFFFD428))),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ));
                    }
                  }))
        ],
      ),
    );
  }
}

class MerchantBottomView extends StatelessWidget {
  const MerchantBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 26.w,
          top: 20.h,
          bottom: 20.h,
          child: CustomPaint(
              painter: DashedBorderPainter(
            color: const Color(0xFF3F3F3F),
            strokeWidth: 1,
            dashWidth: 3,
            gapWidth: 4,
          )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8.w),
                      alignment: Alignment.center,
                      width: 20.w,
                      height: 30.w,
                      color: AppColor.color111111,
                      child: Container(
                          height: 20.w,
                          alignment: Alignment.center,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(side: BorderSide(width: 1, color: Color(0xFF3F3F3F))),
                          ),
                          child: Text('1', style: AppTextStyle.f_13_600.colorWhite)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
                      child: Text(LocaleKeys.c2c73.tr, style: AppTextStyle.f_14_600.colorWhite),
                    )
                  ],
                ).paddingOnly(bottom: 16.w),
                getRow(LocaleKeys.c2c350.tr),
                Container(
                  color: const Color(0xFF232323),
                  height: 1,
                  margin: EdgeInsets.fromLTRB(16.w, 16.w, 0, 16.w),
                ),
                getRow(LocaleKeys.c2c366.tr),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 8.w),
                          alignment: Alignment.center,
                          width: 20.w,
                          height: 30.w,
                          color: AppColor.color111111,
                          child: Container(
                              height: 20.w,
                              alignment: Alignment.center,
                              decoration: const ShapeDecoration(
                                shape: OvalBorder(side: BorderSide(width: 1, color: Color(0xFF3F3F3F))),
                              ),
                              child: Text('2', style: AppTextStyle.f_13_600.colorWhite)),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
                      child: Text(LocaleKeys.c2c352.tr, style: AppTextStyle.f_14_600.colorWhite),
                    )
                  ],
                ).paddingOnly(top: 24.w, bottom: 16.w),
                getRow(LocaleKeys.c2c353.tr),
                Container(
                  color: const Color(0xFF232323),
                  height: 1,
                  margin: EdgeInsets.fromLTRB(16.w, 16.w, 0, 16.w),
                ),
                getRow(LocaleKeys.c2c354.tr),
              ],
            ),
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8.w),
                      alignment: Alignment.center,
                      width: 20.w,
                      height: 30.w,
                      color: AppColor.color111111,
                      child: Container(
                          height: 20.w,
                          alignment: Alignment.center,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(side: BorderSide(width: 1, color: Color(0xFF3F3F3F))),
                          ),
                          child: Text('3', style: AppTextStyle.f_13_600.colorWhite)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
                        child: Text(LocaleKeys.c2c355.tr, style: AppTextStyle.f_14_600.colorWhite.ellipsis),
                      ),
                    )
                  ],
                ).paddingOnly(top: 24.w, bottom: 16.w),
                getRow(LocaleKeys.c2c356.tr),
                Container(
                  color: const Color(0xFF232323),
                  height: 1,
                  margin: EdgeInsets.fromLTRB(16.w, 16.w, 0, 16.w),
                ),
                getRow(LocaleKeys.c2c357.tr)
              ],
            )
          ],
        ).paddingOnly(left: 16.w, bottom: 50.w)
      ],
    );
  }

  getRow(String str) {
    return Padding(
      padding: EdgeInsets.only(left: 28.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyImage(
            'default/selected_success'.svgAssets(),
            height: 15.w,
            width: 15.w,
          ),
          SizedBox(width: 5.w),
          Text(str, style: AppTextStyle.f_13_400.colorDDDDDD),
        ],
      ),
    );
  }
}

class MerchantApplyBottomView extends StatelessWidget {
  const MerchantApplyBottomView({super.key, required this.controller});
  final MerchantApplyController controller;

  @override
  Widget build(BuildContext context) {
    var state = controller.applyInfo?.otcStatus;
    if (state == OTCApplyStatus.fillForm || state == OTCApplyStatus.payDeposit) {
      return SizedBox(
          height: 134.w + MediaQuery.of(context).padding.bottom,
          child: Obx(() => Column(
                children: [
                  Container(
                    color: AppColor.color1A1A1A,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 9.w, bottom: 9.w),
                    margin: EdgeInsets.only(bottom: 16.w),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '${LocaleKeys.c2c358.tr} ', style: AppTextStyle.f_14_600.colorWhite),
                          TextSpan(
                              text: controller.merchantTypeList[controller.currentIndex.value].tipTitle,
                              style: AppTextStyle.f_14_600.copyWith(color: const Color(0xFFFFD428))),
                          TextSpan(text: ' USDT ${LocaleKeys.c2c359.tr}', style: AppTextStyle.f_14_600.colorWhite),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h + MediaQuery.of(context).padding.bottom),
                      child: MyButton(
                          height: 48.w,
                          text: controller.merchantTypeList[controller.currentIndex.value].buttonTitle,
                          color: AppColor.color111111,
                          backgroundColor: const Color(0xFFFFD428),
                          goIcon: true,
                          goIconColor: AppColor.color111111,
                          onTap: () {
                            controller.performCase();
                          })),
                ],
              )));
    } else if (state == OTCApplyStatus.verifying || state == OTCApplyStatus.revoking) {
      return SizedBox(
          height: 134.w + MediaQuery.of(context).padding.bottom,
          child: Obx(() => Column(
                children: [
                  Container(
                    color: AppColor.color1A1A1A,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 9.w, bottom: 2.w),
                    margin: EdgeInsets.only(bottom: 16.w),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: controller.merchantTypeList[controller.currentIndex.value].tipTitle,
                              style: AppTextStyle.f_14_600.colorCCCCCC),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h + MediaQuery.of(context).padding.bottom),
                      child: MyButton(
                          height: 48.w,
                          text: controller.merchantTypeList[controller.currentIndex.value].buttonTitle,
                          color: AppColor.color7E7E7E,
                          goIcon: false,
                          border: Border.all(width: 1, color: const Color(0XFF3F3F3F)),
                          onTap: () {
                            controller.performCase();
                          })),
                ],
              )));
    } else if (state == OTCApplyStatus.verifySucces) {
      return SizedBox(
          height: 140.w + MediaQuery.of(context).padding.bottom,
          child: Obx(() => Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 9.w, bottom: 7.w, left: 10.w),
                    margin: EdgeInsets.only(bottom: 16.w),
                    child: Row(
                      children: [
                        MyImage(
                          controller.merchantTypeList[controller.currentIndex.value].imageStr.svgAssets(),
                          height: 30.h,
                        ).marginOnly(right: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(controller.merchantTypeList[controller.currentIndex.value].tipTitle,
                                  style: AppTextStyle.f_12_500.colorWhite),
                              SizedBox(height: 4.w),
                              Text(
                                LocaleKeys.c2c364.tr,
                                style: AppTextStyle.f_10_400.color999999,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h + MediaQuery.of(context).padding.bottom),
                      child: MyButton(
                          height: 48.w,
                          text: controller.merchantTypeList[controller.currentIndex.value].buttonTitle,
                          color: AppColor.colorFFFFFF,
                          goIcon: false,
                          border: Border.all(width: 1, color: const Color(0XFF3F3F3F)),
                          onTap: () {
                            controller.performCase();
                          })),
                ],
              )));
    } else {
      return const SizedBox();
    }
  }
}
