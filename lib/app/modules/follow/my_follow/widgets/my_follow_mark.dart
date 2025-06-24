// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_detail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_item.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_tabbar.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_draw.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_translate.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

enum FollowMarkType {
  mark,
  recommend,
  userInfo;
}

showFollowMarkheetView(
    {required BuildContext currentContext,
    FollowMarkType bottomType = FollowMarkType.userInfo,
    FollowkolUserDetailModel? detailModel,
    TextEditingController? textVC,
    VoidCallback? callback,
    bool isGood = true}) {
  showModalBottomSheet(
    context: Get.context ?? Get.overlayContext!,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FollowMarkBottomSheet(
            detailModel: detailModel,
            textVC: textVC,
            isGood: isGood,
            type: bottomType,
            currentContext: context,
            callback: callback),
      );
    },
  ).then((result) {});
}

class FollowMarkBottomSheet extends StatefulWidget {
  const FollowMarkBottomSheet(
      {super.key,
      required this.type,
      this.detailModel,
      this.textVC,
      this.isGood = true,
      required this.currentContext,
      this.callback});
  final FollowMarkType type;
  final FollowkolUserDetailModel? detailModel;
  final TextEditingController? textVC;
  final bool isGood;
  final BuildContext currentContext;
  final VoidCallback? callback;
  @override
  State<FollowMarkBottomSheet> createState() => _FollowMarkBottomSheetState();
}

