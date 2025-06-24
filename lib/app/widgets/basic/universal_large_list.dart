import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

Widget universalLargeListWidget(context, entries, {double? paddingHorizontal}) {
  return Column(
      children: entries(context)
          .map<Widget>((MenuLargeEntry e) => e.name != ''
              ? Column(
                  children: [
                    Container(
                      height: e.height ?? 55.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal ?? 0,
                      ),
                      child: Row(
                        children: <Widget>[
                          e.icon != '' && e.icon != null
                              ? e.isimg == true
                                  ? MyImage(
                                      e.icon,
                                      width: e.iconSize ?? 16.w,
                                      height: e.iconSize ?? 16.w,
                                    )
                                  : Icon(
                                      e.icon,
                                      size: e.iconSize ?? 16.w,
                                    )
                              : Container(),
                          16.horizontalSpace,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.name,
                                      style: AppTextStyle.f_14_400.color0C0D0F)
                                  .marginOnly(right: 60.w),
                              8.verticalSpace,
                              Text(e.content,
                                      style: AppTextStyle.f_12_400.color8E8E92)
                                  .marginOnly(right: 60.w),
                            ],
                          ),
                          Expanded(
                              child: e.rightWidget != null
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [e.rightWidget],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Visibility(
                                          visible: e.showSelected,
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            margin: EdgeInsets.only(right: 4.w),
                                            child: MyImage(
                                              'default/selected'.svgAssets(),
                                              width: 12.w,
                                              height: 12.w,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: e.showNewPoint,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              width: 4.w,
                                              height: 4.w,
                                              margin:
                                                  EdgeInsets.only(right: 4.w),
                                              decoration: BoxDecoration(
                                                  color: AppColor.colorE64F44,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: InkWell(
                                            onTap: throttle(() async {
                                              if (e.onTap != null) {
                                                e.onTap!();
                                              }
                                            }),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 6.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.w),
                                                color: e.behindbgColor,
                                              ),
                                              child: Text(
                                                e.behindName,
                                                style: AppTextStyle.f_14_400
                                                    .copyWith(
                                                        height: 1.5,
                                                        color:
                                                            e.behindNameColor),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                          SizedBox(
                            width: 4.w,
                          ),
                          e.goIcon == true
                              ? MyImage(
                                  'default/go'.svgAssets(),
                                  width: 12.w,
                                  color: AppColor.color4D4D4D,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    e.bottomBorder == true
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0.w, 0, 0, 0),
                            height: 0.5,
                            color: AppColor.colorEEEEEE,
                          )
                        : Container(height: 30.w),
                  ],
                )
              : Container())
          .toList());
}

class MenuLargeEntry {
  dynamic icon;
  dynamic iconSize;
  bool isimg;
  String name;
  String content;
  dynamic height;
  String behindName;
  GestureTapCallback? onTap;
  bool bottomBorder;
  bool goIcon;
  bool? radioBool;
  bool showNewPoint;
  bool showSelected;
  Color nameColor;
  Color behindNameColor;
  Color? behindbgColor;
  dynamic rightWidget;

  MenuLargeEntry(
      {this.icon,
      this.iconSize,
      this.isimg = true,
      this.name = '',
      this.content = '',
      this.height,
      this.onTap,
      this.behindName = '',
      this.bottomBorder = false,
      this.goIcon = true,
      this.showNewPoint = false,
      this.showSelected = false,
      this.radioBool,
      this.nameColor = AppColor.color666666,
      this.behindNameColor = AppColor.color999999,
      this.behindbgColor,
      this.rightWidget});
}
