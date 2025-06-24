import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/controllers/follow_orders_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_data_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_select.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../../follow_taker_info/widgets/follow_taker_draw.dart';

class FollowOrdersItem extends StatelessWidget {
  const FollowOrdersItem(
      {super.key,
      required this.model,
      this.index = 0,
      this.takeType,
      this.controller,
      this.right = 0,
      this.left = 0,
      this.isRecommend = false,
      this.callback,
      this.paddingBottom = 16});

  final FollowKolInfo model;
  final double right;
  final double left;
  final int index;
  final double paddingBottom;

  final TraderType? takeType;
  final FollowOrdersController? controller;
  final bool isRecommend;
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          callback?.call();
          Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.uid}, preventDuplicates: false);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(12.w, 16.w, 12.w, paddingBottom.w),
          margin: EdgeInsets.only(left: left.w, right: right.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.colorF5F5F5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FollowOrdersCellTop(model: model, controller: controller),
              FollowOrdersCellTopSignature(signature: model.signatureInfoStr),
              isRecommend
                  ? const SizedBox()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(LocaleKeys.follow8.tr, style: AppTextStyle.f_9_400.color999999),
                              Text(model.monthProfitRateStr,
                                  style: AppTextStyle.f_20_600.copyWith(color: model.monthProfitRateColor)),
                              Row(
                                children: <Widget>[
                                  Text(LocaleKeys.follow9.tr, style: AppTextStyle.f_10_400.color999999),
                                  2.horizontalSpace,
                                  Text(model.winRateStr,
                                      style: AppTextStyle.f_10_500.copyWith(color: model.monthProfitAmountColor))
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 139.w,
                            height: 55.h,
                            child: FollowStockChart(key: UniqueKey(), profitRateList: model.monthProfitRateList))
                      ],
                    ).paddingOnly(bottom: 16.w),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(model.weekNumStr, style: AppTextStyle.f_12_500.color333333),
                        Text(LocaleKeys.follow441.tr, style: AppTextStyle.f_9_400_15.color999999),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        model.symbolList?.isNotEmpty == false
                            ? const SizedBox()
                            : GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FollowOrderSelect(symbolList: model.symbolList)),
                                  );
                                },
                                child: ImageStackPage(symbolList: model.symbolList),
                              ),
                        Text(LocaleKeys.follow442.tr, style: AppTextStyle.f_9_400_15.color999999),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FollowStarWidget(
                              score: model.userRatingNum,
                              size: 8,
                            ),
                            Text(LocaleKeys.follow443.tr, style: AppTextStyle.f_9_400_15.color999999),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.w),
                                decoration: ShapeDecoration(
                                  color: model.riskRatingColor.withAlpha(20),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 0.60, color: model.riskRatingColor),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                child: Text(
                                  model.riskRatingStr,
                                  style: AppTextStyle.f_9_500.copyWith(color: model.riskRatingColor),
                                )),
                            Text(LocaleKeys.follow444.tr, style: AppTextStyle.f_9_400_15.color999999),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isRecommend
                  ? Container(
                      height: 78.w,
                      width: 311.w,
                      margin: EdgeInsets.only(top: 16.w),
                      child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            RecordVoListItem item = model.recordVoList![index];
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              margin: EdgeInsets.symmetric(vertical: 2.w),
                              decoration: ShapeDecoration(
                                // color: index == 0
                                //     ? Colors.amber
                                //     : index == 1
                                //         ? Colors.red
                                //         : Colors.green,
                                color: AppColor.colorF9F9F9,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(item.email ?? "--", style: AppTextStyle.f_12_400.color4D4D4D),
                                  SizedBox(width: 12.w),
                                  Text('${LocaleKeys.follow511.tr}${item.profit} USDDT', style: AppTextStyle.f_12_500.upColor)
                                ],
                              ),
                            );
                          },
                          itemCount: model.recordVoList?.length ?? 0,
                          viewportFraction: 0.4,
                          scale: 0.6,
                          loop: true,
                          autoplay: true,
                          autoplayDelay: 1000,
                          scrollDirection: Axis.vertical,
                          axisDirection: AxisDirection.up),
                    )
                  : const SizedBox(),
              controller?.isTrader == true
                  ? const SizedBox()
                  : getButton(index: index, takeType: takeType).paddingOnly(top: 16.w)
            ],
          ),
        ));
  }

  Widget getButton({int index = 0, TraderType? takeType}) {
    if (index == 0 && takeType == TraderType.daily && controller!.showGuide) {
      return getGuideButton(callback: () {
        controller!.showNoti = true;
        controller!.update();
      });
    } else {
      if (model.followStatus == 1) {
        return MyButton.borderWhiteBg(
            onTap: () {
              Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isEdit': true, 'isSmart': model.isSmart});
            },
            text: LocaleKeys.follow13.tr,
            height: 36.h,
            textStyle: AppTextStyle.f_13_500.colorWhite,
            padding: EdgeInsets.symmetric(horizontal: 8.w));
      } else {
        if (model.switchFollowerNumber == 2) {
          return MyButton(
            text: LocaleKeys.follow14.tr,
            height: 36.h,
            textStyle: AppTextStyle.f_13_500,
            color: AppColor.colorABABAB,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            backgroundColor: AppColor.colorF1F1F1,
          );
        } else {
          if (model.copySwitch == 0) {
            if (model.applyFollowStatus == 0) {
              //申请中
              return MyButton(
                text: LocaleKeys.follow15.tr,
                height: 36.h,
                textStyle: AppTextStyle.f_13_500,
                color: AppColor.colorABABAB,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                backgroundColor: AppColor.colorF1F1F1,
              );
            } else if (model.applyFollowStatus == 1) {
              //通过
              return Row(
                children: [
                  Expanded(
                    flex: 100,
                    child: MyButton.borderWhiteBg(
                      height: 36.h,
                      text: LocaleKeys.follow17.tr,
                      textStyle: AppTextStyle.f_12_600.color111111,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      onTap: () {
                        if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                          showshieldSheetView(
                              model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                              callback: () => Get.back());
                        } else {
                          Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isSmart': false});
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    flex: 213,
                    child: MyButton(
                      text: LocaleKeys.follow16.tr,
                      height: 36.h,
                      textStyle: AppTextStyle.f_12_600.colorWhite,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      onTap: () {
                        if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                          showshieldSheetView(
                              model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                              callback: () => Get.back());
                        } else {
                          Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isSmart': true});
                        }
                      },
                    ),
                  )
                ],
              );
            } else {
              //去申请
              return FollowOrderItemApplyBtn(model: model);
            }
          } else {
            return Row(
              children: [
                Expanded(
                  flex: 100,
                  child: MyButton.borderWhiteBg(
                    height: 36.h,
                    text: LocaleKeys.follow17.tr,
                    textStyle: AppTextStyle.f_12_600.color111111,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    onTap: () {
                      if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                        showshieldSheetView(model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                            callback: () => Get.back());
                      } else {
                        Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isSmart': false});
                      }
                    },
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  flex: 213,
                  child: MyButton(
                    text: LocaleKeys.follow16.tr,
                    height: 36.h,
                    textStyle: AppTextStyle.f_12_600.colorWhite,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    onTap: () {
                      if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                        showshieldSheetView(model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                            callback: () => Get.back());
                      } else {
                        Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isSmart': true});
                      }
                    },
                  ),
                )
              ],
            );
          }
        }
      }
    }
  }

  Widget getGuideButton({VoidCallback? callback}) {
    return AppGuideView(
        order: 1,
        guideType: AppGuideType.follow,
        arrowPosition: AppGuideArrowPosition.top,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.w),
        currentSetpCallback: callback,
        child: Row(
          children: [
            Expanded(
              flex: 100,
              child: MyButton.borderWhiteBg(
                height: 36.h,
                text: LocaleKeys.follow17.tr,
                textStyle: AppTextStyle.f_12_600.color111111,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                onTap: () {
                  if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                    showshieldSheetView(model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                        callback: () => Get.back());
                  } else {
                    Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isSmart': false});
                  }
                },
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              flex: 213,
              child: MyButton(
                text: LocaleKeys.follow16.tr,
                height: 36.h,
                textStyle: AppTextStyle.f_12_600.colorWhite,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                onTap: () {
                  if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                    showshieldSheetView(model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                        callback: () => Get.back());
                  } else {
                    Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isSmart': true});
                  }
                },
              ),
            )
          ],
        ));
  }
}

