// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowTranslateView extends StatefulWidget {
  const FollowTranslateView({super.key, required this.sourceStr, required this.sourceRXStr, this.callback});
  final String sourceStr;
  final RxString sourceRXStr;
  final VoidCallback? callback;

  @override
  State createState() => _FollowTranslateViewState();
}

class _FollowTranslateViewState extends State<FollowTranslateView> {
  var isText = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (widget.sourceRXStr.value == widget.sourceStr) {
            setState(() {
              isText = false;
            });
            followTranslate(widget.sourceRXStr);
          } else {
            widget.sourceRXStr.value = widget.sourceStr;
            widget.callback?.call();
          }
        },
        child: isText
            ? Text(LocaleKeys.follow473.tr, style: AppTextStyle.f_12_500.tradingYel)
            : SizedBox(width: 13, height: 13, child: Lottie.asset('assets/json/loading.json', repeat: true)));
  }

  followTranslate(RxString content) {
    AFFollow.translate(content: content.value).then((value) {
      // setState(() {
      isText = true;
      // });
      if (value.translateContent != null) {
        content.value = value.translateContent!;
      }
      widget.callback?.call();
    });
  }
}
