import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/model/follow_kol_profit.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/model/follow_kol_set.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/controllers/my_take_parting_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/model/my_parting_enum.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyPartingList extends StatelessWidget {
  const MyPartingList({super.key, required this.type, required this.controller});
  final MyPartingType type;
  final MyTakePartingController controller;
  @override
  Widget build(BuildContext context) {
    return type == MyPartingType.expectedSorted
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
                    ? SliverPadding(
                        padding: EdgeInsets.only(top: 16.h),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((content, index) {
                            return getMyFollowCell(controller.currentOrder.value.list![index]);
                          }, childCount: controller.currentOrder.value.list!.length),
                        ),
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
                    ? SliverPadding(
                        padding: EdgeInsets.only(top: 16.h),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((content, index) {
                            return getHistoryTapeCell(controller.historyOrder.value.list![index]);
                          }, childCount: controller.historyOrder.value.list!.length),
                        ),
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

  getMyFollowCell(FollowkolProfitList model) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        8.w,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFECECEC)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.userName, style: AppTextStyle.f_16_600.color111111),
                  Text(model.followTimeStr, style: AppTextStyle.f_11_400.color999999),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.follow182.tr}(USDT)', style: AppTextStyle.f_11_400.color666666),
                  SizedBox(height: 2.h),
                  Text(model.todayProfitStr, style: AppTextStyle.f_16_500.copyWith(color: model.todayProfitColor))
                ],
              ),
              SizedBox(
                width: 64.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.follow236.tr}(USDT)', style: AppTextStyle.f_11_400.color666666),
                  SizedBox(height: 2.h),
                  Text(model.expectedProfitStr, style: AppTextStyle.f_16_500.copyWith(color: model.expectedProfitColor))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  getHistoryTapeCell(FollowkolSetList model) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        8.w,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFECECEC)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.userName, style: AppTextStyle.f_16_600.color111111),
                  Text(model.followTimeStr, style: AppTextStyle.f_11_400.color999999),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.follow213.tr}(USDT)', style: AppTextStyle.f_11_400.color666666),
                  SizedBox(height: 2.h),
                  Text(model.sumAmountStr, style: AppTextStyle.f_16_500.copyWith(color: model.sumAmountColor))
                ],
              ),
              SizedBox(
                width: 64.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.follow214.tr}(USDT)', style: AppTextStyle.f_11_400.color666666),
                  SizedBox(height: 2.h),
                  Text(model.sumShareProfitStr, style: AppTextStyle.f_16_500.copyWith(color: model.sumShareProfitColor))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