class FollowOrdersCellTop extends StatelessWidget with FollowTag {
  const FollowOrdersCellTop({super.key, required this.model, this.controller});
  final FollowKolInfo model;
  final FollowOrdersController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(
          model.icon,
          width: 46.w,
          height: 46.w,
          levelType: model.levelType,
          isTrader: true,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                        // color: Colors.amber,
                        constraints: BoxConstraints(maxWidth: 115.w),
                        child: Text(model.userName,
                            style: AppTextStyle.f_14_500.color111111.copyWith(overflow: TextOverflow.ellipsis))),
                    ...getIcon([model.flagIcon, ...model.organizationIconList])
                  ],
                ),
                4.verticalSpace,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      ...getTag([model.tradingStyleStr], bordeColor: AppColor.colorAbnormal, color: AppColor.colorAbnormal),
                      ...getTag(model.tradingPairList)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(() => MyButton(
              height: 28.w,
              textStyle: AppTextStyle.f_13_500,
              color: AppColor.color111111,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              backgroundColor: AppColor.colorF9F9F9,
              text: model.isFollowObs.value
                  ? LocaleKeys.community111.tr //'正在关注'
                  : LocaleKeys.community43.tr,
              //'关注',
              onTap: () async {
                if (UserGetx.to.goIsLogin()) {
                  // model.isFollowObs.value = !model.isFollowObs.value;
                  if (controller != null) {
                    controller?.setTraceUserRelation(model.uid, model.isFollowObs);
                  } else {
                    var status = !model.isFollowObs.value;

                    AFFollow.setTraceUserRelation(userId: model.uid.toInt(), status: status ? 1 : 0, types: 0).then((value) {
                      model.isFollowObs.value = status;

                      UIUtil.showSuccess(status ? LocaleKeys.follow117.tr : LocaleKeys.follow118.tr);
                    });
                  }
                }
              },
            ))
      ],
    );
  }
}

