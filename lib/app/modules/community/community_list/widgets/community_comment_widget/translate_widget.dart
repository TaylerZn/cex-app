import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';

import '../../../../../../generated/locales.g.dart';

class ComTranslateWidget extends StatefulWidget {
  final Function(
      bool checkTranslate, String content, CommunityCommentItem curItem)? ontap;
  final CommunityCommentItem commentItem;

  const ComTranslateWidget({super.key, required this.commentItem, this.ontap});

  @override
  State<ComTranslateWidget> createState() => _ComTranslateWidgetState();
}

class _ComTranslateWidgetState extends State<ComTranslateWidget> {
  bool translating = false;
  String content = '';
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
        showing = !showing;
        widget.ontap?.call(showing, content, widget.commentItem);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: showing
            ? Text(LocaleKeys.community92.tr, //'查看原文',
                style: AppTextStyle.f_10_400.tradingYel)
            : Text(LocaleKeys.community93.tr, //'查看翻译',
                style: AppTextStyle.f_10_400),
      ),
    );
  }

  Future<void> translateContent() async {
    setState(() {
      translating = true;
    });

    dynamic response = await CommunityApi.instance()
        .translateComment(widget.commentItem.commentNo ?? '');
    if (ObjectUtil.isNotEmpty(response?['translateContent'])) {
      setState(() {
        translating = false;
        content = response?['translateContent'];
        showing = !showing;
        widget.ontap?.call(showing, content, widget.commentItem);
      });
    } else {
      setState(() {
        translating = false;
        content = response?['translateContent'];
      });
    }
  }
}
