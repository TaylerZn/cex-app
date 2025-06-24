import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/notice/notice.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class NoticeItemWidget extends StatelessWidget {
  const NoticeItemWidget({super.key, required this.noticeInfo});
  final NoticeInfo noticeInfo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!TextUtil.isEmpty(noticeInfo.httpUrl)) {
          Get.toNamed(Routes.WEBVIEW, arguments: {'url': noticeInfo.httpUrl});
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          noticeInfo.title ?? '',
                          style: AppTextStyle.f_14_500.color111111,
                        ),
                      ),
                      !TextUtil.isEmpty(noticeInfo.httpUrl)
                          ? MyImage(
                              'default/go'.svgAssets(),
                              width: 8.w,
                              color: AppColor.colorABABAB,
                            )
                          : 0.verticalSpace
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    noticeInfo.timeLong != null
                        ? MyTimeUtil.timestampToStr(
                            noticeInfo.timeLong!.toInt())
                        : '',
                    style: AppTextStyle.f_12_400.color999999,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
