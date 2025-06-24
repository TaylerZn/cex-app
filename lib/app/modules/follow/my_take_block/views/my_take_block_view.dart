import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../widgets/components/user_avatar.dart';
import '../controllers/my_take_block_controller.dart';

class MyTakeBlockView extends GetView<MyTakeBlockController> {
  const MyTakeBlockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: const MyPageBackWidget(), centerTitle: true, title: Text(controller.type.value)),
        body: controller.type == MyTakeShieldActionType.applyFor
            ? Obx(() => controller.applyOrder.value.list?.isNotEmpty == true
                ? SmartRefresher(
                    controller: controller.refreshVC,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () async {
                      await controller.getData(isPullDown: true);
                      controller.refreshVC.refreshToIdle();
                      controller.refreshVC.loadComplete();
                    },
                    onLoading: () async {
                      if (controller.applyOrder.value.haveMore) {
                        controller.applyOrder.value.page++;
                        await controller.getData();
                        controller.refreshVC.loadComplete();
                      } else {
                        controller.refreshVC.loadNoData();
                      }
                    },
                    child: ListView.builder(
                      itemCount: controller.applyOrder.value.list!.length,
                      itemBuilder: (context, index) {
                        var model = controller.applyOrder.value.list![index];
                        return Container(
                          padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                          decoration: const BoxDecoration(
                              // color: Colors.amber,
                              border: Border(
                            bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
                          )),
                          child: Row(
                            children: [
                              // ClipOval(
                              //   child: MyImage(
                              //     model.icon,
                              //     width: 36.r,
                              //   ),
                              // ),

                              UserAvatar(
                                model.icon,
                                width: 36.r,
                                height: 36.r,
                                levelType: model.levelType,
                                tradeIconSize: 12.w,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(model.userNmae, style: AppTextStyle.f_16_500.color111111),
                                    Text(model.createdTime, style: AppTextStyle.f_11_400.color999999),
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              getRightView(uid: model.userId)
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : FollowOrdersLoading(
                    isSliver: false,
                    isError: controller.applyOrder.value.isError,
                    onTap: () {
                      controller.getData(isPullDown: true);
                    }))
            : Obx(() => controller.model.value.list?.isNotEmpty == true
                ? SmartRefresher(
                    controller: controller.refreshVC,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () async {
                      await controller.getData(isPullDown: true);
                      controller.refreshVC.refreshToIdle();
                      controller.refreshVC.loadComplete();
                    },
                    onLoading: () async {
                      if (controller.model.value.haveMore) {
                        controller.model.value.page++;
                        await controller.getData();
                        controller.refreshVC.loadComplete();
                      } else {
                        controller.refreshVC.loadNoData();
                      }
                    },
                    child: ListView.builder(
                      itemCount: controller.model.value.list!.length,
                      itemBuilder: (context, index) {
                        var model = controller.model.value.list![index];
                        return Container(
                          padding: EdgeInsets.fromLTRB(16.w, index == 0 ? 10.h : 20.h, 16.w, 20.h),
                          decoration: const BoxDecoration(
                              // color: Colors.amber,
                              border: Border(
                            bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
                          )),
                          child: Row(
                            children: [
                              MyImage(
                                model.icon,
                                width: 36.r,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.name, style: AppTextStyle.f_16_500.color111111),
                                  Text(
                                      '${controller.type == MyTakeShieldActionType.blacklist ? LocaleKeys.follow234.tr : LocaleKeys.follow235.tr}${model.createdTime}',
                                      style: AppTextStyle.f_11_400.color999999),
                                ],
                              ),
                              const Spacer(),
                              getRightView(uid: model.userId, name: model.name)
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : FollowOrdersLoading(
                    isSliver: false,
                    isError: controller.model.value.isError,
                    onTap: () {
                      controller.getData(isPullDown: true);
                    })));
  }

  getRightView({num uid = 0, String name = ''}) {
    switch (controller.type) {
      case MyTakeShieldActionType.blacklist:
        return MyButton.borderWhiteBg(
          onTap: () async {
            String title = LocaleKeys.follow194.tr;
            String des = LocaleKeys.follow195.trArgs([name]);
            bool? res = await UIUtil.showConfirm(title,
                content: des, cancelText: LocaleKeys.public2.tr, confirmText: LocaleKeys.public1.tr);
            if (res == true) {
              controller.setTraceUserRelation(userId: uid, types: 1);
            }
          },
          text: LocaleKeys.follow196.tr,
          textStyle: AppTextStyle.f_13_600,
          padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 23.w),
        );
      case MyTakeShieldActionType.prohibit:
        return MyButton.borderWhiteBg(
          onTap: () async {
            String title = LocaleKeys.follow197.tr;
            String des = LocaleKeys.follow198.trArgs([name]);
            bool? res = await UIUtil.showConfirm(title,
                content: des, cancelText: LocaleKeys.public2.tr, confirmText: LocaleKeys.public1.tr);
            if (res == true) {
              controller.setTraceUserRelation(userId: uid, types: 2);
            }
          },
          text: LocaleKeys.follow196.tr,
          textStyle: AppTextStyle.f_13_600,
          padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 23.w),
        );
      case MyTakeShieldActionType.applyFor:
        return Row(
          children: <Widget>[
            MyButton.borderWhiteBg(
              onTap: () async {
                String title =
                    controller.type == MyTakeShieldActionType.blacklist ? LocaleKeys.follow194.tr : LocaleKeys.follow197.tr;
                String des = controller.type == MyTakeShieldActionType.blacklist
                    ? LocaleKeys.follow195.trArgs([name])
                    : LocaleKeys.follow197.trArgs([name]);
                bool? res = await UIUtil.showConfirm(title,
                    content: des, cancelText: LocaleKeys.public2.tr, confirmText: LocaleKeys.public1.tr);
                if (res == true) {
                  controller.setFollowApply(userId: uid, followStatus: 2);
                }
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
                String title =
                    controller.type == MyTakeShieldActionType.blacklist ? LocaleKeys.follow194.tr : LocaleKeys.follow197.tr;
                String des = controller.type == MyTakeShieldActionType.blacklist
                    ? LocaleKeys.follow195.trArgs([name])
                    : LocaleKeys.follow197.trArgs([name]);
                bool? res = await UIUtil.showConfirm(title,
                    content: des, cancelText: LocaleKeys.public2.tr, confirmText: LocaleKeys.public1.tr);
                if (res == true) {
                  controller.setFollowApply(userId: uid, followStatus: 1);
                }
              },
              text: LocaleKeys.follow200.tr,
              textStyle: AppTextStyle.f_13_600,
              padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
            )
          ],
        );
      default:
        return const SizedBox();
    }
  }
}
