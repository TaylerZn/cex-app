import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/activity.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/cms_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../getX/home_banner_swiper_Getx.dart';

// 活动类型
enum ActivityEnumn {
  homePost,
  followMain,
  followMainTrader,
  assetsSpotsInfo,
  homeInvite;

  String get position => ['1', '2', '3', '4', '8'][index];
}

// 活动跳转类型
enum ActivityUrlTypeEnumn {
  outside,
  inside;

  int get value => [1, 2][index];
}

class MyActivityWidget extends StatelessWidget {
  const MyActivityWidget(
      {super.key,
      required this.list,
      required this.height,
      this.horizontal = 16,
      this.radius = 8,
      this.fit = BoxFit.cover,
      this.pagination,
      this.havePagination = true});

  final List<CmsAdvertListModel?> list;
  final double height;
  final double horizontal;
  final double radius;
  final BoxFit fit;
  final SwiperPlugin? pagination;
  final bool havePagination;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeBannerSwiperGetX>(builder: (controller) {
      return SizedBox(
        height: height,
        child: Stack(
          children: [
            Swiper(
              autoplayDelay: 8000,
              duration: 1000,
              onTap: (index) {
                CmsAdvertListModel? item = list[index];
                if (item?.url != null) {
                  if (item?.urlType == ActivityUrlTypeEnumn.outside.value) {
                    Get.toNamed(Routes.WEBVIEW, arguments: {'url': item?.url ?? ''});
                  } else if (item?.urlType == ActivityUrlTypeEnumn.inside.value) {
                    if (item?.url == '/weal-index') {
                      CMSRouteUtil.routeTo(item?.url ?? '');
                    } else {
                      if (UserGetx.to.goIsLogin()) {
                        CMSRouteUtil.routeTo(item?.url ?? '');
                      }
                    }
                  }
                }
              },
              onIndexChanged: (index) {
                controller.changeIndex(index);
              },
              // pagination: pagination,
              itemBuilder: (BuildContext context, int index) {
                CmsAdvertListModel? item = list[index];
                return MyImage(
                  item?.imgUrl ?? '',
                  fit: fit,
                  width: 166.w,
                  height: 240.w,
                  radius: radius,
                );
              },
              itemCount: list.length,
              autoplay: true,
              loop: true,
            ),
            havePagination
                ? Positioned(
                    bottom: 14.w,
                    left: 14.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() => Text(
                              '${controller.currentIndex.value + 1}',
                              style: AppTextStyle.f_13_500.colorTextPrimary,
                            )),
                        Text(
                          '/${list.length}',
                          style: AppTextStyle.f_10_400.colorTextTips,
                        ).marginOnly(bottom: 2.w),
                      ],
                    ))
                : const SizedBox(),
          ],
        ),
      );
    });
  }
}
