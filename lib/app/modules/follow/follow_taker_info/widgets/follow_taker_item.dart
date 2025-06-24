import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/simple_item_row.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_history_order.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_detail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_traderdetail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_manage_list.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/controllers/follow_taker_info_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_cell.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_draw.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_mixin.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_mark.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../model/follow_trader_position.dart';

//

class FollowTakerOverviewCell extends StatelessWidget with FollowShare, FollowOverviewWidget {
  const FollowTakerOverviewCell(this.model, {super.key, required this.controller});
  final FollowkolTraderDetailModel model;
  final FollowTakerInfoController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 16.w, 0, 20.w),
      child: Column(
        children: <Widget>[
          getSum(model, context),
          Container(color: AppColor.colorF1F1F1, height: 8.w, margin: EdgeInsets.only(top: 2.w)),
          Obx(() => controller.currentOrder.value.list?.isNotEmpty == true && controller.showView
              ? Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 16.w, 0, 0),
                          child: Text(LocaleKeys.follow122.tr, style: AppTextStyle.f_15_600.color111111),
                        )
                      ],
                    ),
                    FollowTakerCurrentDetailCell(controller.currentOrder.value.list![0],
                        haveBottom: false, controller: controller),
                    InkWell(
                        onTap: () {
                          controller.goTabWithIndex(2);
                        },
                        child: Text(LocaleKeys.follow469.tr,
                            textAlign: TextAlign.center, style: AppTextStyle.f_12_500.tradingYel)),
                    Container(color: AppColor.colorF1F1F1, height: 8.w, margin: EdgeInsets.only(top: 16.w)),
                  ],
                )
              : const SizedBox()),
          Obx(() => controller.topic.value.id != null
              ? Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 16.w, top: 16.w),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: ShapeDecoration(
                              color: AppColor.colorF1F1F1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: Row(
                              children: <Widget>[
                                MyImage('flow/follow_pinned'.svgAssets(), width: 16.w),
                                4.horizontalSpace,
                                Text(LocaleKeys.follow460.tr, style: AppTextStyle.f_15_600.color111111),
                              ],
                            )),
                      ],
                    ),
                    SimpleItemRow(item: controller.topic.value),
                    InkWell(
                      onTap: () {
                        controller.goTabWithIndex(-1);
                      },
                      child: Text(LocaleKeys.follow470.tr, textAlign: TextAlign.center, style: AppTextStyle.f_12_500.tradingYel)
                          .paddingSymmetric(vertical: 16.w),
                    ),
                    Container(color: AppColor.colorF1F1F1, height: 8.w),
                  ],
                )
              : const SizedBox()),
          getStarView(model, controller),
          getRadarView(model, controller),
          Obx(() => controller.overviewComment.value.records?.isNotEmpty == true && controller.showFollowView
              ? FollowTakerUserRatingCell(model: controller.overviewComment.value, controller: controller)
              : const SizedBox()),
          getKlineView(model, controller),
          getPieView(model, controller),
        ],
      ),
    );
  }
}

class FollowTakerExpressCell extends StatelessWidget with FollowShare, FollowOverviewWidget {
  const FollowTakerExpressCell(this.model, {super.key, required this.controller});
  final FollowkolTraderDetailModel model;
  final FollowTakerInfoController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20.w),
      child: Column(
        children: <Widget>[
          getStarView(model, controller),
          getRadarView(model, controller),
          Container(color: AppColor.colorF1F1F1, height: 8.w, margin: EdgeInsets.only(top: 16.w, bottom: 16.w)),
          getSum(model, context),
          getKlineView(model, controller),
          getPieView(model, controller),
        ],
      ),
    );
  }
}

