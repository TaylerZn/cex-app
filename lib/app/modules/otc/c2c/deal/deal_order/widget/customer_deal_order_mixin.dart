import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_list.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CustomerDealOrderTop extends StatelessWidget {
  const CustomerDealOrderTop(
      {super.key,
      required this.countStr,
      required this.icon,
      required this.usernameStr,
      required this.latestNewsStr,
      required this.orderId});
  final String countStr;
  final String icon;
  final String usernameStr;
  final String latestNewsStr;
  final num? orderId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(top: 24.h, bottom: 16.h),
      decoration: ShapeDecoration(
        color: AppColor.colorF5F5F5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
        children: <Widget>[
          ClipOval(
            child: MyImage(
              icon,
              width: 36.w,
              height: 36.w,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  usernameStr,
                  style: AppTextStyle.f_15_500.color4D4D4D,
                ),
                latestNewsStr.isEmpty
                    ? const SizedBox()
                    : Text(
                        latestNewsStr,
                        style: AppTextStyle.f_12_400.color999999.ellipsis,
                      ),
              ],
            ).paddingOnly(left: 8.h, right: 30.h),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              MyButton(
                text: LocaleKeys.c2c218.tr,
                height: 26.h,
                textStyle: AppTextStyle.f_12_600.colorWhite,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                onTap: () {
                  Get.toNamed(Routes.C2C_CHAT,
                      arguments: (orderId ?? 0).toString());
                },
              ),
              Positioned(
                  right: -6.w,
                  top: -6.w,
                  child: MyButton(
                    text: countStr,
                    height: 12.h,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    textStyle: AppTextStyle.f_10_500.colorWhite,
                    backgroundColor: AppColor.colorF53F57,
                    borderRadius: BorderRadius.circular(4),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

mixin CustomerTimer on GetxController {
  late Timer _timer;
  bool isRunning = false;
  num limitTime = 900000;
  var limitTimeStr = ''.obs;
  num appealTime = 300;
  var appealTimeStr = ''.obs;
  num remainTime = 900000;
  var remainTimeStr = ''.obs;
  Function(num, num, num)? callback;
  void initTimer(num limitTimeNum, num appealTimeNum, num remainTimeNum,
      {Function(num, num, num)? f}) {
    limitTime = limitTimeNum;
    appealTime = appealTimeNum;
    remainTime = remainTimeNum;

    callback = f;
    startTimer();
  }

  void startTimer() {
    if (!isRunning) {
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        if (limitTime > 0) {
          limitTime -= 1000;
          updateLimitTime = limitTime;
        } else {
          updateLimitTime = 0;
        }
        if (appealTime > 0) {
          appealTime -= 1;
          updateAppelLimitTime = appealTime;
        } else {
          updateAppelLimitTime = 0;
        }
        if (remainTime > 0) {
          remainTime -= 1000;
          updateRemainTime = remainTime;
        } else {
          updateRemainTime = 0;
        }

        callback?.call(limitTime, appealTime, remainTime);

        //  else {
        //   _timer.cancel();
        //   isRunning = false;
        // }
      });
      isRunning = true;
    }
  }

  void stopTimer() {
    if (isRunning) {
      _timer.cancel();
      isRunning = false;
    }
  }

  void resetTimer() {
    _timer.cancel();
    limitTime = 900000;
  }

  set updateLimitTime(num milliseconds) {
    int seconds = (milliseconds ~/ 1000) % 60;
    int minutes = (milliseconds ~/ (1000 * 60)) % 60;
    int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24;

    limitTimeStr.value =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  set updateAppelLimitTime(num milliseconds) {
    int seconds = (milliseconds ~/ 1) % 60;
    int minutes = (milliseconds ~/ (1 * 60)) % 60;
    // int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24;

    if (milliseconds > 0) {
      appealTimeStr.value =
          '${LocaleKeys.c2c116.tr} ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      appealTimeStr.value = '';
    }
  }

  set updateRemainTime(num milliseconds) {
    int seconds = (milliseconds ~/ 1000) % 60;
    int minutes = (milliseconds ~/ (1000 * 60)) % 60;
    int hours = (milliseconds ~/ (1000 * 60 * 60)) % 24;

    remainTimeStr.value =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

mixin CustomerOrderRow {
  getRow(String left, String right,
      {bool haveCopy = false,
      double top = 8,
      String? payKey,
      TextStyle? style}) {
    return Padding(
      padding: EdgeInsets.only(top: top.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(left, style: AppTextStyle.f_12_400.color666666),
          payKey == null
              ? Row(
                  children: <Widget>[
                    Text(right,
                        style: style ?? AppTextStyle.f_12_400.color333333),
                    haveCopy
                        ? GestureDetector(
                            onTap: () {
                              CopyUtil.copyText(right);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: Text(LocaleKeys.public6.tr,
                                  style: AppTextStyle.f_12_400.color0075FF),
                            ),
                          )
                        : const SizedBox()
                  ],
                )
              : CustomerPayview(colorKey: payKey, name: right)
        ],
      ),
    );
  }
}
