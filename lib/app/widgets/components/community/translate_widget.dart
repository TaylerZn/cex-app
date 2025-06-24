import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/translate.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

enum TranslateType {
  isTranslate,
  needTranslate,
  loading,
  success,
}

/// 翻译widget
class TranslateWidget extends StatefulWidget {
  final String? topicNo; // 帖子id

  /// 翻译成功后回调

  const TranslateWidget({
    super.key,
    required this.topicNo,
  });

  @override
  State<TranslateWidget> createState() => _TranslateWidgetState();
}

class _TranslateWidgetState extends State<TranslateWidget> {
  TranslateType type = TranslateType.isTranslate;
  LanguageTranslateModel? translateData;
  IsTranslateModel? isTranslateData;
  @override
  void initState() {
    isTranslate();
    super.initState();
  }

  //帖子是否需要翻译
  isTranslate() async {
    try {
      IsTranslateModel? res =
          await CommunityApi.instance().isTranslate('${widget.topicNo}');
      if (res != null && res.isTranslate == true) {
        isTranslateData = res;
        setState(() {
          type = TranslateType.needTranslate;
        });
      }
    } catch (e) {
      print(e);
      Get.log('isTranslate error: $e');
    }
  }

  //社区帖子翻译
  languageTranslate() async {
    setState(() {
      type = TranslateType.loading;
    });

    try {
      LanguageTranslateModel? res =
          await CommunityApi.instance().languageTranslate('${widget.topicNo}');
      if (res != null) {
        setState(() {
          type = TranslateType.success;
          translateData = res;
        });
      }
    } catch (e) {
      print(e);
      Get.log('languageTranslate error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: type == TranslateType.needTranslate,
            child: InkWell(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(0, 16.h, 0, 0.h),
                  child: Text(LocaleKeys.community71.tr,
                      style: AppTextStyle.f_11_400.color0075FF)),
              onTap: () {
                languageTranslate();
              },
            )),
        Visibility(
            visible: type == TranslateType.loading,
            child: Container(
                margin: EdgeInsets.only(top: 10.w),
                child: Lottie.asset(
                    'assets/json/community/translate_loading.json',
                    width: 30.w,
                    height: 30.w))),
        Visibility(
            visible: type == TranslateType.success,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.verticalSpace,
                Text(
                    '${LocaleKeys.community72.trArgs([
                          (isTranslateData?.sourceLanguage ?? '--')
                        ])} ',
                    style: AppTextStyle.f_11_400.color0075FF),
                16.verticalSpace,
                Visibility(
                    visible: (translateData?.translateTitle ?? '').isNotEmpty,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text((translateData?.translateTitle ?? ''),
                          style: AppTextStyle.f_18_500.color111111),
                    )),
                16.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible:
                          (translateData?.translateContent ?? '').isNotEmpty,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text((translateData?.translateContent ?? ''),
                                style: AppTextStyle.f_16_400.color4D4D4D
                                    .copyWith(overflow: TextOverflow.clip)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}
