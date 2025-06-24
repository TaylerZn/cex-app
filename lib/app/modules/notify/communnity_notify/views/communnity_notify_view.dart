import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/file_upload.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/message/user_message.dart';
import 'package:nt_app_flutter/app/modules/notify/message/models/community_notif.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_appbar_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/communnity_notify_controller.dart';

class CommunnityNotifyView extends GetView<CommunnityNotifyController> {
  const CommunnityNotifyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(myTitle: LocaleKeys.community80.tr),
      body: controller.pageObx(
        (state) {
          return SmartRefresher(
            controller: controller.refreshController,
            onRefresh: () => controller.refreshData(true),
            onLoading: controller.loadMoreData,
            enablePullUp: true,
            enablePullDown: true,
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state?.length ?? 0,
              itemBuilder: (BuildContext c, int i) {
                UserMessage? message = state?[i];
                CommunityNotif notif = communityNotifFromJson(
                    '${message?.extInfo ?? '{}'}'.replaceAll('\n', ''));
                Widget content() {
                  switch (message?.messageType) {
                    case 105:
                      return voteEndContent(message, notif);
                    case 106:
                      return quoteContent(message, notif);
                    case 102:
                      return replyContent(message, notif);
                    default:
                      return commonContent(message, notif);
                  }
                }

                TopicdetailModel model =
                    TopicdetailModel.fromJson(notif.toJson());
                model.type = notif.hasVideo == true
                    ? CommunityFileTypeEnum.VIDEO
                    : CommunityFileTypeEnum.PIC;

                return InkWell(
                  onTap: () {
                    if (ObjectUtil.isEmpty(model.topicNo)) {
                      return;
                    }
                    MyCommunityUtil.jumpToTopicDetail(model);
                  },
                  child: content(),
                );
              },
            ),
          );
        },
        onRetryRefresh: () => controller.refreshData(false),
      ),
    );
  }

  Widget buildContent(UserMessage? message, CommunityNotif noti,
      {bool quote = false}) {
    return Row(
      children: [
        Text('|', style: AppTextStyle.f_11_400.colorABABAB),
        4.w.horizontalSpace,
        Expanded(
            child: Text(quote ? noti.quotedTitle ?? '-' : noti.title ?? '-',
                style: AppTextStyle.f_11_400.colorABABAB,
                maxLines: 1,
                overflow: TextOverflow.ellipsis)),
        4.w.horizontalSpace,
        Text(
            RelativeDateFormat.format(
                MyTimeUtil.timestampToDate(message?.ctime ?? 0),
                shortFormat: 'MM/dd',
                longFormat: 'yyyy/MM/dd'),
            style: AppTextStyle.f_12_400.color999999)
      ],
    );
  }

  Widget voteEndContent(UserMessage? message, CommunityNotif notif) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  4.w.verticalSpaceFromWidth,
                  MyImage('notify/vote_end'.svgAssets())
                ],
              ),
              16.w.horizontalSpace,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitleContent(message, notif, vote: true),
                  8.w.verticalSpace,
                  buildContent(message, notif)
                ],
              ))
            ],
          ),
          16.w.verticalSpaceFromWidth,
          Divider(color: AppColor.colorEEEEEE)
        ],
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                4.w.verticalSpaceFromWidth,
                MyImage('notify/vote_end'.svgAssets())
              ],
            ),
            16.w.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitleContent(message, notif, vote: true),
                8.w.verticalSpace,
                buildContent(message, notif)
              ],
            )
          ],
        ),
        16.w.verticalSpaceFromWidth,
        Divider(),
        16.w.verticalSpaceFromWidth,
      ],
    );
  }

  Widget quoteContent(UserMessage? message, CommunityNotif notif) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            notif.pictureUrl,
            width: 36.w,
            height: 36.w,
          ),
          8.w.verticalSpaceFromWidth,
          buildTitleContent(message, notif),
          8.w.verticalSpaceFromWidth,
          Text(notif.title ?? '-', style: AppTextStyle.f_11_400),
          8.w.verticalSpaceFromWidth,
          buildContent(message, notif, quote: true),
          16.w.verticalSpaceFromWidth,
          const Divider(color: AppColor.colorEEEEEE)
        ],
      ),
    );
  }

  Widget replyContent(UserMessage? message, CommunityNotif notif) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            notif.pictureUrl,
            width: 36.w,
            height: 36.w,
          ),
          8.w.verticalSpaceFromWidth,
          buildTitleContent(message, notif),
          8.w.verticalSpaceFromWidth,
          Text(notif.replyContent ?? '-',
              style: AppTextStyle.f_11_400.colorABABAB),
          8.w.verticalSpaceFromWidth,
          buildContent(message, notif),
          16.w.verticalSpaceFromWidth,
          Divider(color: AppColor.colorEEEEEE)
        ],
      ),
    );
  }

  Widget buildTitleContent(UserMessage? message, CommunityNotif notif,
      {bool vote = false}) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: ScreenUtil().screenWidth - 32.w - (vote ? 34.w : 0.w)),
      child: Text(
        notif.subject ?? '-',
        style: AppTextStyle.f_15_500,
      ),
    );
  }

  Widget commonContent(UserMessage? message, CommunityNotif notif) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            notif.pictureUrl,
            width: 36.w,
            height: 36.w,
          ),
          8.w.verticalSpaceFromWidth,
          buildTitleContent(message, notif),
          8.w.verticalSpaceFromWidth,
          Visibility(
              visible: ObjectUtil.isNotEmpty(notif.quotedTitle),
              child: Container(
                  margin: EdgeInsets.only(top: 8.w),
                  child: Row(
                    children: [Text('${notif.quotedTitle}')],
                  ))),
          buildContent(message, notif),
          16.w.verticalSpaceFromWidth,
          Divider(color: AppColor.colorEEEEEE)
        ],
      ),
    );
  }
}
