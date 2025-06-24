import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/activity/activity_task.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_appbar_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/dialog/share_dialog.dart';
import 'package:nt_app_flutter/app/widgets/dialog/warning_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../utils/utilities/route_util.dart';
import '../controllers/new_user_activity_page_controller.dart';

class NewUserActivityPageView extends GetView<NewUserActivityPageController> {
  const NewUserActivityPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: MyAppBar(
          myTitle: LocaleKeys.other96.tr,
        ),
        body: SmartRefresher(
          enablePullDown: true,
          controller: controller.refreshController,
          onRefresh: () async {
            Future.wait(
                [controller.fetchTasks(), controller.fetchActivityDetail()]);
            controller.refreshController.refreshToIdle();
            controller.refreshController.loadComplete();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                24.verticalSpaceFromWidth,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 55.w),
                  child: MyImage(
                    controller.activityDetail.value.whiteImg ?? '',
                    width: 280.w,
                    height: 280.w,
                    fit: BoxFit.fill,
                  ),
                ),
                titleWidget(),
                40.verticalSpaceFromWidth,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      enlistsWidget(),
                      ...taskTitle(),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: _taskItemBuilder,
                          separatorBuilder: (_, __) =>
                              16.verticalSpaceFromWidth,
                          itemCount: controller.tasks.length),
                    ],
                  ),
                ),
                rulesWidget(),
              ],
            ),
          ),
        ),
      );
    });
  }

  titleWidget() {
    return Column(
      children: [
        24.verticalSpaceFromWidth,
        Text(
          //          '新人见面礼:',
          controller.activityDetail.value.name ?? '',
          style: AppTextStyle.f_24_600.colorTextPrimary,
        ),
        Text(
          controller.activityDetail.value.title ?? '',
          // '高达 500 USDT空投',
          style: AppTextStyle.f_24_600.colorTextPrimary,
        ),
        12.verticalSpaceFromWidth,
        Text(
          //'2024/10/12 16:00:00 - 2024/10/18 23:59:59',
          '${MyTimeUtil.timestampToShortStr(int.parse(controller.activityDetail.value.startTime ?? '0'))} - ${MyTimeUtil.timestampToShortStr(int.parse(controller.activityDetail.value.endTime ?? '0'))}',
          style: AppTextStyle.f_12_400.colorTextPrimary,
        ),
        24.verticalSpaceFromWidth,
        Text(
          LocaleKeys.other65.tr,
          style: AppTextStyle.f_12_400.colorTextDescription,
        ),
        12.verticalSpaceFromWidth,
        Text(
          controller.endTimeStr.value,
          style: AppTextStyle.f_24_600.colorTextPrimary.copyWith(),
        ),
        24.verticalSpaceFromWidth,
        shareWidget(),
      ],
    );
  }

  Widget shareWidget() {
    return GestureDetector(
      onTap: toShare,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.5.w, right: 4.w),
            child: MyImage(
              'activity/share'.pngAssets(),
              width: 14.w,
              height: 14.w,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            LocaleKeys.public34.tr,
            style: AppTextStyle.f_14_500.colorTextPrimary,
          )
        ],
      ),
    );
  }

  /// 报名组件
  enlistsWidget() {
    /// 0 未报名, 1已报名, 2已结束
    int status = controller.activityDetail.value.status ?? 0;
    if (controller.endString == controller.endTimeStr.value) {
      status = 2;
    }

    return Container(
      height: 133.w,
      decoration: BoxDecoration(
        color: AppColor.colorBackgroundTertiary,
        borderRadius: BorderRadius.circular(24.w),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.other66.tr,
              style: AppTextStyle.f_14_600.colorTextPrimary),
          16.verticalSpaceFromWidth,
          MyButton(
            onTap: () {
              enroll(status);
            },
            borderRadius: BorderRadius.circular(999),
            width: 240.w,
            height: 48.w,
            backgroundColor: status > 0
                ? AppColor.colorBackgroundInverseDisabled
                : AppColor.colorBackgroundInversePrimary,
            text: controller.activityDetail.value.status == 1
                ? LocaleKeys.other98.tr
                : status == 2
                    ? LocaleKeys.other73.tr
                    : LocaleKeys.other67.tr,
            textStyle: AppTextStyle.f_16_600.colorAlwaysWhite,
          )
        ],
      ),
    );
  }

  /// 报名
  Future<void> enroll(int status) async {
    if (status != 0) return;
    // 点击报名，判断是否满足条件
    // 满足：报名成功
    // 不满足：不满足报名条件
    bool success = await controller.enroll();
    WarningDialog.show(
        title: success ? LocaleKeys.other82.tr : LocaleKeys.other81.tr,
        icon: success
            ? 'assets/with_suc'.svgAssets()
            : 'assets/with_pending'.svgAssets(),
        okTitle: LocaleKeys.public1.tr);
  }

  taskTitle() {
    return [
      32.verticalSpaceFromWidth,
      Text(LocaleKeys.other68.tr,
          style: AppTextStyle.f_20_700.colorTextPrimary),
      8.verticalSpaceFromWidth,
      Text(LocaleKeys.other69.tr,
          style: AppTextStyle.f_12_500.colorTextDescription),
      16.verticalSpaceFromWidth
    ];
  }

  Widget? _taskItemBuilder(BuildContext context, int index) {
    ActivityTask? task = controller.tasks[index];
    TaskStatus taskStatus = task?.taskStatus();
    return Container(
      width: 358.w,
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.w),
        border: Border.all(
          width: 1.w,
          color: AppColor.colorBorderSubtle,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 206, 31, 0.05),
            Color.fromRGBO(255, 206, 31, 0.1),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyImage(
                'activity/task_usdt'.pngAssets(),
                width: 40.w,
                height: 40.w,
              ),
              12.horizontalSpace,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                    '${LocaleKeys.other70.tr}:${task?.rewardsTotal} ${task?.rewardsSymbol}',
                    style: AppTextStyle.f_16_600.colorTextPrimary),
                Text('${LocaleKeys.other71.tr}：${task?.rewardsCount}',
                    style: AppTextStyle.f_12_400.colorTextDescription),
              ]),
            ],
          ),
          16.verticalSpaceFromWidth,
          Text(task?.taskTitle ?? '',
              style: AppTextStyle.f_14_600.colorTextPrimary),
          4.verticalSpaceFromWidth,
          Text(task?.taskDesc ?? '',
              style: AppTextStyle.f_12_400.colorTextDescription),
          if (task != null) progressWidget(task),
          16.verticalSpaceFromWidth,
          MyButton(
            onTap: () {
              if (taskStatus == TaskStatus.toComplete) {
                if (task?.type == '1') {
                  //入金任务：跳转充值页
                  RouteUtil.goTo('/recharge');
                } else if (task?.type == '2') {
                  // 交易任务：跳转对应类型（1永续合约、2标准合约、3跟单）
                  if (task?.tradeType == '1') {
                    RouteUtil.goTo('/trade-feature');
                  } else if (task?.tradeType == '2') {
                    RouteUtil.goTo('/trade-commodity');
                  } else if (task?.tradeType == '3') {
                    RouteUtil.goTo('/follow-orders');
                  }
                } else if (task?.type == '3') {
                  //邀请任务： 跳转邀请返佣页
                  Get.toNamed(Routes.MY_INVITE);
                }
              }
            },
            borderRadius: BorderRadius.circular(999),
            height: 48.w,
            backgroundColor: taskStatus == TaskStatus.toComplete &&
                    controller.activityDetail.value.status == 1
                ? AppColor.colorBackgroundInversePrimary
                : AppColor.colorBackgroundInverseDisabled,
            text: taskButtonText(taskStatus),
            textStyle: AppTextStyle.f_16_600.colorAlwaysWhite,
          ),
        ],
      ),
    );
  }

  String taskButtonText(TaskStatus taskStatus) {
    switch (taskStatus) {
      case TaskStatus.completed:
        return LocaleKeys.other95.tr;
      case TaskStatus.toComplete:
        return LocaleKeys.other72.tr;
      case TaskStatus.end:
        return LocaleKeys.other73.tr;
    }
  }

  progressWidget(ActivityTask task) {
    if (task.tradeVolume == null || task.dealVolume == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        4.verticalSpaceFromWidth,
        SizedBox(
          height: 6.w,
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(4.w),
            backgroundColor: AppColor.colorBorderStrong,
            color: Colors.green,
            value: (task.dealVolume?.toDouble() ?? 0) /
                (task.tradeVolume?.toDouble() ?? 1),
          ),
        ),
        2.verticalSpaceFromWidth,
        Text.rich(
          TextSpan(
            text: task.tradeVolume ?? '',
            style: AppTextStyle.f_12_600.colorTextPrimary,
            children: [
              WidgetSpan(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Text(
                  '/',
                  style: AppTextStyle.f_12_600.colorTextTips,
                ),
              )),
              TextSpan(
                text: TextUtil.formatComma3(task.dealVolume ?? ''),
                style: AppTextStyle.f_12_600.colorTextTips,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void toShare() {
    ShareDialog.show(child: shareImg());
  }

  Widget shareImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.w),
      child: SizedBox(
        width: 300.w,
        child: Column(
          children: [
            Container(
              color: AppColor.colorAlwaysBlack,
              child: Column(
                children: [
                  24.verticalSpaceFromWidth,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyImage(
                        'activity/logo_black'.svgAssets(),
                        width: 30.w,
                        height: 30.w,
                      ),
                      10.horizontalSpace,
                      Text(
                        'BITCOCO',
                        style: AppTextStyle.f_19_900.colorAlwaysWhite
                            .copyWith(height: 32 / 19),
                      ),
                    ],
                  ),
                  15.verticalSpaceFromWidth,
                  Text(
                    controller.activityDetail.value.name ?? '',
                    style: AppTextStyle.f_20_700.colorAlwaysWhite,
                  ),
                  Text(
                    controller.activityDetail.value.title ?? '',
                    style: AppTextStyle.f_20_700.colorAlwaysWhite,
                  ),
                  15.verticalSpaceFromWidth,
                  MyImage(
                    controller.activityDetail.value.blackImg ?? '',
                    // 'activity/new_user_activity_share_img'.svgAssets(),
                    width: 221.w,
                    height: 221.w,
                    fit: BoxFit.fill,
                  ),
                  1.verticalSpaceFromWidth,
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.colorWhite,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.w),
                  bottomRight: Radius.circular(12.w),
                ),
              ),
              height: 84.w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.w),
              child: Row(
                children: [
                  QrImageView(
                    data: 'shareUrl',
                    size: 64.w,
                    padding: EdgeInsets.all(5.6.w),
                  ),
                  8.horizontalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.other83.tr,
                        style: AppTextStyle.f_14_700.colorAlwaysBlack,
                      ),
                      Row(
                        children: [
                          Text(
                            LocaleKeys.other84.tr,
                            style: AppTextStyle.f_12_500.colorAlwaysBlack,
                          ),
                          4.horizontalSpace,
                          Text(
                            controller.activityDetail.value.inviteCode ?? '',
                            style: AppTextStyle.f_12_500.colorAlwaysBlack,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rulesWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(LocaleKeys.other74.tr,
              style: AppTextStyle.f_20_700.colorTextPrimary),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: Text(LocaleKeys.other85.tr,
                style: AppTextStyle.f_12_400_15.colorTextPrimary),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ruleItemBuilder,
              separatorBuilder: (_, __) => 8.verticalSpaceFromWidth,
              itemCount: rules.length),
        ],
      ),
    );
  }

  Widget? ruleItemBuilder(BuildContext context, int index) {
    return Text(rules[index], style: AppTextStyle.f_12_400_15.colorTextTips);
  }
}
