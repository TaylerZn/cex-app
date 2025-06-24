import 'package:card_swiper/card_swiper.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../config/theme/app_color.dart';
import '../../../getX/notify_Getx.dart';
import '../../../models/notice/notice.dart';
import '../../../routes/app_pages.dart';

RxBool showNotice = true.obs;

class TradeNotifyWidget extends StatelessWidget {
  const TradeNotifyWidget({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!showNotice.value) return const SizedBox();
      return GetBuilder<NoticeGetx>(
          id: 'tradeNotice',
          builder: (controller) {
            if (controller.tradeNoticeList.isEmpty) return const SizedBox();
            return Container(
              height: 28.h,
              margin: margin ??
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                color: AppColor.colorBackgroundInput,
                borderRadius: BorderRadius.circular(6.w),
              ),
              child: Row(
                children: [
                  MyImage(
                    'assets/images/contract/trade_notice.svg',
                    width: 16.w,
                    height: 16.w,
                  ),
                  11.horizontalSpace,
                  Expanded(
                    child: Swiper(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        NoticeInfo noticeInfo = controller.tradeNoticeList[index];
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
                      itemCount: controller.tradeNoticeList.length,
                      autoplay: true,
                      loop: true,
                    ),
                  ),
                  MyImage(
                    'assets/images/contract/trade_notice_close.svg',
                    onTap: () {
                      showNotice.value = false;
                    },
                  ).paddingAll(6.w),
                ],
              ),
            );
          });
    });
  }
}
