import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/community.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';

import '../../../../../generated/locales.g.dart';

class PostQuoteWidget extends StatefulWidget {
  final Function? onTap;
  final TopicdetailModel? model;
  final String? quoteId;

  const PostQuoteWidget({super.key, this.quoteId, this.onTap, this.model});

  @override
  State<PostQuoteWidget> createState() => _PostQuoteWidgetState();
}

class _PostQuoteWidgetState extends State<PostQuoteWidget> {
  TopicdetailModel? model;
  bool requested = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      if (ObjectUtil.isNotEmpty(widget.quoteId) && widget.quoteId != '0') {
        TopicdetailModel? value = await CommunityApi.instance()
            .topicdetail({'topicNo': widget.quoteId});
          model = value;
          requested = true;
          if (mounted) {
            setState(() {});
          }
      }
    } on dio.DioException catch (e) {
      requested = true;
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    if (ObjectUtil.isEmpty(widget.quoteId)) {
      return const SizedBox();
    }

    if (ObjectUtil.isEmpty(model) && !requested) {
      return SizedBox();
    }

    if (requested && ObjectUtil.isEmpty(model)) {
      return Container(
        margin: EdgeInsets.only(bottom: 10.h),
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(color: AppColor.colorECECEC)),
        child: Text(LocaleKeys.community104.tr, //'引用内容已被删除',
            style: AppTextStyle.f_12_400.color999999),
      );
    }
    widget.model?.quoteCache = model;
    return buildContent(model);
  }

  Widget buildContent(TopicdetailModel? model) {
    return InkWell(
        onTap: () {
          MyCommunityUtil.jumpToTopicDetail(model);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(color: AppColor.colorECECEC)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                UserAvatar(
                  model?.memberHeadUrl,
                  width: 19.w,
                  height: 19.w,
                ),
                4.horizontalSpace,
                Text('${model?.memberName}', style: AppTextStyle.f_13_500)
              ]),
              6.verticalSpace,
              Text('${model?.topicTitle}', style: AppTextStyle.f_13_500),
              4.verticalSpace,
              MyCommunityUtil.specialStringtToWidget(
                  model?.topicContent ?? '', SpecialContentEnum.postTitle,
                  textStyle: AppTextStyle.f_12_400,
                  specialTextStyle: AppTextStyle.f_12_400.color4D4D4D)
            ],
          ),
        ));
  }

  @override
  void didUpdateWidget(covariant PostQuoteWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // loadData();
  }
}
