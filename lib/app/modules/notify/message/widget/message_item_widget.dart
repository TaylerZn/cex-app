import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/message/user_message.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import 'extension.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    super.key,
    required this.messageInfo,
    required this.messageIcon,
    this.isShowContent = false,
  });

  final UserMessage messageInfo;
  final String messageIcon;
  final bool isShowContent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleItemMessage(messageInfo);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColor.colorEEEEEE,
              width: 1.h,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: AppColor.colorEEEEEE,
                  ),
                  borderRadius: BorderRadius.circular(18.w),
                ),
              ),
              child: _buildMessageImage(messageInfo.messageType, messageIcon),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    messageInfo.title ?? '-',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.color111111,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (isShowContent && messageInfo.contentText != null)
                    Padding(
                      padding:  EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        messageInfo.contentText!,
                        style: AppTextStyle.f_12_400_15.colorTextDescription,
                      ),
                    ),
                  Text(
                    RelativeDateFormat.format(
                        MyTimeUtil.timestampToDate(messageInfo.ctime ?? 0)),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.color999999,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMessageImage(int? messageType, String imageString) {
    return MyImage(
      imageString,
      width: 20.w,
    );
  }
}
