import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/hot_topic.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../../generated/locales.g.dart';

class FavoriteCommunityRow extends StatelessWidget {
  final List<HotTopicModel>? data;

  const FavoriteCommunityRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (ObjectUtil.isEmpty(data)) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                16.verticalSpaceFromWidth,
                GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.FAVOURITE_TOPIC,
                          arguments: {'list': data});
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.community101.tr, //'热门话题',
                            style: AppTextStyle.f_16_600.colorTextPrimary),
                        MyImage('community/arrow_forward_ios'.svgAssets(),
                            width: 14.w)
                      ],
                    )),
                16.verticalSpaceFromWidth,
                ListView.separated(
                    separatorBuilder: (_, __) => 16.verticalSpaceFromWidth,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data!.length > 3 ? 3 : data!.length,
                    itemBuilder: (context, index) {
                      HotTopicModel model = data![index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.HOT_DETAIL_TOPIC,
                              arguments: {'model': model, 'index': index},
                              preventDuplicates: false);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyImage(
                              'community/hot_topic$index'.svgAssets(),
                              width: 20.w,
                              height: 20.w,
                            ),
                            8.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 1.sw - 28.w - 32.w,
                                  child: Text(
                                    model.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle
                                        .f_14_500.colorTextSecondary,
                                    strutStyle: const StrutStyle(
                                      forceStrutHeight: true,
                                    ),
                                  ),
                                ),
                                4.verticalSpaceFromWidth,
                                Row(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${model.pageViewNum}',
                                            style: AppTextStyle
                                                .f_10_600.colorTextDescription),
                                        4.horizontalSpace,
                                        Text(
                                            LocaleKeys.community102.tr, //'次浏览',
                                            style: AppTextStyle
                                                .f_10_400.colorTextTips),
                                      ],
                                    ),
                                    16.horizontalSpace,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${model.quoteNum}',
                                            style: AppTextStyle
                                                .f_10_600.colorTextDescription),
                                        4.horizontalSpace,
                                        Text(
                                            LocaleKeys.community103.tr, //'个内容',
                                            style: AppTextStyle
                                                .f_10_400.colorTextTips),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ],
            )),
        16.verticalSpaceFromWidth,
        Container(height: 1, color: AppColor.colorBorderGutter)
      ],
    ); // Padding(padding: EdgeInsets.symmetric(horizontal: 16.w),child: );
  }
}
