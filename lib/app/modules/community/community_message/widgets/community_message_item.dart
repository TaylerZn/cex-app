import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/community/community_message/models/communit_message_item_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class CommunityMessageItem extends StatefulWidget {
  final CommunityMessageItemModel message;

  CommunityMessageItem({
    required this.message,
  });
  @override
  State<CommunityMessageItem> createState() => _CommunityMessageItemState();
}

class _CommunityMessageItemState extends State<CommunityMessageItem> {
  late CommunityMessageItemModel message;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              // 在这里添加点击事件的处理逻辑
              Get.log('点击下');

              if (message.msgId == 100) {
                //去社区列表
                await Get.toNamed(Routes.COMMUNITY_NOTIFY, arguments: {
                  'messageType': message.msgId,
                  'title': message.title
                });
              } else {
                await Get.toNamed(Routes.NOTIFY, arguments: {
                  'messageType': message.msgId,
                  'title': message.title
                });
              }
              setState(() {
                message.notificationCount = 0;
              });
            },
            child: Container(
              height: 62.w,
              child: Row(
                children: [
                  MyImage(
                    message.iconSrc ?? '',
                    width: 36.0.w,
                    height: 36.0.w,
                  ),
                  16.w.horizontalSpace,
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              message.title ?? '',
                              style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.color111111),
                            )),
                            4.w.horizontalSpace,
                            if (message.notificationCount != null &&
                                message.notificationCount! > 0)
                              Container(
                                padding: EdgeInsets.all(1.w),
                                width: 20.w,
                                height: 20.w,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.colorFFD429),
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  message.notificationCount.toString(),
                                  style: AppTextStyle.f_10_400,
                                ),
                              ),
                          ],
                        ),
                        12.w.verticalSpace,
                        Visibility(
                            visible: message.subtitle?.isEmpty == false,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  message.subtitle ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.color666666),
                                )),
                                4.w.horizontalSpace,
                                Text(
                                  message.time ?? '',
                                  style: TextStyle(
                                      color: AppColor.color999999,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // 分割线
          Divider(
            color: AppColor.colorEEEEEE,
            thickness: 1.0,
          ),
        ],
      ),
    );
  }

  Widget content() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyImage(
          message.iconSrc ?? '',
          width: 36.0.w,
          height: 36.0.w,
        ),
        SizedBox(width: 16.0.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.title ?? '',
                style: TextStyle(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.color111111),
              ),
              SizedBox(height: 8.0.h),
              Text(
                message.subtitle ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.color666666),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (message.notificationCount != null &&
                message.notificationCount! > 0)
              Container(
                padding: EdgeInsets.all(1.w),
                width: 20.w,
                height: 20.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.colorFFD429),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  message.notificationCount.toString(),
                  style: AppTextStyle.f_10_400,
                ),
              ),
            SizedBox(height: 15.5.h),
            Expanded(
              child: Text(
                message.time ?? '',
                style: TextStyle(
                    color: AppColor.color999999,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
