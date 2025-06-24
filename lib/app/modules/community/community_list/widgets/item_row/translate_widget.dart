import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/translate.dart';

import '../../../../../../generated/locales.g.dart';

class ComTopicTranslateWidget extends StatefulWidget {
  final Function(bool checkTranslate, LanguageTranslateModel? content)? ontap;
  final TopicdetailModel model;

  const ComTopicTranslateWidget({super.key, required this.model, this.ontap});

  @override
  State<ComTopicTranslateWidget> createState() =>
      _ComTopicTranslateWidgetState();
}

class _ComTopicTranslateWidgetState extends State<ComTopicTranslateWidget> {
  bool translating = false;
  LanguageTranslateModel? content;
  bool showing = false;
  @override
  Widget build(BuildContext context) {
    if (translating) {
      return SizedBox(
          width: 13,
          height: 13,
          child: Lottie.asset(
            'assets/json/loading.json',
            repeat: true,
            width: 13.w,
            height: 13.w,
          ));
    }
    return InkWell(
      onTap: () {
        if (ObjectUtil.isEmpty(content)) {
          translateContent();
          return;
        }

        setState(() {
          showing = !showing;
        });
        widget.ontap?.call(showing, content);
      },
      child: Text(
          showing
              ? LocaleKeys.community92.tr //'查看原文',
              : LocaleKeys.community93.tr, //'查看翻译',
          style: AppTextStyle.f_12_400.colorTextDescription),
    );
  }

  Future<void> translateContent() async {
    setState(() {
      translating = true;
    });

    LanguageTranslateModel? response = await CommunityApi.instance()
        .languageTranslate(widget.model.topicNo ?? '');
    if (ObjectUtil.isNotEmpty(response)) {
      setState(() {
        translating = false;
        content = response;
        showing = !showing;
        widget.ontap?.call(showing, content);
      });
    } else {
      setState(() {
        translating = false;
        content = response;
      });
    }
  }
}
