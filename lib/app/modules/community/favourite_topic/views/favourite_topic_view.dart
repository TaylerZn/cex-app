import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/hot_topic.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../widgets/basic/my_image.dart';
import '../controllers/favourite_topic_controller.dart';

class FavouriteTopicView extends GetView<FavouriteTopicController> {
  const FavouriteTopicView({super.key});

  @override
  Widget build(BuildContext context) {
    List<HotTopicModel> list = Get.arguments?['list'] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: Text(LocaleKeys.community101.tr), //'热门话题'),
        centerTitle: true,
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => 8.verticalSpaceFromWidth,
          padding: EdgeInsets.all(16.w),
          itemCount: list.length,
          itemBuilder: (builder, index) {
            HotTopicModel model = list[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.HOT_DETAIL_TOPIC,
                    arguments: {'model': model}, preventDuplicates: false);
              },
              child: Container(
                  height: 36.w,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.w),
                    gradient: LinearGradient(
                      colors: bgColors[min(index, bgColors.length - 1)],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 20.w,
                        height: 20.w,
                        child: index < 3
                            ? MyImage(
                                'community/hot_topic_list$index'.svgAssets(),
                                width: 20.w,
                                height: 20.w,
                              )
                            : Text('${index + 1}',
                                style: AppTextStyle.f_12_600.colorTextTips),
                      ),
                      8.horizontalSpace,
                      Expanded(
                          child: Text('${model.name}',
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.f_16_500.colorTextPrimary)),
                      13.horizontalSpace,
                      Text(TextUtil.formatComma3(model.pageViewNum ?? 0),
                          style: AppTextStyle.f_12_400.colorTextTips),
                    ],
                  )),
            );
          }),
    );
  }

  static const List bgColors = [
    [Color.fromRGBO(255, 137, 28, 0.1), Color.fromRGBO(255, 137, 28, 0)],
    [Color.fromRGBO(255, 178, 28, 0.1), Color.fromRGBO(255, 178, 28, 0)],
    [Color.fromRGBO(255, 212, 28, 0.1), Color.fromRGBO(255, 178, 28, 0)],
    [
      Color.fromRGBO(249, 249, 249, 1),
      Color.fromRGBO(249, 249, 249, 0),
    ]
  ];
}
