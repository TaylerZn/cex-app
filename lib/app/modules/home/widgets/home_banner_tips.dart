import 'package:card_swiper/card_swiper.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/notice/notice.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

import '../../../config/theme/app_text_style.dart';
import '../../../getX/notify_Getx.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/basic/my_image.dart';

class HomeBannerTips extends StatelessWidget {
  const HomeBannerTips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeGetx>(
      builder: (noticeGetx) => Visibility(
        visible: noticeGetx.noticeList.isNotEmpty,
        child: Container(
          height: 32.w,
          margin: EdgeInsets.only(bottom: 12.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              MyImage(
                'contract/trade_notice'.svgAssets(),
                width: 16.w,
                height: 16.w,
                fit: BoxFit.fill,
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Swiper(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        NoticeInfo noticeInfo = noticeGetx.noticeList[index];
                        return InkWell(
                          onTap: (){
                            if(ObjectUtil.isNotEmpty(noticeInfo.content)) {
                              Get.toNamed(Routes.WEBVIEW,arguments: {'url': noticeInfo.content});
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              noticeInfo.title ?? '',
                              style: AppTextStyle.f_11_400.colorTextDescription,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                      itemCount: noticeGetx.noticeList.length,
                      autoplay: true,
                      loop: true,
                    )),
              ),
              const Spacer(),
              MyImage(
                'home/right_small'.pngAssets(),
                width: 16.w,
                height: 16.w,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
