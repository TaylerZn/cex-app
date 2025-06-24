import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? contentWidget;

  String? confirmText;
  String? cancelText;
  final Function? confirmHandler;
  final Function? cancelHandler;

  Color? confirmBackgroundColor;
  TextStyle? titleStyle;

  MyDialog(
      {super.key,
      required this.title,
      this.content,
      this.confirmText,
      this.cancelText,
      this.confirmHandler,
      this.cancelHandler,
      this.contentWidget,
      this.confirmBackgroundColor,
      this.titleStyle}) {
    cancelText ??= LocaleKeys.public2.tr;
    confirmText ??= LocaleKeys.public1.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 238.w,
          padding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 10.h),
          decoration: BoxDecoration(
              color: AppColor.colorWhite,
              borderRadius: BorderRadius.circular(6.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style:
                              titleStyle ?? AppTextStyle.f_16_500.color111111,
                          overflow: TextOverflow.clip),
                      content != null
                          ? Text(content ?? '',
                                  style: AppTextStyle.f_12_400_15.color666666
                                      .copyWith(overflow: TextOverflow.clip))
                              .marginOnly(top: 10.h)
                          : const SizedBox(),
                      contentWidget != null
                          ? Column(
                              children: [
                                contentWidget != null
                                    ? contentWidget!.marginOnly(top: 10.h)
                                    : const SizedBox(),
                              ],
                            )
                          : 0.verticalSpace,
                      16.verticalSpace,
                    ],
                  )),
              Row(
                children: _buildActions(context),
              )
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    List<Widget> list = [
      Expanded(
          child: MyButton(
        text: confirmText,
        height: 44.h,
        textStyle: AppTextStyle.f_14_500,
        backgroundColor: confirmBackgroundColor ?? AppColor.colorBlack,
        onTap: () => {confirmHandler!()},
      )),
    ];
    if (cancelHandler != null) {
      list.insertAll(
          0,
          [
            Expanded(
                child: MyButton(
              text: cancelText,
              height: 44.h,
              textStyle: AppTextStyle.f_14_500,
              backgroundColor: AppColor.colorF5F5F5,
              color: AppColor.color111111,
              onTap: () => {cancelHandler!()},
            )),
            SizedBox(
              width: 6.w,
            )
          ].toList());
    }
    return list;
  }
}