mixin FollowTag {
  List<Widget> getIcon(List<String> iamgeArr, {double width = 12}) {
    return iamgeArr
        .map((e) => e.isEmpty
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: MyImage(e, width: width.w, height: 12.w),
              ))
        .toList();
  }

  List<Widget> getTag(List tagArr,
      {Color bordeColor = AppColor.colorECECEC, Color color = AppColor.color999999, Color? backgroundColor}) {
    return tagArr
        .map((e) => e.isEmpty
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                margin: EdgeInsets.only(right: 6.w),
                decoration: ShapeDecoration(
                  color: backgroundColor,
                  shape: RoundedRectangleBorder(
                    side: backgroundColor == null ? BorderSide(width: 0.60, color: bordeColor) : BorderSide.none,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Text(e, style: AppTextStyle.f_9_500.copyWith(color: color)),
              ))
        .toList();
  }
}

class FollowOrdersCellTopSignature extends StatelessWidget {
  const FollowOrdersCellTopSignature({super.key, this.signature, this.vertical = 16});
  final String? signature;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    return signature?.isNotEmpty == true
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: vertical.w),
            child:
                SizedBox(height: 26.w, child: Text(signature!, style: AppTextStyle.f_11_400.color666666.ellipsis, maxLines: 2)),
          )
        : const SizedBox();
  }
}

class FollowOrderItemApplyBtn extends StatefulWidget {
  const FollowOrderItemApplyBtn({super.key, required this.model});

  final FollowKolInfo model;

  @override
  State createState() => _FollowOrderItemApplyBtnState();
}

class _FollowOrderItemApplyBtnState extends State<FollowOrderItemApplyBtn> {
  bool apply = false;

  @override
  Widget build(BuildContext context) {
    return apply
        ? MyButton(
            text: LocaleKeys.follow15.tr,
            height: 36.h,
            textStyle: AppTextStyle.f_13_500,
            color: AppColor.colorABABAB,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            backgroundColor: AppColor.colorF1F1F1,
          )
        : MyButton.borderWhiteBg(
            height: 36.h,
            text: LocaleKeys.follow19.tr,
            textStyle: AppTextStyle.f_13_500.color111111,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            onTap: () {
              if (UserGetx.to.isLogin) {
                if (widget.model.isBlacklistedUsers == 1 || widget.model.isDisableUsers == 1) {
                  showshieldSheetView(
                      widget.model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                      callback: () => Get.back());
                } else {
                  followApply(traderId: widget.model.uid);
                }
              } else {
                Get.toNamed(Routes.LOGIN);
              }
            },
          );
  }

  ///申请跟单
  followApply({num traderId = 1}) {
    AFFollow.postFollowApply(traderId: traderId).then((value) {
      if (value == null) {
        setState(() {
          apply = true;
        });
        UIUtil.showToast(LocaleKeys.follow20.tr);
      } else {
        UIUtil.showToast(LocaleKeys.follow21.tr);
      }
    });
  }
}
