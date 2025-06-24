import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_history_order.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_trader_position.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_mixin.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/my_follow_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take/controllers/my_take_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//

class MyTakeListView extends StatelessWidget {
  const MyTakeListView({
    super.key,
    required this.controller,
    required this.type,
  });
  final MyTakeController controller;
  final MyTakeFilterType type;

  @override
  Widget build(BuildContext context) {
    return MyTakeListCell(
      type: type,
      controller: controller,
    );
  }
}

class MyTakeListCell extends StatelessWidget with FollowShare {
  const MyTakeListCell(
      {super.key, required this.type, required this.controller});
  final MyTakeFilterType type;
  final MyTakeController controller;

  @override
  Widget build(BuildContext context) {
    return type == MyTakeFilterType.currentTake
        ? SmartRefresher(
            controller: controller.currentOrderRefreshVc,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () async {
              await controller.getData(isPullDown: true);
              controller.currentOrderRefreshVc.refreshToIdle();
              controller.currentOrderRefreshVc.loadComplete();
            },
            onLoading: () async {
              if (controller.currentOrder.value.haveMore) {
                controller.currentOrder.value.page++;
                await controller.getData();
                controller.currentOrderRefreshVc.loadComplete();
              } else {
                controller.currentOrderRefreshVc.loadNoData();
              }
            },
            child: CustomScrollView(
              key: PageStorageKey<String>(type.value),
              slivers: [
                Obx(() => controller.currentOrder.value.list?.isNotEmpty == true
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate((content, index) {
                          return getMyFollowCell(
                              controller.currentOrder.value.list![index]);
                        },
                            childCount:
                                controller.currentOrder.value.list!.length),
                      )
                    : FollowOrdersLoading(
                        isError: controller.currentOrder.value.isError,
                        onTap: () {
                          controller.getData(isPullDown: true);
                        }))
              ],
            ),
          )
        : SmartRefresher(
            controller: controller.historyOrderRefreshVc,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () async {
              await controller.getData(isPullDown: true);
              controller.historyOrderRefreshVc.refreshToIdle();
              controller.historyOrderRefreshVc.loadComplete();
            },
            onLoading: () async {
              if (controller.historyOrder.value.haveMore) {
                controller.historyOrder.value.page++;
                await controller.getData();
                controller.historyOrderRefreshVc.loadComplete();
              } else {
                controller.historyOrderRefreshVc.loadNoData();
              }
            },
            child: CustomScrollView(
              key: PageStorageKey<String>(type.value),
              slivers: [
                Obx(() => controller.historyOrder.value.list?.isNotEmpty == true
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate((content, index) {
                          return getHistoryTapeCell(
                              controller.historyOrder.value.list![index]);
                        },
                            childCount:
                                controller.historyOrder.value.list!.length),
                      )
                    : FollowOrdersLoading(
                        isError: controller.historyOrder.value.isError,
                        onTap: () {
                          controller.getData(isPullDown: true);
                        }))
              ],
            ),
          );
  }

  Widget getMyFollowCell(FollowTradePosition model) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        margin: EdgeInsets.only(right: 4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: model.tagColor.withOpacity(0.1)),
                        child: Text(
                          model.tag,
                          style: AppTextStyle.f_10_500
                              .copyWith(color: model.tagColor),
                        ),
                      ),
                      Text(
                        model.name,
                        style: AppTextStyle.f_14_600.color111111,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 2.h),
                        margin: EdgeInsets.only(left: 4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: AppColor.colorF5F5F5),
                        child: Text(model.contractTypeStr,
                            style: AppTextStyle.f_10_500.color4D4D4D),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 2.h),
                        margin: EdgeInsets.only(left: 4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: AppColor.colorF5F5F5),
                        child: Text(model.positionTypeStr,
                            style: AppTextStyle.f_10_500.color4D4D4D),
                      )
                    ],
                  ),
                ],
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.dialog(
                    MyShareView(
                        content: getHistoryFollowShareView(
                            earningsRateStr: model.earningsRateStr,
                            contractType: model.contractTypeStr,
                            tagStr: model.tagStr,
                            tagColor: model.tagColor,
                            modelName: model.name,
                            openPriceStr: model.openPriceStr,
                            markPriceStr: model.markPriceStr,
                            icon: UserGetx.to.avatar,
                            name: UserGetx.to.userName ?? '--')),
                    useSafeArea: false,
                    barrierDismissible: true,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, bottom: 16.h),
                  child: Icon(
                    Icons.share_outlined,
                    size: 16.w,
                    color: AppColor.color111111,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${LocaleKeys.assets15.tr}(USDT)',
                  style: AppTextStyle.f_11_400.color4D4D4D),
              Text(LocaleKeys.follow178.tr,
                  style: AppTextStyle.f_11_400.color4D4D4D),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(model.unRealizedAmountStr,
                    style: AppTextStyle.f_16_600
                        .copyWith(color: model.unRealizedAmountColor)),
                Text(model.earningsRateStr,
                    style: AppTextStyle.f_16_600
                        .copyWith(color: model.earningsRateColor)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getColumnWidget('${LocaleKeys.follow150.tr} (USDT)',
                    model.openDealCountStr),
                SizedBox(width: 15.w),
                getColumnWidget(
                    '${LocaleKeys.follow151.tr} (USDT)', model.holdAmountStr),
                getColumnWidget(LocaleKeys.trade108.tr, model.marginRateStr,
                    alignment: CrossAxisAlignment.end, isText: false)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getColumnWidget(
                    '${LocaleKeys.follow152.tr} (USDT)', model.openPriceStr),
                SizedBox(width: 15.w),
                getColumnWidget(
                    '${LocaleKeys.follow190.tr} (USDT)', model.indexPriceStr),
                getColumnWidget(
                    '${LocaleKeys.follow191.tr} (USDT)', model.reducePriceStr,
                    alignment: CrossAxisAlignment.end),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getHistoryTapeCell(FollowHistoryOrder model) {
    return Container(
      // margin: EdgeInsets.only(bottom: 20.h),
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),
      decoration: const BoxDecoration(
        // color: Colors.amber,
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 2.h),
                          margin: EdgeInsets.only(right: 4.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: model.tagColor.withOpacity(0.1)),
                          child: Text(model.tag,
                              style: AppTextStyle.f_10_500
                                  .copyWith(color: model.tagColor)),
                        ),
                        Text(model.name,
                            style: AppTextStyle.f_14_600.color111111),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 2.h),
                          margin: EdgeInsets.only(left: 4.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColor.colorF5F5F5),
                          child: Text(model.contractTypeStr,
                              style: AppTextStyle.f_10_500.color4D4D4D),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 2.h),
                          margin: EdgeInsets.only(left: 4.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColor.colorF5F5F5),
                          child: Text(model.positionTypeStr,
                              style: AppTextStyle.f_10_500.color4D4D4D),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: Text(LocaleKeys.follow154.tr,
                          style: AppTextStyle.f_12_400.color666666),
                    ),
                    const Icon(
                      Icons.share,
                      size: 14,
                      color: AppColor.color111111,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${LocaleKeys.follow152.tr} (USDT)',
                            style: AppTextStyle.f_11_400.color999999),
                        SizedBox(height: 2.h),
                        Text(model.avgOpenPxStr,
                            style: AppTextStyle.f_13_500.color4D4D4D),
                      ],
                    ),
                    SizedBox(
                      width: 32.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${LocaleKeys.follow135.tr} (USDT)',
                            style: AppTextStyle.f_11_400.color999999),
                        SizedBox(height: 2.h),
                        Text(model.profitStr,
                            style: AppTextStyle.f_13_600
                                .copyWith(color: model.profitColor)),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${LocaleKeys.follow155.tr} (USDT)',
                        style: AppTextStyle.f_11_400.color999999),
                    SizedBox(height: 2.h),
                    Text(model.volumeStr,
                        style: AppTextStyle.f_13_500.color4D4D4D),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${LocaleKeys.trade167.tr} (USDT)',
                        style: AppTextStyle.f_11_400.color999999),
                    SizedBox(height: 2.h),
                    Text(model.avgClosePxStr,
                        style: AppTextStyle.f_13_500.color4D4D4D),
                  ],
                ),
                SizedBox(
                  width: 32.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.follow115.tr,
                        style: AppTextStyle.f_11_400.color999999),
                    SizedBox(height: 2.h),
                    Text(model.rateStr,
                        style: AppTextStyle.f_13_600
                            .copyWith(color: model.profitColor)),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Text(LocaleKeys.follow156.tr,
                      style: AppTextStyle.f_11_500.color999999),
                  SizedBox(width: 4.w),
                  Text(model.closeTime,
                      style: AppTextStyle.f_11_500.color333333),
                ],
              ),
              Row(
                children: [
                  Text(LocaleKeys.follow157.tr,
                      style: AppTextStyle.f_11_500.color999999),
                  SizedBox(width: 4.w),
                  Text(model.createdTime,
                      style: AppTextStyle.f_11_500.color333333),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getColumnWidget(String titile, String des,
      {CrossAxisAlignment alignment = CrossAxisAlignment.start,
      bool isText = true}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          isText
              ? Text(titile, style: AppTextStyle.f_11_400.color999999.ellipsis)
              : MyDottedText(
                  titile,
                  lineWidthRatio: 0.9,
                  style: AppTextStyle.f_11_400.color999999.ellipsis,
                  isCenter: false,
                  onTap: () {
                    UIUtil.showAlert(LocaleKeys.trade108.tr,
                        content: LocaleKeys.follow250.tr);
                  },
                ),
          SizedBox(height: 3.h),
          Text(des, style: AppTextStyle.f_13_500.color4D4D4D),
        ],
      ),
    );
  }
}