class _FollowMarkBottomSheetState extends State<FollowMarkBottomSheet> with TickerProviderStateMixin {
  late AnimationController? controller;
  var jsonIndex = 0.obs;
  @override
  void initState() {
    super.initState();
    if (widget.type != FollowMarkType.userInfo) {
      getCommentTraderList();
    }

    if (widget.type == FollowMarkType.recommend) {
      controller = AnimationController(vsync: this)
        ..addListener(() {
          if (controller!.isCompleted) {
            jsonIndex.value = 1;
          }
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case FollowMarkType.mark:
        return SingleChildScrollView(child: getMarkView(widget.currentContext, widget.detailModel!));

      case FollowMarkType.recommend:
        return Container(
          decoration: const BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 4,
                    margin: EdgeInsets.only(top: 8.w, bottom: 20.w),
                    decoration: ShapeDecoration(
                      color: AppColor.colorCCCCCC,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child: widget.isGood
                            ? getRecommendView(widget.currentContext, widget.detailModel!)
                            : getRecommendFailView(widget.currentContext, widget.detailModel!)),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: AppColor.colorWhite,
                    child: Column(
                      children: <Widget>[
                        const Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyButton(
                                  height: 48.w,
                                  text: LocaleKeys.public1.tr,
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
                  ))
            ],
          ),
        );

      default:
        return getUserInfoView(widget.currentContext, widget.detailModel!);
    }
  }

  getMarkView(BuildContext context, FollowkolUserDetailModel model) {
    var selectArr = [LocaleKeys.follow478.tr, LocaleKeys.follow479.tr, LocaleKeys.follow480.tr, LocaleKeys.follow481.tr];
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(bottom: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Column(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 4,
                  margin: EdgeInsets.only(top: 8.w, bottom: 20.w),
                  decoration: ShapeDecoration(
                    color: AppColor.colorCCCCCC,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                UserAvatar(model.icon, width: 70.w, height: 70.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(model.userName, style: AppTextStyle.f_18_600.color111111),
                    model.flagIcon.isNotEmpty
                        ? Row(
                            children: <Widget>[
                              8.horizontalSpace,
                              MyImage(model.flagIcon, width: 18.w, height: 12.w),
                            ],
                          )
                        : const SizedBox()
                  ],
                ).paddingSymmetric(vertical: 24.w),
                Text(LocaleKeys.follow476, style: AppTextStyle.f_14_500.color4D4D4D).marginOnly(bottom: 16.w),
                FollowStarWidget(
                    callback: (index) {
                      widget.detailModel!.rating.value = index;
                    },
                    score: 5,
                    size: 32,
                    offsetX: 16,
                    bottomTopOffset: 4,
                    isHollow: false,
                    bottomWidgetArr: [
                      LocaleKeys.follow482.tr,
                      LocaleKeys.follow483.tr,
                      LocaleKeys.follow484.tr,
                      LocaleKeys.follow485.tr,
                      LocaleKeys.follow486.tr,
                    ]),
                Obx(() => widget.detailModel!.rating.value < 3
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(LocaleKeys.follow477.tr, style: AppTextStyle.f_14_500.color333333)
                              .paddingOnly(top: 24.w, bottom: 12.w),
                          InkWell(
                            onTap: () {
                              showFollowFilterSheetView(selectArr, widget.detailModel!.valueType.value, (i) {
                                widget.detailModel!.valueType.value = i;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF4F6F8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(selectArr[widget.detailModel!.valueType.value],
                                      style: AppTextStyle.f_14_500.color111111),
                                  MyImage(
                                    'otc/c2c/c2c_more'.svgAssets(),
                                    fit: BoxFit.cover,
                                    width: 20.w,
                                    height: 20.h,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : const SizedBox()),
                Container(
                    height: 180.w,
                    margin: EdgeInsets.only(top: 24.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                    decoration: BoxDecoration(color: AppColor.colorF5F5F5, borderRadius: BorderRadius.circular(6.r)),
                    child: TextField(
                      maxLines: 8,
                      onChanged: (text) {},
                      textInputAction: TextInputAction.done,
                      maxLength: 300,
                      controller: widget.textVC,
                      style: AppTextStyle.f_14_500,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        hintText: '${LocaleKeys.follow516.tr}...'.tr,
                        hintStyle: AppTextStyle.f_14_400.colorABABAB,
                        helperStyle: AppTextStyle.f_14_400.colorABABAB,
                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.transparent)),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.transparent)),
                        counterStyle: AppTextStyle.f_12_400.color999999,
                      ),
                    )),
              ],
            ),
          ),
          6.verticalSpace,
          const Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
            child: Row(
              children: [
                Expanded(
                  child: MyButton(
                    height: 48.w,
                    text: LocaleKeys.public1.tr,
                    onTap: () {
                      AFFollow.postAddRating(
                              reviewer: UserGetx.to.uid ?? -1,
                              reviewedTrader: model.uid,
                              rating: model.rating.value,
                              sortValue: model.rating.value < 3 ? model.valueType.value : null,
                              comment: widget.textVC?.text ?? '')
                          .then((value) {
                        if (value == null) {
                          widget.callback?.call();
                          Get.back();
                          // Future.delayed(const Duration(milliseconds: 1000), () {
                          showFollowMarkheetView(
                              currentContext: context,
                              bottomType: FollowMarkType.recommend,
                              isGood: model.rating.value < 3 ? false : true,
                              detailModel: widget.detailModel);
                          UIUtil.showSuccess(LocaleKeys.public12.tr);
                          // });
                        } else {
                          UIUtil.showSuccess(LocaleKeys.public13.tr);
                        }
                      });
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

  getRecommendView(BuildContext context, FollowkolUserDetailModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.FOLLOW_QUESTIONNAIRE);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                    color: const Color(0x19FFD428),
                    child: Row(
                      children: [
                        MyImage(
                          'flow/follow_top_answer'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        ),
                        Expanded(
                            child: Text(LocaleKeys.follow437.tr,
                                    style: AppTextStyle.f_12_500.copyWith(color: const Color(0xFF734D03)))
                                .paddingSymmetric(horizontal: 8.w)),
                        MyImage(
                          'default/go'.svgAssets(),
                          width: 16.w,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.w),
                  child: Obx(() => jsonIndex.value == 0
                      ? Lottie.asset(
                          'assets/json/cool1.json',
                          controller: controller,
                          repeat: true,
                          onLoaded: (composition) {
                            controller?.duration = composition.duration;
                            controller?.forward();
                          },
                          width: 101.w,
                          height: 105.w,
                        )
                      : Lottie.asset(
                          'assets/json/cool2.json',
                          repeat: true,
                          width: 101.w,
                          height: 105.w,
                        )),
                ),
                Text(LocaleKeys.follow487.tr, style: AppTextStyle.f_16_500.color4D4D4D),
              ],
            ).paddingSymmetric(horizontal: 16.w),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 60.w),
                padding: EdgeInsets.only(top: 16.w, bottom: 8.w, left: 16.w),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColor.colorF5F5F5, width: 1.0),
                  ),
                ),
                child: Text(LocaleKeys.follow488.tr, style: AppTextStyle.f_15_600.color111111)),
            Obx(() => model.gridModel.value.favorableCommentTraderList1?.isNotEmpty == true
                ? SizedBox(
                    // color: Colors.green,
                    height: 78.w,

                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.back();
                            var uid = model.gridModel.value.favorableCommentTraderList1![index].uid;
                            Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': uid}, preventDuplicates: false);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1, color: AppColor.colorF5F5F5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: FollowOrdersCellTop(model: model.gridModel.value.favorableCommentTraderList1![index])),
                        );
                      },
                      itemCount: model.gridModel.value.favorableCommentTraderList1!.length,
                      viewportFraction: 0.9,
                      loop: false,
                    ),
                  )
                : const SizedBox()),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '${LocaleKeys.follow94.tr} ', style: AppTextStyle.f_15_600.color111111),
                      TextSpan(text: 'Mihail Tsankov', style: AppTextStyle.f_15_600.tradingYel),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(left: 16.w, top: 24.w, bottom: 12.w),
            Obx(() => model.gridModel.value.favorableCommentTraderList2?.isNotEmpty == true
                ? Container(
                    // color: Colors.green,
                    height: 294.w,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return FollowOrdersItem(
                          callback: () {
                            Get.back();
                          },
                          model: model.gridModel.value.favorableCommentTraderList2![index],
                          right: (index == model.gridModel.value.favorableCommentTraderList2!.length - 1) ? 0 : 12,
                        );
                      },
                      itemCount: model.gridModel.value.favorableCommentTraderList2!.length,
                      viewportFraction: 0.9,
                      loop: false,
                    ),
                  )
                : const SizedBox()),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 120)
          ],
        ),
      ],
    );
  }

  getRecommendFailView(BuildContext context, FollowkolUserDetailModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.w),
                  child: Obx(() => jsonIndex.value == 0
                      ? Lottie.asset(
                          'assets/json/cry1.json',
                          controller: controller,
                          repeat: true,
                          onLoaded: (composition) {
                            controller?.duration = composition.duration;
                            controller?.forward();
                          },
                          width: 101.w,
                          height: 105.w,
                        )
                      : Lottie.asset(
                          'assets/json/cry2.json',
                          repeat: true,
                          width: 101.w,
                          height: 105.w,
                        )),
                ),
                Text(LocaleKeys.follow489.tr, style: AppTextStyle.f_16_500.color4D4D4D),
                Container(
                    margin: EdgeInsets.only(top: 40.w),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: ShapeDecoration(
                      color: Color(0x19FFD428),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(LocaleKeys.follow490.tr, style: AppTextStyle.f_15_600.copyWith(color: const Color(0xFF734D03))),
                        8.verticalSpace,
                        Text(LocaleKeys.follow491.tr,
                            textAlign: TextAlign.center, style: AppTextStyle.f_11_400.copyWith(color: const Color(0xFF734D03))),
                        12.verticalSpace,
                        MyButton(
                          height: 28.w,
                          width: 164.w,
                          text: LocaleKeys.follow492.tr,
                          textStyle: AppTextStyle.f_13_500,
                          onTap: () {
                            Get.back();
                            Get.toNamed(Routes.FOLLOW_QUESTIONNAIRE);
                          },
                        )
                      ],
                    )),
              ],
            ).paddingSymmetric(horizontal: 16.w),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 24.w),
                padding: EdgeInsets.only(top: 24.w, bottom: 12.w, left: 16.w),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColor.colorF5F5F5, width: 1.0),
                  ),
                ),
                child: Text(LocaleKeys.follow493.tr, style: AppTextStyle.f_15_600.color111111)),
            Obx(() => model.gridModel.value.badTraderList?.isNotEmpty == true
                ? Container(
                    // color: Colors.green,
                    height: 294.w,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return FollowOrdersItem(
                          callback: () {
                            Get.back();
                          },
                          model: model.gridModel.value.badTraderList![index],
                          // controller: controller,
                          right: (index == model.gridModel.value.badTraderList!.length - 1) ? 0 : 12,
                        );
                      },
                      itemCount: model.gridModel.value.badTraderList!.length,
                      viewportFraction: 0.9,
                      loop: false,
                    ),
                  )
                : const SizedBox()),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 120)
          ],
        )
      ],
    );
  }

  getUserInfoView(BuildContext context, FollowkolUserDetailModel model) {
    return Container(
      height: MediaQuery.of(context).size.height - 100.w,
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(bottom: 16.w),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 60,
                height: 4,
                margin: EdgeInsets.only(top: 8.w, bottom: 20.w),
                decoration: ShapeDecoration(
                  color: AppColor.colorCCCCCC,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Column(
                          children: <Widget>[
                            UserAvatar(
                              model.icon,
                              width: 60.w,
                              height: 60.w,
                              levelType: model.levelType,
                              isTrader: true,
                              tradeIconSize: 20.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(model.userName, style: AppTextStyle.f_18_600.color111111),
                                8.horizontalSpace,
                                model.flagIcon.isNotEmpty
                                    ? MyImage(model.flagIcon, width: 18.w, height: 12.w)
                                    : const SizedBox(),
                              ],
                            ).paddingOnly(top: 24.w, bottom: 4.w),
                            model.countryEnName.isNotEmpty
                                ? Text(model.countryEnName, style: AppTextStyle.f_12_400.color999999).marginOnly(top: 4.w)
                                : const SizedBox(),
                            Obx(() => Text(model.labelStr.value, style: AppTextStyle.f_15_400.color333333)
                                .marginOnly(top: 24.w, bottom: 180.w))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: AppColor.colorWhite,
                child: Column(
                  children: <Widget>[
                    const Divider(),
                    FollowTranslateView(sourceRXStr: model.labelStr, sourceStr: model.signatureStr)
                        .paddingSymmetric(vertical: 10.w),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyButton(
                              height: 48.w,
                              text: LocaleKeys.trade210.tr,
                              backgroundColor: AppColor.colorF1F1F1,
                              color: AppColor.color111111,
                              textStyle: AppTextStyle.f_14_600,
                              onTap: () {
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  getCommentTraderList() {
    AFFollow.getCommentTraderList(widget.detailModel?.uid).then((value) {
      widget.detailModel?.gridModel.value = value;
    });
  }
}
