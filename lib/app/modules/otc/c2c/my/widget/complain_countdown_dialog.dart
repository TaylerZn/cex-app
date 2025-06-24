import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ComplainCountDownDialog extends StatefulWidget {
  final int seconds;
  final String complainId;
  final Function goToCustomer;

  const ComplainCountDownDialog(
      {super.key,
      required this.seconds,
      required this.complainId,
      required this.goToCustomer});

  @override
  State<ComplainCountDownDialog> createState() =>
      _ComplainCountDownDialogState();
}

class _ComplainCountDownDialogState extends State<ComplainCountDownDialog> {
  Timer? timer;
  int counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counter = widget.seconds;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (counter <= 0) {
        timer.cancel();
      }
      setState(() {
        --counter;
      });
    });
  }

  String formatDuration() {
    String twoDigitsDuration(int number) {
      return number.toString().padLeft(2, '0');
    }

    var duration = Duration(seconds: counter);
    var twoDigits = twoDigitsDuration;
    return '${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds % 60)}';
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 268.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          color: AppColor.colorWhite),
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.c2c62.tr, style: AppTextStyle.f_16_500),
          7.h.verticalSpace,
          Text(LocaleKeys.c2c115.tr, style: AppTextStyle.f_12_400.color666666),
          28.h.verticalSpace,
          MyButton(
              text: LocaleKeys.c2c117.tr,
              color: AppColor.colorWhite,
              height: 48.h,
              onTap: () async {
                Get.back();
              }),
          Visibility(
              visible: counter <= 0,
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                child: MyButton(
                    text: LocaleKeys.c2c116.tr,
                    backgroundColor: AppColor.colorFFFFFF,
                    border: Border.all(),
                    color: AppColor.color0C0D0F,
                    height: 48.h,
                    onTap: () async {
                      Get.back();
                      widget.goToCustomer.call();
                    }),
              )),
          10.h.verticalSpace,
          Visibility(
              visible: counter > 0,
              child: Text('${LocaleKeys.c2c116.tr} ${formatDuration()}',
                  style: AppTextStyle.f_14_500.color666666))
        ],
      ),
    ));
  }
}
