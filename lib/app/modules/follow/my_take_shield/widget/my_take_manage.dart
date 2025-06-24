import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/follow_kol_apply.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_manage_list.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/controllers/my_take_shield_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyTakeManageList extends StatelessWidget {
  const MyTakeManageList({super.key, required this.controller, required this.type});
  final MyTakeShieldType type;
  final MyTakeShieldController controller;
  @override
  Widget build(BuildContext context) {
    return type == MyTakeShieldType.copycatUser
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
                            return getMyFollowCell(
                                controller.currentOrder.value.list![index], controller.currentOrder.value.isSelected);
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
              if (controller.applyOrder.value.haveMore) {
                controller.applyOrder.value.page++;
                await controller.getData();
                controller.historyOrderRefreshVc.loadComplete();
              } else {
                controller.historyOrderRefreshVc.loadNoData();
              }
            },
            child: CustomScrollView(
              key: PageStorageKey<String>(type.value),
              slivers: [
                Obx(() => controller.applyOrder.value.list?.isNotEmpty == true
                    ? SliverPadding(
                        padding: EdgeInsets.only(top: 16.h),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((content, index) {
                            return getApplyCell(
                                controller.applyOrder.value.list![index], controller.applyOrder.value.isSelected);
                          }, childCount: controller.applyOrder.value.list!.length),
                        ),
                      )
                    : FollowOrdersLoading(
                        isError: controller.applyOrder.value.isError,
                        onTap: () {
                          controller.getData(isPullDown: true);
                        }))
              ],
            ),
          );
  }

  getMyFollowCell(FollowMyManageList model, bool isSelected) {
    return Stack(
      children: [
        Container(
          // color: Colors.green,
          height: 169.h,
          alignment: Alignment.centerLeft,
          child: GestureDetector(
              onTap: () {
                model.isSelected.value = !model.isSelected.value;
                controller.checkIsAll();
              },
              behavior: HitTestBehavior.translucent,
              child: Obx(() => SizedBox(
                    width: 54.w,
                    height: 54.w,
                    child: Center(
                      child: MyImage(
                        'contract/${model.isSelected.value ? 'follow_select' : 'market_unSelect'}'.svgAssets(),
                        width: 20.w,
                      ),
                    ),
                  ))),
        ),
        Positioned(
          top: 0,
          left: isSelected ? 38 : 0,
          right: isSelected ? -38 : 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.w),
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
            decoration: ShapeDecoration(
                color: AppColor.colorWhite,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: AppColor.colorEEEEEE),
                  borderRadius: BorderRadius.circular(6.r),
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
                    Expanded(child: Text(model.name, style: AppTextStyle.f_16_500.color111111.ellipsis)),
                    SizedBox(width: 8.w),
                    isSelected
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MyButton.borderWhiteBg(
                                onTap: () async {
                                  //LocaleKeys.follow129.trArgs([(controller.infoModel.value.userName)])
                                  bool? res = await UIUtil.showConfirm(LocaleKeys.follow132.tr,
                                      content: LocaleKeys.follow133.trArgs([(model.name)]),
                                      cancelText: LocaleKeys.public2.tr,
                                      confirmText: LocaleKeys.public1.tr);
                                  if (res == true) {
                                    controller.setTraceUserRelation(userId: model.uid ?? 0, types: 2);
                                  }
                                },
                                text: LocaleKeys.follow134.tr,
                                textStyle: AppTextStyle.f_13_500,
                                padding: EdgeInsets.all(6.w),
                              ).marginOnly(right: 8.w),
                              MyButton.borderWhiteBg(
                                onTap: () async {
                                  bool? res = await UIUtil.showConfirm(LocaleKeys.follow128.tr,
                                      contentWidget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                        // SizedBox(height: 7.h),
                                        Text(LocaleKeys.follow129.trArgs([(model.name)]),
                                            style: AppTextStyle.f_12_400_15.color666666),
                                        Text(LocaleKeys.follow130.tr, style: AppTextStyle.f_12_400_15.color666666)
                                      ]),
                                      cancelText: LocaleKeys.public2.tr,
                                      confirmText: LocaleKeys.public1.tr);
                                  if (res == true) {
                                    controller.setTraceUserRelation(userId: model.uid ?? 0, types: 1);
                                  }
                                },
                                text: LocaleKeys.follow131.tr,
                                textStyle: AppTextStyle.f_13_500,
                                padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 19.w),
                              )
                            ],
                          )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.followProfitStr, style: AppTextStyle.f_18_500.copyWith(color: model.followProfitColor)),
                          SizedBox(height: 2.h),
                          Text(LocaleKeys.follow238.tr, style: AppTextStyle.f_11_400.color999999),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (isSelected) return;
                          Get.dialog(
                              transitionDuration: const Duration(milliseconds: 25),
                              MyFollowDialog(
                                  textVC: controller.textVC,
                                  isManage: true,
                                  isSingleManage: true,
                                  callback: () => controller.setUserRatr(uids: [model.uid ?? 0])));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.positionRateStr, style: AppTextStyle.f_18_500.color111111),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Text(LocaleKeys.follow25.tr, style: AppTextStyle.f_11_400.color999999),
                                isSelected
                                    ? const SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(left: 4.w, right: 8.w),
                                        child: MyImage(
                                          'flow/follow_edit'.svgAssets(),
                                          width: 10.w,
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ).marginOnly(right: 90.w),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  height: 1.h,
                  color: AppColor.colorF5F5F5,
                ),
                Row(
                  children: <Widget>[
                    Text(model.followTimeStr, style: AppTextStyle.f_11_400.color999999),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  getApplyCell(FollowkolApply model, bool isSelected) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
      )),
      child: Row(
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
              Text(model.userNmae, style: AppTextStyle.f_16_500.color111111),
              Text(model.createdTime, style: AppTextStyle.f_11_400.color999999),
            ],
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              MyButton.borderWhiteBg(
                onTap: () async {
                  // String title = '确认移除禁止跟单列表？';
                  // String des = '将${model.name}移除禁止跟单列表';

                  // bool? res = await UIUtil.showConfirm(title, content: des, cancelText: '取消', confirmText: '确定');
                  // print(res);
                  // if (res == true) {
                  controller.setFollowApply(userId: model.userId, followStatus: 2);
                  // }
                },
                text: LocaleKeys.follow199.tr,
                textStyle: AppTextStyle.f_13_600,
                padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
              ),
              SizedBox(
                width: 6.w,
              ),
              MyButton(
                onTap: () async {
                  // String title = '确认移除禁止跟单列表？';
                  // String des = '将${model.name}移除禁止跟单列表';

                  // bool? res = await UIUtil.showConfirm(title, content: des, cancelText: '取消', confirmText: '确定');
                  // if (res == true) {
                  controller.setFollowApply(userId: model.userId, followStatus: 1);
                  // }
                },
                text: LocaleKeys.follow200.tr,
                textStyle: AppTextStyle.f_13_600,
                padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
              )
            ],
          )
        ],
      ),
    );
  }
}
