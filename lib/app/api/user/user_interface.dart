import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_log_event_name.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_manager.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/dialog/warning_with_img_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../utils/fcm/fcm_utils.dart';

// 验证码确认登录
userconfirmlogin(data) async {
  try {
    var res = await UserApi.instance().userconfirmlogin(data);
    AppsFlyerManager().logEvent(AFLogEventName.login);
    res['token'] = data['token'];
    User user = User.fromJson(res);
    if ((data as Map).containsKey("third_type") &&
        data.containsKey("third_data")) {
      WarningWithImgDialog.show(
        title: LocaleKeys.user338.tr,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.user340.trArgs(['${data['third_type']}']),
              style: AppTextStyle.f_14_400.colorTextPrimary,
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            Text(
              (data['third_data'] as String).accountMask(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.colorAbnormal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        icon: 'default/third_succ'.svgAssets(),
        okTitle: LocaleKeys.trade219.tr,
        onOk: () {
          Get.find<UserGetx>().login(user);
        },
      );
    } else {
      Get.find<UserGetx>().login(user);
    }
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户登出
userloginout() async {
  try {
    await FcmUtils.updateToken('');
    await UserApi.instance().userloginout();
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

// 获取用户信息
commonuserinfo() async {
  try {
    var res = await UserApi.instance().commonuserinfo();
    print(res);
    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    UIUtil.showError('${e.error}');
    return null;
  }
}

// 发送验证码
commonsmsValidCode(data) async {
  try {
    var res = await UserApi.instance().commonsmsValidCode(data);
    UIUtil.showSuccess(LocaleKeys.user256.tr);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

// 发送邮箱验证码
commonemailValidCode(data) async {
  try {
    var res = await UserApi.instance().commonemailValidCode(data);
    print(res);
    UIUtil.showSuccess(LocaleKeys.user256.tr);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

// 用户注册账户(第一步)
userregisterOne(data) async {
  try {
    await UserApi.instance().userregisterOne(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

// 用户注册账户(第二步)
userregisterTwo(data) async {
  try {
    var res = await UserApi.instance().userregisterTwo(data);
    return res;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return null;
  }
}

// 用户注册账户(第三步)
userregisterThree(data) async {
  try {
    var res = await UserApi.instance().userregisterThree(data);
    User user = User.fromJson(res);
    AppsFlyerManager().logEvent(AFLogEventName.registration);
    Get.find<UserGetx>().login(user);
    return res;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return null;
  }
}

// 忘记密码（第一步）
resetpasswordstepone(data) async {
  try {
    var res = await UserApi.instance().resetpasswordstepone(data);
    return res;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return null;
  }
}

// 忘记密码(第二步)
resetpasswordsteptwo(data) async {
  try {
    await UserApi.instance().resetpasswordsteptwo(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

// 忘记密码(第三步)
resetpasswordstepthree(data) async {
  try {
    await UserApi.instance().resetpasswordstepthree(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//修改昵称
usernicknameupdate(data) async {
  try {
    await UserApi.instance().usernicknameupdate(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户实名认证
userv4authrealname(data) async {
  try {
    await UserApi.instance().userv4authrealname(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户开启google认证
usertoopegoogleauthenticator(data) async {
  try {
    var res = await UserApi.instance().usertoopegoogleauthenticator(data);
    return res;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return null;
  }
}

//验证google验证码
usergoogleverify(data) async {
  try {
    await UserApi.instance().usergoogleverify(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户关闭Google认证
userclosegoogleverify(data) async {
  try {
    await UserApi.instance().userclosegoogleverify(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户绑定手机号
usermobilebindsave(data) async {
  try {
    await UserApi.instance().usermobilebindsave(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户更新手机号
usermobileupdate(data) async {
  try {
    await UserApi.instance().usermobileupdate(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户绑定邮箱
useremailbindsave(data) async {
  try {
    await UserApi.instance().useremailbindsave(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户修改手机号
useremailupdate(data) async {
  try {
    await UserApi.instance().useremailupdate(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户关闭手机认证
userclosemobileverify(data) async {
  try {
    await UserApi.instance().userclosemobileverify(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户打开手机认证
useropenmobileverify() async {
  try {
    await UserApi.instance().useropenmobileverify();
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}

//用户密码更新
userpasswordupdate(data) async {
  try {
    await UserApi.instance().userpasswordupdate(data);
    return true;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    return false;
  }
}
