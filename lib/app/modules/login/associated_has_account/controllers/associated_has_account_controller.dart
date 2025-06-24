import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/third_login/third_login.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/captcha_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/dialog/warning_with_img_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssociatedHasAccountController extends GetxController {
  TextEditingController accountControll = TextEditingController();
  TextEditingController passwordControll = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  final isMobile = false.obs;
  final passwordBool = false.obs;

  final thirdLoginType = "".obs;
  final thirdLoginData = "".obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      thirdLoginType.value = Get.arguments['type'];
      thirdLoginData.value = Get.arguments['data'];
    }
    accountControll.addListener(() {
      var text = accountControll.text;
      if (text != '' && UtilRegExp.isNumeric(text)) {
        isMobile.value = true;
      } else {
        isMobile.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    accountControll.dispose();
    passwordControll.dispose();
    super.onClose();
  }

  Future loginAndBinding() async {
    if (isMobile.value && !UtilRegExp.phone(accountControll.text)) {
      return;
    }
    if (!isMobile.value && !UtilRegExp.email(accountControll.text)) {
      return;
    }
    // WarningTestDialog.show(
    //   title: "账户关联",
    //   content: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Text(
    //         "您已绑定此第三方账号 可直接登录",
    //         style: AppTextStyle.f_14_400.colorTextPrimary,
    //         textAlign: TextAlign.center,
    //       ),
    //       12.verticalSpace,
    //       Text(
    //         thirdLoginData.value.accountMask(),
    //         style: TextStyle(
    //           fontSize: 14.sp,
    //           fontWeight: FontWeight.w600,
    //           color: AppColor.colorAbnormal,
    //         ),
    //         textAlign: TextAlign.center,
    //       ),
    //     ],
    //   ),
    //   icon: 'default/third_fail'.svgAssets(),
    //   okTitle: LocaleKeys.trade219.tr,
    // );
    try {
      var res = await ThirdLoginApi.instance()
          .thirdIsAuth(thirdLoginType.value, thirdLoginData.value);
      if (res.isAuth == "true") {
        WarningWithImgDialog.show(
          title: LocaleKeys.user338.tr,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.user339.tr,
                style: AppTextStyle.f_14_400.colorTextPrimary,
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              Text(
                thirdLoginData.value.accountMask(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.colorAbnormal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          icon: 'default/third_fail'.svgAssets(),
          okTitle: LocaleKeys.trade219.tr,
          onOk: () {
            Get.untilNamed(Routes.LOGIN);
          },
        );
      } else {
        CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
          // 2 手机验证码 3 邮箱验证码
          var data = {
            ...result,
            'mobileNumber': accountControll.text,
            'loginPword': passwordControll.text,
          };
          if (isMobile.value) {
            data['countryCode'] = AreaGetx.to.areaCode;
          }

          if (thirdLoginType.value == "Google") {
            data['auth_type'] = thirdLoginType.value;
            data['email_auth'] = thirdLoginData.value;
          } else if (thirdLoginType.value == "Apple") {
            data['auth_type'] = thirdLoginType.value;
            data['email_auth'] = thirdLoginData.value;
          } else if (thirdLoginType.value == "Telegram") {
            data['auth_type'] = thirdLoginType.value;
            data['mobile_auth'] = thirdLoginData.value;
          }

          try {
            VerificationDataModel? res =
                await UserApi.instance().userloginin(data);
            if (res != null) {
              res.account = data['mobileNumber'];
              if (isMobile.value) {
                res.country = data['countryCode'];
              }
              Get.toNamed(Routes.LOGIN_VERIFICATION, arguments: {
                'verificatioData': res,
                "third_type": thirdLoginType.value,
                "third_data": thirdLoginData.value
              });
            }
            return res;
          } on DioException catch (e) {
            UIUtil.showError('${e.error}');
            update();
            return null;
          } catch (e) {
            AppLogUtil.e(e);
            return null;
          }
        });
      }
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
    } catch (e) {
      AppLogUtil.e(e);
    }
  }
}