// class MyTakeSpotCell extends StatelessWidget {
//   const MyTakeSpotCell({super.key, required this.type, required this.tabModel});
//   final MyTakeFilterType type;
//   final MyTakeTabModel tabModel;

//   @override
//   Widget build(BuildContext context) {
//     return type == MyTakeFilterType.currentTake
//         ? IndexedStack(
//             children: [
//               CustomScrollView(
//                 key: PageStorageKey<String>(type.value),
//                 slivers: [
//                   SliverPadding(
//                       padding: EdgeInsets.only(top: 4.w),
//                       sliver: SliverList(
//                         delegate: SliverChildBuilderDelegate((content, index) {
//                           return getMyFollowCell();
//                         }, childCount: 20),
//                       ))
//                 ],
//               )
//             ],
//           )
//         : CustomScrollView(
//             key: PageStorageKey<String>(type.value),
//             slivers: <Widget>[
//               SliverPadding(
//                   padding: EdgeInsets.only(top: 16.w),
//                   sliver: SliverList(
//                     delegate: SliverChildBuilderDelegate((content, index) {
//                       return getMyHistoryTapeCell();
//                     }, childCount: 20),
//                   ))
//             ],
//           );
//   }

//   Widget getMyHistoryTapeCell() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20.h),
//       padding: EdgeInsets.only(left: 16, right: 16, bottom: 20.h),
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
//         ),
//       ),
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(bottom: 16.h),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('BTC/USDT 永续',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: AppColor.color111111,
//                           fontWeight: FontWeight.w500,
//                         )),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(right: 24.w),
//                       child: Text('全部卖出',
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: AppColor.color999999,
//                             fontWeight: FontWeight.w500,
//                           )),
//                     ),
//                     const Icon(
//                       Icons.share,
//                       size: 14,
//                       color: AppColor.color111111,
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 16.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('卖出价格 (USDT)',
//                             style: TextStyle(
//                               fontSize: 11.sp,
//                               color: AppColor.color999999,
//                               fontWeight: FontWeight.w400,
//                             )),
//                         SizedBox(height: 2.h),
//                         Text('--',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: AppColor.color4D4D4D,
//                               fontWeight: FontWeight.w500,
//                             )),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 32.w,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('收益 (USDT)',
//                             style: TextStyle(
//                               fontSize: 11.sp,
//                               color: AppColor.color999999,
//                               fontWeight: FontWeight.w400,
//                             )),
//                         SizedBox(height: 2.h),
//                         Text('--',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: AppColor.upColor,
//                               fontWeight: FontWeight.w700,
//                             )),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text('数量 (BTC)',
//                         style: TextStyle(
//                           fontSize: 11.sp,
//                           color: AppColor.color999999,
//                           fontWeight: FontWeight.w400,
//                         )),
//                     SizedBox(height: 2.h),
//                     Text('--',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: AppColor.color4D4D4D,
//                           fontWeight: FontWeight.w500,
//                         )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 20.h),
//             child: Row(
//               children: <Widget>[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('买入价格 (USDT)',
//                         style: TextStyle(
//                           fontSize: 11.sp,
//                           color: AppColor.color999999,
//                           fontWeight: FontWeight.w400,
//                         )),
//                     SizedBox(height: 2.h),
//                     Text('--',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: AppColor.color4D4D4D,
//                           fontWeight: FontWeight.w500,
//                         )),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 32.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('收益率',
//                         style: TextStyle(
//                           fontSize: 11.sp,
//                           color: AppColor.color999999,
//                           fontWeight: FontWeight.w400,
//                         )),
//                     SizedBox(height: 2.h),
//                     Text('--',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: AppColor.upColor,
//                           fontWeight: FontWeight.w700,
//                         )),
//                   ],
//                 ),
//                 const Spacer(),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text('成交额 (BTC)',
//                         style: TextStyle(
//                           fontSize: 11.sp,
//                           color: AppColor.color999999,
//                           fontWeight: FontWeight.w400,
//                         )),
//                     SizedBox(height: 2.h),
//                     Text('--',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: AppColor.color4D4D4D,
//                           fontWeight: FontWeight.w500,
//                         )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 children: [
//                   Text('开仓时间',
//                       style: TextStyle(
//                         fontSize: 11.sp,
//                         color: AppColor.color999999,
//                         fontWeight: FontWeight.w400,
//                       )),
//                   SizedBox(width: 4.w),
//                   Text('-- ',
//                       style: TextStyle(
//                         fontSize: 11.sp,
//                         color: AppColor.color333333,
//                         fontWeight: FontWeight.w500,
//                       )),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text('平仓时间',
//                       style: TextStyle(
//                         fontSize: 11.sp,
//                         color: AppColor.color999999,
//                         fontWeight: FontWeight.w400,
//                       )),
//                   SizedBox(width: 4.w),
//                   Text('--',
//                       style: TextStyle(
//                         fontSize: 11.sp,
//                         color: AppColor.color333333,
//                         fontWeight: FontWeight.w500,
//                       )),
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget getMyFollowCell() {
//     return Container(
//       padding: EdgeInsets.only(top: 13.h, bottom: 16.h, left: 16, right: 16),
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
//         ),
//       ),
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(bottom: 14.h),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('BTC/USDT 永续',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: AppColor.color111111,
//                           fontWeight: FontWeight.w500,
//                         )),
//                     SizedBox(
//                       height: 16.h,
//                     ),
//                   ],
//                 ),
//                 const Icon(
//                   Icons.share,
//                   size: 16,
//                   color: AppColor.color111111,
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 6.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text('未实现盈亏(USDT)',
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: AppColor.color666666,
//                       fontWeight: FontWeight.w400,
//                     )),
//                 Text('回报率',
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: AppColor.color666666,
//                       fontWeight: FontWeight.w400,
//                     )),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 16.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text('-- USDT',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       color: AppColor.upColor,
//                       fontWeight: FontWeight.w600,
//                     )),
//                 Text('--',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       color: AppColor.upColor,
//                       fontWeight: FontWeight.w600,
//                     )),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 16.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 getColumnWidget('最新价格 (BTC)', '--'),
//                 getColumnWidget('买入价格 (USDT)', '--'),
//                 getColumnWidget('数量', '--', alignment: CrossAxisAlignment.end),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 18.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 getColumnWidget('成交额 (USDT)', '--'),
//                 getColumnWidget('', ' '),
//                 getColumnWidget('', ''),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                   child: MyButton(
//                 height: 34.h,
//                 text: '编辑',
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: AppColor.color111111,
//                 backgroundColor: AppColor.colorWhite,
//                 border: Border.all(width: 1, color: AppColor.colorDBDBDB),
//               )),
//               SizedBox(
//                 width: 7.w,
//               ),
//               Expanded(
//                   child: MyButton(
//                 height: 34.h,
//                 text: '撤单',
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: AppColor.color111111,
//                 backgroundColor: AppColor.colorWhite,
//                 border: Border.all(width: 1, color: AppColor.colorDBDBDB),
//               )),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget getColumnWidget(String titile, String des, {CrossAxisAlignment alignment = CrossAxisAlignment.start}) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: alignment,
//         children: [
//           Text(titile,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: AppColor.colorA3A3A3,
//                 fontWeight: FontWeight.w400,
//               )),
//           SizedBox(height: 9.h),
//           Text(des,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: AppColor.color4c4c4c,
//                 fontWeight: FontWeight.w400,
//               )),
//         ],
//       ),
//     );
//   }
// }