class FollowTakerCurrentDetailCell extends StatelessWidget with FollowShare {
  const FollowTakerCurrentDetailCell(this.model, {super.key, this.haveBottom = true, required this.controller});
  final FollowTradePosition model;
  final bool haveBottom;
  final FollowTakerInfoController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.only(left: 16.w, bottom: 16.h, top: 16.h),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: haveBottom ? const BorderSide(width: 1.0, color: AppColor.colorEEEEEE) : BorderSide.none,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 3.h),
                        margin: EdgeInsets.only(right: 6.w),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(3.r), color: model.tagColor.withOpacity(0.1)),
                        child: Text(
                          model.tag,
                          style: AppTextStyle.f_10_500.copyWith(color: model.tagColor),
                        ),
                      ),
                      Text(model.name, style: AppTextStyle.f_14_600.color111111),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                        margin: EdgeInsets.only(left: 4.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: AppColor.colorF5F5F5),
                        child: Text(model.contractTypeStr, style: AppTextStyle.f_10_500.color4D4D4D),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                        margin: EdgeInsets.only(left: 4.w, right: 8.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: AppColor.colorF5F5F5),
                        child: Text(model.positionTypeStr, style: AppTextStyle.f_10_500.color4D4D4D),
                      ),
                      Text(model.createdTime, style: AppTextStyle.f_11_500.color999999)
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    MyShareView(
                        content: getHistoryFollowShareView(
                            earningsRateStr: model.earningsRateStr,
                            contractType: model.contractTypeStr,
                            tagStr: model.tagStr,
                            tagColor: model.tagColor,
                            modelName: model.name,
                            openPriceStr: model.markPriceStr,
                            isStandardContract: model.isStandardContract,
                            subSymbol: model.subSymbolStr,
                            icon: controller.detailModel.value.icon,
                            name: controller.detailModel.value.userName)),
                    useSafeArea: false,
                    barrierDismissible: true,
                  );
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: MyImage('flow/follow_share'.svgAssets(), width: 16.w)),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //收益
                          Text('${LocaleKeys.follow135.tr}(USDT)', style: AppTextStyle.f_11_400.color4D4D4D),
                          // SizedBox(height: 9.h),
                          Text(model.earningStr, style: AppTextStyle.f_16_600.copyWith(color: model.earningColor)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(LocaleKeys.follow115.tr, style: AppTextStyle.f_11_400.color4D4D4D),
                          // SizedBox(height: 9.h),
                          Text(model.earningsRateStr, style: AppTextStyle.f_16_600.copyWith(color: model.earningColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        // color: Colors.red,
                        width: 140.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //持仓数量
                            Text('${LocaleKeys.follow150.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                            SizedBox(height: 2.h),
                            Text(model.openDealCountStr, style: AppTextStyle.f_13_500.color333333),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //保证金
                          Text('${LocaleKeys.follow151.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                          SizedBox(height: 2.h),
                          Text(model.holdAmountStr, style: AppTextStyle.f_13_500.color333333),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //标记价格
                          Text(model.marketTypeStr, style: AppTextStyle.f_11_400.color999999),
                          SizedBox(height: 2.h),
                          Text(model.markPriceStr, style: AppTextStyle.f_13_500.color333333),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      // color: Colors.red,
                      width: 150.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //开仓均价
                          Text('${LocaleKeys.follow152.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                          SizedBox(height: 2.h),
                          Text(model.openPriceStr, style: AppTextStyle.f_13_500.color333333),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}

class FollowTakerHistoryDetailCell extends StatelessWidget with FollowShare {
  const FollowTakerHistoryDetailCell(this.uid, this.model, {super.key, required this.controller});
  final FollowHistoryOrder model;
  final num uid;
  final FollowTakerInfoController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.only(left: 16.w, bottom: 16.h, top: 16.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                margin: EdgeInsets.only(right: 4.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.r), color: model.tagColor.withOpacity(0.1)),
                child: Text(model.tag, style: AppTextStyle.f_10_500.copyWith(color: model.tagColor)),
              ),
              Text(model.name, style: AppTextStyle.f_14_600.color111111),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                margin: EdgeInsets.only(left: 4.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: AppColor.colorF5F5F5),
                child: Text(model.contractTypeStr, style: AppTextStyle.f_10_500.color4D4D4D),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                margin: EdgeInsets.only(left: 4.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: AppColor.colorF5F5F5),
                child: Text(model.positionTypeStr, style: AppTextStyle.f_10_500.color4D4D4D),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(LocaleKeys.follow154.tr,
                        style: AppTextStyle.f_12_400.color666666.copyWith(overflow: TextOverflow.ellipsis)),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          MyShareView(
                              content: getHistoryFollowShareView(
                                  earningsRateStr: model.rateStr,
                                  contractType: model.contractTypeStr,
                                  tagStr: model.tag,
                                  modelName: model.name,
                                  openPriceStr: model.avgOpenPxStr,
                                  markPriceStr: model.avgClosePxStr,
                                  icon: controller.detailModel.value.icon,
                                  name: controller.detailModel.value.userName,
                                  tagColor: model.tagColor)),
                          useSafeArea: false,
                          barrierDismissible: true,
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: MyImage('flow/follow_share'.svgAssets(), width: 16.w)),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${LocaleKeys.follow152.tr} (USDT)', style: AppTextStyle.f_11_400.color999999.ellipsis),
                              SizedBox(height: 2.h),
                              Text(model.avgOpenPxStr, style: AppTextStyle.f_13_500.color4D4D4D),
                              // ],
                              // ),
                              SizedBox(height: 8.w),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              Text('${LocaleKeys.trade167.tr} (USDT)', style: AppTextStyle.f_11_400.color999999.ellipsis),
                              SizedBox(height: 2.h),
                              Text(model.avgClosePxStr, style: AppTextStyle.f_13_500.color4D4D4D),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${LocaleKeys.follow135.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                              SizedBox(height: 2.h),
                              Text(model.profitStr, style: AppTextStyle.f_13_500.copyWith(color: model.profitColor)),
                              //   ],
                              // ),
                              SizedBox(height: 8.w),
                              // Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // children: [
                              Text(LocaleKeys.follow115.tr, style: AppTextStyle.f_11_400.color999999),
                              SizedBox(height: 2.h),
                              Text(model.rateStr, style: AppTextStyle.f_13_500.copyWith(color: model.profitColor)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${LocaleKeys.follow155.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                              SizedBox(height: 2.h),
                              Text(model.volumeStr, style: AppTextStyle.f_13_500.color4D4D4D),
                            ],
                          ),
                          // SizedBox(height: 8.w),
                          // const SizedBox()
                        ],
                      ),
                    )
                  ],
                ).paddingSymmetric(vertical: 16.w),

                // //第二行
                // Padding(
                //   padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                //   child: Row(
                //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text('${LocaleKeys.follow152.tr} (USDT)', style: AppTextStyle.small2_400.color999999.ellipsis),
                //             SizedBox(height: 2.h),
                //             Text(model.avgOpenPxStr, style: AppTextStyle.medium2_500.color4D4D4D),
                //           ],
                //         ),
                //       ),
                //       // SizedBox(
                //       //   width: 32.w,
                //       // ),
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text('${LocaleKeys.follow135.tr} (USDT)', style: AppTextStyle.small2_400.color999999),
                //                 SizedBox(height: 2.h),
                //                 Text(model.profitStr, style: AppTextStyle.medium2_500.copyWith(color: model.profitColor)),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             Text('${LocaleKeys.follow155.tr} (${model.type})', style: AppTextStyle.small2_400.color999999),
                //             SizedBox(height: 2.h),
                //             Text(model.volumeStr, style: AppTextStyle.medium2_500.color4D4D4D),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // //第三行
                // Padding(
                //   padding: EdgeInsets.only(bottom: 16.h),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text('${LocaleKeys.trade167.tr} (USDT)', style: AppTextStyle.small2_400.color999999.ellipsis),
                //             SizedBox(height: 2.h),
                //             Text(model.avgClosePxStr, style: AppTextStyle.medium2_500.color4D4D4D),
                //           ],
                //         ),
                //       ),
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(LocaleKeys.follow115.tr, style: AppTextStyle.small2_400.color999999),
                //                 SizedBox(height: 2.h),
                //                 Text(model.rateStr, style: AppTextStyle.medium2_500.copyWith(color: model.profitColor)),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //       const Expanded(child: SizedBox())
                //     ],
                //   ),
                // ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          Text(LocaleKeys.follow156.tr, style: AppTextStyle.f_11_500.color999999),
                          SizedBox(width: 4.w),
                          Expanded(
                              child: Text(model.closeTime,
                                  style: AppTextStyle.f_11_500.color333333.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(LocaleKeys.follow157.tr, style: AppTextStyle.f_11_500.color999999),
                          SizedBox(width: 4.w),
                          Expanded(
                              child: Text(model.createdTime,
                                  style: AppTextStyle.f_11_500.color333333.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FollowTakerFollowDetailCell extends StatelessWidget with FollowShare {
  const FollowTakerFollowDetailCell(this.model, {super.key, required this.controller});
  final FollowMyManageList model;
  final FollowTakerInfoController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
      )),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: MyImage(
                  model.icon,
                  width: 36.r,
                ),
              ),
              SizedBox(width: 8.w),
              Text(model.name, style: AppTextStyle.f_14_500.color111111),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(model.totalPNLStr, style: AppTextStyle.f_16_500.copyWith(color: model.totalPNLColor)),
                  SizedBox(height: 6.h),
                  Text('${LocaleKeys.follow158.tr}(USDT)', style: AppTextStyle.f_11_400.color999999),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

mixin FollowOverviewWidget {
  Widget getSum(FollowkolTraderDetailModel model, BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 23.h,
                  child: Text(LocaleKeys.follow330.tr, style: AppTextStyle.f_15_600.color111111).marginOnly(right: 2.w),
                ),
                GestureDetector(
                    onTap: () async {
                      var text = (LocaleKeys.follow507.tr).replaceAll('\\', '');
                      UIUtil.showAlert(LocaleKeys.follow330.tr, content: text);

                      // var detailModel = FollowkolUserDetailModel(userName: 'name', imgUrl: '', flagIcon: '', uid: 000);
                      // showFollowMarkheetView(
                      //     currentContext: context,
                      //     bottomType: FollowMarkType.recommend,
                      //     isGood: false,
                      //     detailModel: detailModel,
                      //     textVC: TextEditingController());
                    },
                    child: SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: MyImage(
                        'flow/follow_setup_tip'.svgAssets(),
                      ),
                    ))
              ],
            ),
            4.verticalSpace,
            Text('${LocaleKeys.follow513.tr}：${model.lastUpdateTimeStr}', style: AppTextStyle.f_12_400.color999999)
          ],
        ),

        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: AppColor.colorF9F9F9,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.follow9.tr,
                          style: AppTextStyle.f_12_400.color666666,
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          model.rateStr,
                          style: AppTextStyle.f_16_500.color333333,
                        ),
                      ],
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: AppColor.colorF9F9F9,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.follow184.tr,
                          style: AppTextStyle.f_12_400.color666666,
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          model.shareProfitRateStr,
                          style: AppTextStyle.f_16_500.color333333,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            10.verticalSpace,
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: AppColor.colorF9F9F9,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.follow322.tr,
                          style: AppTextStyle.f_12_400.color666666,
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          model.orderNumberStr,
                          style: AppTextStyle.f_16_500.color333333,
                        ),
                      ],
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: AppColor.colorF9F9F9,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.follow323.tr,
                          style: AppTextStyle.f_12_400.color666666,
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          model.winNumberStr,
                          style: AppTextStyle.f_16_500.color333333,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ).paddingSymmetric(vertical: 16.w),

        getCell(LocaleKeys.follow324.tr, model.lossesNumberStr),
        getCell(LocaleKeys.follow325.tr, model.orderFrequencyStr), //当前跟单用户收益
        getCell(LocaleKeys.follow326.tr, model.dayCountStr),
        getCell(LocaleKeys.follow327.tr, model.lastTradeTimeStr),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }

  Widget getRadarView(FollowkolTraderDetailModel model, FollowTakerInfoController controller) {
    return Column(
      children: <Widget>[
        FollowTakerDrawRadar(
            copyTrader: model.copyTrader ?? FollowTraderScore(),
            copyTraderAvgCount: model.copyTraderAvgCount ?? FollowTraderScore()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: AppColor.colorEEEEEE),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF52C599),
                          shape: OvalBorder(),
                        ),
                      ),
                      UserAvatar(
                        controller.detailModel.value.icon,
                        width: 20.w,
                        height: 20.w,
                      ).paddingSymmetric(horizontal: 4.w),
                      Text(LocaleKeys.follow320.tr, style: AppTextStyle.f_10_400.color999999)
                    ],
                  ),
                )
              ],
            ),
            Text('VS', style: AppTextStyle.f_10_600.color999999).paddingSymmetric(horizontal: 13.w),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: AppColor.colorEEEEEE),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF0075FF),
                          shape: OvalBorder(),
                        ),
                      ),
                      MyImage(
                        'flow/follow_taker_user'.svgAssets(),
                        width: 20.w,
                        height: 20.w,
                      ).paddingSymmetric(horizontal: 4.w),
                      Text(LocaleKeys.follow321.tr, style: AppTextStyle.f_10_400.color999999)
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget getStarView(FollowkolTraderDetailModel model, FollowTakerInfoController controller) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 23.h,
                  child: Text(LocaleKeys.follow310.tr, style: AppTextStyle.f_15_600.color111111).marginOnly(right: 2.w),
                ),
                GestureDetector(
                    onTap: () async {
                      UIUtil.showAlert(LocaleKeys.follow310.tr, content: LocaleKeys.follow506.tr);
                    },
                    child: SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: MyImage(
                        'flow/follow_setup_tip'.svgAssets(),
                      ),
                    ))
              ],
            ).paddingSymmetric(vertical: 16.w),
          ],
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          margin: EdgeInsets.only(bottom: 8.w),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: AppColor.colorEEEEEE,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Column(
            children: [
              FollowStarWidget(score: model.traderScoreStart, offsetX: 2),
              Text(model.traderScoreStr, style: AppTextStyle.f_14_500.color111111).paddingSymmetric(vertical: 4.w),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: LocaleKeys.follow312.tr, style: AppTextStyle.f_12_400.color666666),
                    TextSpan(text: model.rankingRatioStr, style: AppTextStyle.f_12_500.copyWith(color: AppColor.upColor)),
                    TextSpan(text: LocaleKeys.follow313.tr, style: AppTextStyle.f_12_400.color666666),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }

  Widget getKlineView(FollowkolTraderDetailModel model, FollowTakerInfoController controller) {
    return Column(
      children: [
        Container(color: AppColor.colorF1F1F1, height: 8.w, margin: EdgeInsets.only(top: 16.w)),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: Row(
                children: [
                  SizedBox(
                    height: 23.w,
                    child: Text(LocaleKeys.follow463.tr, style: AppTextStyle.f_15_600.color111111).marginOnly(right: 2.w),
                  ),
                  GestureDetector(
                      onTap: () async {
                        UIUtil.showAlert(LocaleKeys.follow463.tr, content: LocaleKeys.follow504.tr);
                      },
                      child: SizedBox(
                        width: 14.w,
                        height: 14.w,
                        child: MyImage(
                          'flow/follow_setup_tip'.svgAssets(),
                        ),
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  child: Text(
                    model.todayEarn,
                    style: AppTextStyle.f_20_600.copyWith(color: model.todayEarnColor),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                //   decoration: ShapeDecoration(
                //     shape: RoundedRectangleBorder(
                //       side: const BorderSide(width: 1, color: Color(0xFFF4F4F4)),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //   ),
                //   child: Text(LocaleKeys.follow136.tr, style: AppTextStyle.f_12_500.color999999),
                // )
              ],
            ),
            FollowTakerDrawLine(
              monthProfit: model.monthProfitRateList,
              // monthProfit: [1, 2, 3, 4, 5, 5, 6, 7],
            )
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ],
    );
  }

  Widget getPieView(FollowkolTraderDetailModel model, FollowTakerInfoController controller) {
    return model.positionPreferencesV2?.isNotEmpty == true
        ? Column(
            children: [
              Container(color: AppColor.colorF1F1F1, height: 8.w, margin: EdgeInsets.only(top: 16.w)),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child: Text(
                          model.positionPreferences?.isNotEmpty == true ? LocaleKeys.follow464.tr : '',
                          style: AppTextStyle.f_15_600.color111111,
                        ),
                      )
                    ],
                  ),
                  FollowTakerDrawPie(array: model.positionPreferencesV2),
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ],
          )
        : const SizedBox();
  }

  Widget getCell(String left, String right) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            left,
            style: AppTextStyle.f_13_400.color666666,
          ),
          Text(
            right,
            style: AppTextStyle.f_13_400.color333333,
          ),
        ],
      ),
    );
  }
}
