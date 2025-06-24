import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';

import '../../../../../widgets/imageWidget/common/model/pic_swiper_item.dart';
import '../../../../../widgets/imageWidget/common/widget/pic_swiper.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.content,
    required this.time,
    required this.avatar,
    required this.picUrl,
    required this.isSender,
    required this.uid,
  });
  final String content;
  final String time;
  final String avatar;
  final String picUrl;
  final bool isSender;
  final String uid;

  @override
  Widget build(BuildContext context) {
    if (isSender) {
      return _rightMessage();
    } else {
      return _leftMessage();
    }
  }

  Widget _imageWidget() {
    return InkWell(
      onTap: () {
        Get.dialog(
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: PicSwiper(
              index: 0,
              pics: [
                PicSwiperItem(
                  picUrl: picUrl,
                  des: '',
                ),
              ],
            ),
          ),
          useSafeArea: false,
          barrierDismissible: true,
        );
      },
      child: Container(
        color: AppColor.colorF1F1F1,
        child: MyImage(
          width: 160.w,
          picUrl,
          fit: BoxFit.cover,
          radius: 8.r,
          color: AppColor.colorECECEC,
        ),
      ),
    );
  }

  Widget _content(bool isLeft) {
    return Column(
      crossAxisAlignment:
          isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 225.w,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isLeft ? AppColor.bgColorLight : AppColor.colorFFD429,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            content,
            style: AppTextStyle.f_15_400.color0C0D0F,
          ),
        ),
        // if (time.isNotEmpty)
        //   Text(
        //     time,
        //     style: AppTextStyle.small2_400.color999999,
        //   ).marginOnly(top: 8.h),
      ],
    );
  }

  Widget _rightMessage() {
    return Column(
      children: [
        Text(time, style: AppTextStyle.f_11_400.color999999)
            .paddingOnly(bottom: 10.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(),
            picUrl.isImageFileName ? _imageWidget() : _content(false),
            10.horizontalSpace,
            InkWell(
              onTap: () {
                Get.toNamed(Routes.PERSONAL_PROFILE, arguments: {
                  'uid': uid.toInt(),
                });
              },
              child: UserAvatar(
                avatar,
                width: 40.w,
                height: 40.w,
              ),
            ),
          ],
        ).marginSymmetric(vertical: 10.w),
      ],
    );
  }

  Widget _leftMessage() {
    return Column(
      children: [
        Text(time, style: AppTextStyle.f_11_400.color999999)
            .paddingOnly(bottom: 10.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.PERSONAL_PROFILE, arguments: {
                  'uid': uid.toInt(),
                });
              },
              child: UserAvatar(
                avatar,
                width: 40.w,
                height: 40.w,
              ),
            ),
            10.horizontalSpace,
            picUrl.isNotEmpty ? _imageWidget() : _content(true),
            const Spacer(),
          ],
        ).marginSymmetric(vertical: 10.w),
      ],
    );
  }
}
