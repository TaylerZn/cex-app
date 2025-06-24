import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

Widget universalListWidget(context, entries, {double? paddingHorizontal}) {
  return Column(
      children: entries(context)
          .map<Widget>((MenuEntry e) => e.name != ''
              ? InkWell(
                  onTap: throttle(() async {
                    if (e.onTap != null) {
                      e.onTap!();
                    }
                  }),
                  splashColor: AppColor.color111111.withOpacity(0),
                  child: Column(
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
                            8.horizontalSpace,
                            Text(e.name, style: AppTextStyle.f_14_500)
                                .marginOnly(right: 60.w),
                            Expanded(
                                child: e.rightWidget != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [e.rightWidget],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                            visible: e.showSelected,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              margin:
                                                  EdgeInsets.only(right: 4.w),
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
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              e.behindName,
                                              style: AppTextStyle.f_12_500
                                                  .copyWith(
                                                      height: 1.5,
                                                      color: e.behindNameColor),
                                              overflow: TextOverflow.ellipsis,
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
                          : Container(),
                    ],
                  ),
                )
              : Container())
          .toList());
}

class MenuEntry {
  dynamic icon;
  dynamic iconSize;
  bool isimg;
  String name;
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
  dynamic rightWidget;

  MenuEntry(
      {this.icon,
      this.iconSize,
      this.isimg = true,
      this.name = '',
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
      this.rightWidget});
}
