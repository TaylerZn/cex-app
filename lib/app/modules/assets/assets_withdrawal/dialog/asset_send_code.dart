// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/captcha_Getx.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:styled_text/styled_text.dart';

class AssetSendCode extends StatefulWidget {
  // VerificationDataModel? verificatioData;
  var verificatioData;
  UserSafeVerificationEnum sendCodeType;
  var countryCode;
  var onTap;
  bool autoClick;
  bool isKeepleft;

  AssetSendCode(
      {required this.sendCodeType,
      this.verificatioData,
      this.onTap,
      this.countryCode,
      this.autoClick = false,
      this.isKeepleft = false});

  @override
  _AssetSendCodeState createState() => _AssetSendCodeState();
}

class _AssetSendCodeState extends State<AssetSendCode>
    with SingleTickerProviderStateMixin {
  int countDown = 0;
  Timer? resendTimer;
  bool clickCode = true;
  bool firstGetCode = true;

  @override
  void initState() {
    super.initState();
    if (widget.autoClick) {
      sendCode();
    }
  }

  //获取验证码
  sendCode() async {
    if (widget.onTap != null && widget.onTap() == true) {
      return;
    }

    if (clickCode) {
      clickCode = false;
      if (countDown == 0) {
        var res;
        switch (widget.sendCodeType) {
          case UserSafeVerificationEnum.MOBILE_LOGIN:
            var data = {
              'operationType': widget.sendCodeType.value,
              'token': widget.verificatioData?.token,
            };
            res = await commonsmsValidCode(data);
            setInitResendTimer(res);
            break;
          case UserSafeVerificationEnum.MOBILE_REGISTERED:
            var data = {
              'operationType': widget.sendCodeType.value,
              'mobile': widget.verificatioData?.account,
              'countryCode': widget.verificatioData?.country
            };
            res = await commonsmsValidCode(data);
            setInitResendTimer(res);
            break;
          case UserSafeVerificationEnum.MOBILE_BIND:
            CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
              var data = {
                ...result,
                'operationType': widget.sendCodeType.value,
                'mobile': widget.verificatioData?.account,
                'countryCode': widget.verificatioData?.country
              };
              res = await commonsmsValidCode(data);
              setInitResendTimer(res);
            });

            break;
          case UserSafeVerificationEnum.CHANGE_MOBILE_BIND:
          case UserSafeVerificationEnum.CLOSE_MOBILE_VERIFY:
          case UserSafeVerificationEnum.CHANGE_PWD:
          case UserSafeVerificationEnum.CLOSE_GOOGLE_VALID:
          case UserSafeVerificationEnum.EMAIL_BIND_MOBILE_VER:
          case UserSafeVerificationEnum.CHANGE_EMAIL_BIND_MOBILE_VER:
          case UserSafeVerificationEnum.MOBILE_CRYTO_WITHDRAW:
          case UserSafeVerificationEnum.MOBILE_DELETE_ACCOUNT:
            CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
              var data = {
                ...result,
                'operationType': widget.sendCodeType.value,
              };
              res = await commonsmsValidCode(data);
              setInitResendTimer(res);
            });
            break;
          case UserSafeVerificationEnum.MOBILE_FORGOT:
            var data = {
              'operationType': widget.sendCodeType.value,
              'mobile': widget.verificatioData?.account,
              'countryCode': widget.verificatioData?.country,
              'token': widget.verificatioData?.token,
            };
            res = await commonsmsValidCode(data);
            setInitResendTimer(res);
            break;

          case UserSafeVerificationEnum.EMAIL_CRYTO_WITHDRAW:
          case UserSafeVerificationEnum.EMAIL_DELETE_ACCOUNT:
            CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
              var data = {
                ...result,
                'operationType': widget.sendCodeType.value,
              };
              res = await commonemailValidCode(data);
              setInitResendTimer(res);
            });

            break;
          case UserSafeVerificationEnum.CHANGE_EMAIL_BIND:
            CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
              var data = {
                ...result,
                'operationType': widget.sendCodeType.value,
              };
              res = await commonemailValidCode(data);
              setInitResendTimer(res);
            });

            break;
          case UserSafeVerificationEnum.EMAIL_LOGIN:
            var data = {
              'operationType': widget.sendCodeType.value,
              'token': widget.verificatioData?.token
            };
            res = await commonemailValidCode(data);
            setInitResendTimer(res);
            break;
          case UserSafeVerificationEnum.EMAIL_REGISTERED:
            var data = {
              'operationType': widget.sendCodeType.value,
              'email': widget.verificatioData?.account,
            };
            res = await commonemailValidCode(data);
            setInitResendTimer(res);
            break;
          case UserSafeVerificationEnum.EMAIL_BIND:
            CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
              var data = {
                ...result,
                'operationType': widget.sendCodeType.value,
                'email': widget.verificatioData?.account,
              };
              res = await commonemailValidCode(data);
              setInitResendTimer(res);
            });
            break;
          case UserSafeVerificationEnum.EMAIL_FORGOT:
            var data = {
              'operationType': widget.sendCodeType.value,
              'email': widget.verificatioData?.account,
              'token': widget.verificatioData?.token
            };
            res = await commonemailValidCode(data);
            setInitResendTimer(res);
            break;
          default:
            UIUtil.showError('<Flutter> 请在MySendCode中配置');
        }
      }
    }
    clickCode = true;
  }

  setInitResendTimer(bool? res) {
    if (res == true) {
      initResendTimer();
    }
  }

  resetResendTimer() async {
    if (resendTimer != null) {
      resendTimer?.cancel();
      resendTimer = null;
    }
    countDown = 0;
  }

  initResendTimer() {
    firstGetCode = false;
    resetResendTimer();
    setState(() {
      countDown = 60;
    });
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countDown = 60 - timer.tick;
      });
      if (countDown <= 0) {
        setState(() {
          countDown = 0;
        });
        timer.cancel();
        resendTimer = null;
      }
    });
  }

  @override
  void dispose() {
    resetResendTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        sendCode();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            widget.isKeepleft ? MainAxisAlignment.start : MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          8.horizontalSpace,
          countDown != 0
              ? StyledText(
                  text: '${countDown}s <b>${LocaleKeys.public43.tr}</b>',
                  style: AppTextStyle.f_14_400.color333333,
                  tags: {
                    'b': StyledTextTag(
                      style: AppTextStyle.f_14_400.color999999,
                    ),
                  },
                )
              : Container(),
          countDown != 0
              ? Container()
              : Text(firstGetCode ? '发送' : LocaleKeys.public45.tr,
                  style: AppTextStyle.f_14_400
                      .copyWith(color: AppColor.tradingYel)),
        ],
      ),
    );
  }
}
