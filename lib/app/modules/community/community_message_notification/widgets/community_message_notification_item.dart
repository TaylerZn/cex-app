import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../models/community_message_notification_item_model.dart';

class CommunityMessageNotificationItem extends StatelessWidget {
  final CommunityMessageNotificationItemModel message;

  CommunityMessageNotificationItem({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
      decoration: BoxDecoration(
        color: AppColor.colorFFFFFF,
      ),
      child: _buildContentBasedOnType(),
    );
  }

  Widget _buildContentBasedOnType() {
    switch (message.messageTypeString) {
      case 'pinned':
        return _buildPinnedMessage();
      case 'mention':
        return _buildMentionMessage();
      case 'quote':
        return _buildQuoteMessage();
      case 'reply':
        return _buildReplyMessage();
      case 'like':
        return _buildLikeMessage();
      case 'voteEnd':
        return _buildVoteEndMessage();
      default:
        return Container();
    }
  }

  Widget _buildPinnedMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyImage(message.avatar ?? '',
            width: 36.0.w, height: 36.w, radius: 45.w),
        SizedBox(width: 8.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.community62.trArgs([message.userName ?? '']),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.color111111,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message.timeDate ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.color999999,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          message.messageUserId ?? '',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.colorABABAB,
          ),
        ),
      ],
    );
  }

  Widget _buildMentionMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyImage(message.avatar ?? '',
            width: 36.0.w, height: 36.w, radius: 45.w),
        SizedBox(width: 8.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.community63.trArgs([message.userName ?? '']),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.color111111,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message.timeString ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.colorABABAB,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          "@${message.messageUserId ?? ''}",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.colorABABAB,
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyImage(message.avatar ?? '',
            width: 36.0.w, height: 36.w, radius: 45.w),
        SizedBox(width: 8.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.community64.trArgs([message.userName ?? '']),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.color111111,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message.timeDate ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.color999999,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          message.messageContent ?? '',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.colorABABAB,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          message.messageUserId ?? '',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.colorABABAB,
          ),
        ),
      ],
    );
  }

  Widget _buildReplyMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyImage(message.avatar ?? '',
            width: 36.0.w, height: 36.w, radius: 45.w),
        SizedBox(width: 8.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.community65.trArgs([message.userName ?? '']),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.color111111,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message.timeDate ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.color999999,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          message.messageUserId ?? '',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.colorABABAB,
          ),
        ),
      ],
    );
  }

  Widget _buildLikeMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.userName ?? '',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.color111111,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          message.messageContent ?? '',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.color666666,
          ),
        ),
      ],
    );
  }

  Widget _buildVoteEndMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyImage('community/community_message/vote_icon.svg'.svgAssets(),
            width: 16.0.w, height: 16.w),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    message.messageTitle ?? LocaleKeys.community67.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.color111111,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    message.timeString,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.color999999,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                message.messageContent ?? LocaleKeys.community68.tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.colorABABAB,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
