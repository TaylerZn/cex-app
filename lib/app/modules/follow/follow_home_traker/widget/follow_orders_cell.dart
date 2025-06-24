// ignore_for_file: public_member_api_docs, sort_constructors_first;

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/controllers/follow_orders_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_select.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../follow_taker_info/widgets/follow_taker_draw.dart';
import '../../follow_taker_list/model/follow_taker_list_model.dart';

//

class FollowOrdersList extends StatelessWidget {
  const FollowOrdersList({super.key, required this.list, this.takeType = TakerListType.allTraders, this.controller});

  final List<FollowKolInfo> list;
  final TakerListType takeType;
  final FollowOrdersController? controller;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return FollowOrdersCell(
            model: list[index],
            index: index,
            takeType: takeType,
            controller: controller,
          );
        },
        childCount: list.length,
      ),
    );
  }
}

class FollowOrdersCell extends StatelessWidget {
  const FollowOrdersCell(
      {super.key,
      required this.model,
      this.isHome = false,
      this.index = 0,
      this.takeType = TakerListType.foldTraders,
      this.controller});

  final FollowKolInfo model;
  final bool isHome;
  final int index;
  final TakerListType takeType;
  final FollowOrdersController? controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isSmart': false});
          Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.uid});
        },
        behavior: HitTestBehavior.translucent,
        child: isHome
            ? Container(
                width: 166.w,
                height: 170.w,
                padding: EdgeInsets.only(top: 8.w, left: 14.w, right: 14.w),
                child: Column(
                  children: [
                    32.verticalSpaceFromWidth,
                    UserAvatar(
                      model.icon,
                      width: 36.w,
                      height: 36.w,
                      levelType: model.levelType,
                      isTrader: true,
                      tradeIconSize: 14.w,
                    ),
                    8.verticalSpaceFromWidth,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(model.userName.stringSplit(), style: AppTextStyle.f_12_500.colorTextPrimary),
                        if (ObjectUtil.isNotEmpty(model.flagIcon))
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1.w),
                              child: MyImage(
                                model.flagIcon,
                                width: 13.33.w,
                                height: 10.w,
                              ),
                            ),
                          ),
                      ],
                    ),
                    4.verticalSpaceFromWidth,
                    Text(model.monthProfitRateStr, style: AppTextStyle.f_14_600.copyWith(color: model.monthProfitRateColor)),
                    Text('過去 30 天盈虧%', style: AppTextStyle.f_9_400.colorTextDisabled),
                    12.verticalSpaceFromWidth,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: images(context)),
                        SizedBox(
                            // width: 44.w,
                            height: 8.w,
                            child: FollowStarWidget(
                              max: 5,
                              // star: FollowTakerStar(
                              //   fillColor: AppColor.colorFunctionBuy,
                              //   progress: 0,
                              //   num: 5,
                              //   emptyColor: AppColor.colorD9D9D9,
                              //   fat: 0.5,
                              //   size: 8.w,
                              // ),
                              size: 8,
                              //todo white 根据后台给的评分
                              score: model.userRatingNum,
                            )),
                      ],
                    ),
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: AppColor.colorEEEEEE)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        UserAvatar(
                          model.icon,
                          width: 36.w,
                          height: 36.w,
                          levelType: model.levelType,
                          isTrader: true,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(model.userName,
                                    style: AppTextStyle.f_15_500.color111111.copyWith(overflow: TextOverflow.ellipsis)),
                                // Row(
                                //   children: <Widget>[
                                //     MyImage(
                                //       'flow/supervisor_account'.svgAssets(),
                                //       width: 14.w,
                                //     ),
                                //     SizedBox(width: 4.w),
                                //     Text(model.currentNumber.toString(), style: AppTextStyle.small2_500.color333333),
                                //     Text('/${model.maxNumber}', style: AppTextStyle.small2_400.color999999),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                        GetBuilder<UserGetx>(builder: (userGetx) {
                          return userGetx.isKol ? const SizedBox() : getButton(index: index, takeType: takeType);
                        }),
                      ],
                    ),
                    SizedBox(
                        height: 44.h,
                        child: StockChart(
                          profitRateList: model.profitRateList,
                        )).marginSymmetric(vertical: 12.w),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(LocaleKeys.follow8.tr, style: AppTextStyle.f_11_400.color999999),
                              Text(model.monthProfitRateStr,
                                  style: AppTextStyle.f_16_600.copyWith(color: model.monthProfitRateColor)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(LocaleKeys.follow9.tr, style: AppTextStyle.f_11_400.color999999),
                                  Text(model.winRateStr,
                                      style: AppTextStyle.f_16_600.copyWith(color: model.monthProfitAmountColor)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(LocaleKeys.follow306.tr, style: AppTextStyle.f_11_400.color999999),
                              Text(model.compositeScoreStr,
                                  style: AppTextStyle.f_16_600.copyWith(color: model.monthProfitAmountColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: (model.topicId == null && model.symbolList?.isNotEmpty == false) ? 0 : 12.h),
                      child: Container(
                          height: 1.0,
                          color: (model.topicId == null && model.symbolList?.isNotEmpty == false)
                              ? Colors.transparent
                              : AppColor.colorEEEEEE),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        model.topicId != null
                            ? Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.uid, 'currentIndex': 1});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: model.symbolList?.isNotEmpty == false ? 0 : 20.w),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColor.colorF5F5F5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(model.topicTitle ?? '',
                                                style: AppTextStyle.f_11_500.color999999
                                                    .copyWith(overflow: TextOverflow.ellipsis))),
                                        MyImage(
                                          'default/go'.svgAssets(),
                                          width: 12.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ));
  }

  Widget images(BuildContext context) {
    if (ObjectUtil.isEmpty(model.symbolList)) return const SizedBox.shrink();
    int length = model.symbolList!.length;
    return SizedBox(
      height: 14.w,
      child: Stack(
        children: <Widget>[
          ClipOval(
            child: Container(
              padding: EdgeInsets.all(1.w),
              color: AppColor.colorBackgroundPrimary,
              child: MarketIcon(
                  boxFit: BoxFit.fill,
                  iconName: (model.symbolList![0] as String).split('-').length > 1
                      ? (model.symbolList![0] as String).split('-')[1]
                      : '',
                  width: 12.w),
            ),
          ),
          if (length > 1)
            Positioned(
              left: 7.w,
              child: ClipOval(
                child: Container(
                    padding: EdgeInsets.all(1.w),
                    color: AppColor.colorBackgroundPrimary,
                    child: MarketIcon(
                        boxFit: BoxFit.fill,
                        iconName: (model.symbolList![1] as String).split('-').length > 1
                            ? (model.symbolList![1] as String).split('-')[1]
                            : '',
                        width: 12.w)),
              ),
            ),
          if (length > 2)
            Positioned(
              left: 15.w,
              child: ClipOval(
                child: Container(
                    padding: EdgeInsets.all(1.w),
                    color: AppColor.colorBackgroundPrimary,
                    child: MarketIcon(
                        boxFit: BoxFit.fill,
                        iconName: (model.symbolList![2] as String).split('-').length > 1
                            ? (model.symbolList![2] as String).split('-')[1]
                            : '',
                        width: 12.w)),
              ),
            ),
          if (length > 3)
            Positioned(
              left: 24.w,
              top: 1.w,
              bottom: 1.w,
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration:
                      BoxDecoration(color: AppColor.colorBackgroundSecondary, borderRadius: BorderRadius.circular(32.w)),
                  child: Text(
                    '${model.symbolList!.length}',
                    style: AppTextStyle.f_9_400.colorTextDescription,
                  )),
            ),
        ],
      ),
    );
  }

  Widget getButton({bool isHome = false, int index = 0, TakerListType takeType = TakerListType.allTraders}) {
    if (model.followStatus == 1) {
      return Row(
        children: [
          MyButton(
              onTap: () {
                Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': model, 'isEdit': true, 'isSmart': model.isSmart});
              },
              text: LocaleKeys.follow13.tr,
              height: 28.h,
              textStyle: AppTextStyle.f_12_600.colorWhite,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              backgroundColor: AppColor.color111111),
        ],
      );
    } else {
      if (model.switchFollowerNumber == 2) {
        return Row(
          children: [
            MyButton(
              text: LocaleKeys.follow14.tr,
              height: 28.h,
              textStyle: AppTextStyle.f_12_600.colorWhite,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              backgroundColor: AppColor.colorCCCCCC,
            ),
          ],
        );
      } else {
        if (model.copySwitch == 0) {
          if (model.applyFollowStatus == 0) {
            //申请中
            return Row(
              children: [
                MyButton(
                  text: LocaleKeys.follow15.tr,
                  height: 28.h,
                  textStyle: AppTextStyle.f_12_600.colorWhite,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  backgroundColor: AppColor.colorCCCCCC,
                ),
              ],
            );
          } else if (model.applyFollowStatus == 1) {
            //通过
            if (isHome) {
              return MyButton(
                text: LocaleKeys.follow16.tr,
                height: 28.h,
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
              );
            } else {
              return Row(
                children: [
                  MyButton.borderWhiteBg(
                    height: 28.h,
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
                  SizedBox(
                    width: 10.w,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      MyButton(
                        text: LocaleKeys.follow16.tr,
                        height: 28.h,
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
                      Positioned(
                          right: -6.w,
                          top: -6.w,
                          child: MyButton(
                            text: LocaleKeys.follow18.tr,
                            height: 12.h,
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            textStyle: AppTextStyle.f_9_600.color111111,
                            backgroundColor: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(2),
                          ))
                    ],
                  )
                ],
              );
            }
          } else {
            //去申请
            return FollowOrderApplyBtn(model: model);
            // return Row(
            //   children: [
            //     MyButton.borderWhiteBg(
            //       height: 28.h,
            //       text: '申请跟单',
            //       textStyle: AppTextStyle.small_600.color111111,
            //       padding: EdgeInsets.symmetric(horizontal: 8.w),
            //       onTap: () {},
            //     ),
            //   ],
            // );
          }
        } else {
          if (isHome) {
            return MyButton(
              text: LocaleKeys.follow16.tr,
              height: 28.h,
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
            );
          } else {
            return Row(
              children: [
                MyButton.borderWhiteBg(
                  height: 28.h,
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
                SizedBox(
                  width: 10.w,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    MyButton(
                      text: LocaleKeys.follow16.tr,
                      height: 28.h,
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
                    Positioned(
                        right: -6.w,
                        top: -6.w,
                        child: MyButton(
                          text: LocaleKeys.follow18.tr,
                          height: 12.h,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          textStyle: AppTextStyle.f_9_600.color111111,
                          backgroundColor: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(2),
                        ))
                  ],
                )
              ],
            );
          }
        }
      }
    }
  }
}

class FollowOrderApplyBtn extends StatefulWidget {
  const FollowOrderApplyBtn({super.key, required this.model});

  final FollowKolInfo model;

  @override
  State createState() => _FollowOrderApplyBtnState();
}

class _FollowOrderApplyBtnState extends State<FollowOrderApplyBtn> {
  bool apply = false;

  @override
  Widget build(BuildContext context) {
    return apply
        ? MyButton(
            text: LocaleKeys.follow15.tr,
            height: 28.h,
            textStyle: AppTextStyle.f_12_600,
            color: AppColor.colorABABAB,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            backgroundColor: AppColor.colorF1F1F1,
          )
        : MyButton.borderWhiteBg(
            height: 28.h,
            text: LocaleKeys.follow19.tr,
            textStyle: AppTextStyle.f_12_600.color111111,
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

class FollowBottomApplyBtn extends StatefulWidget {
  const FollowBottomApplyBtn({super.key, required this.model});

  final FollowKolInfo model;

  @override
  State createState() => _FollowBottomApplyBtntate();
}

class _FollowBottomApplyBtntate extends State<FollowBottomApplyBtn> {
  bool apply = false;

  @override
  Widget build(BuildContext context) {
    return apply
        ? Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            decoration: const BoxDecoration(
              color: AppColor.colorWhite,
              border: Border(
                top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
              ),
            ),
            height: 80.h,
            child: MyButton(
              text: LocaleKeys.follow15.tr,
              height: 48.h,
              textStyle: AppTextStyle.f_16_600,
              color: AppColor.colorABABAB,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              backgroundColor: AppColor.colorF1F1F1,
            ))
        : Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            decoration: const BoxDecoration(
              color: AppColor.colorWhite,
              border: Border(
                top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
              ),
            ),
            height: 80.h,
            child: MyButton.borderWhiteBg(
              height: 48.h,
              text: LocaleKeys.follow19.tr,
              textStyle: AppTextStyle.f_16_600.color111111,
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
            ));
  }

  ///申请跟单
  followApply({num traderId = 1}) {
    AFFollow.postFollowApply(traderId: traderId).then((value) {
      if (value == null) {
        setState(() {
          apply = true;
        });
        UIUtil.showSuccess(LocaleKeys.follow20.tr);
      } else {
        UIUtil.showToast(LocaleKeys.follow21.tr);
      }
    });
  }
}
