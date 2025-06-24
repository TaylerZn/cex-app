import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/modules/my/safe/withdrawal/index/controllers/withdrawal_index_controller.dart';
import 'package:nt_app_flutter/app/modules/my/safe/withdrawal/index/views/withdrawal_index_view.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/components/send_code.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class SafeGetx extends GetxController with StateMixin {
  static SafeGetx get to => Get.find();

  TextEditingController newMobileCode = TextEditingController();
  TextEditingController newEmailCode = TextEditingController();
  TextEditingController emailCode = TextEditingController();
  TextEditingController smsCode = TextEditingController();
  TextEditingController googleCode = TextEditingController();

  /// 初始化
  @override
  void onInit() {
    getmarketusergetgoogleqrcode();
    super.onInit();
  }

//获取信息
  getmarketusergetgoogleqrcode() async {
    if (UserGetx.to.isLogin) {
      // var res = await marketusergetgoogleqrcode();
      // if (res != null) {
      //   googleData = res;
      //   update();
      // }
    }
  }

  cleanTextController() {
    newMobileCode.text = '';
    newEmailCode.text = '';
    emailCode.text = '';
    smsCode.text = '';
    googleCode.text = '';
  }

  //操作安全拦截
  goIsSafe({
    bool isWithdrawal = false,
    onTap,
    SafeGoModel? newMobileVerific,
    SafeGoModel? newEmailVerific,
    SafeGoModel? emailVerific,
    SafeGoModel? mobileVerific,
  }) async {
    bool googleVerific = false;
    UserGetx userGetx = UserGetx.to;
    // 提现2FA
    if (isWithdrawal) {
      var data = await showMyBottomDialog(
          Get.context, const MySafeWithdrawalView(),
          padding: EdgeInsets.fromLTRB(24.w, 34.h, 24.w, 16.h),
          isDismissible: false);
      Get.delete<MySafeWithdrawalController>();
      if (data != null) {
        onTap(data);
      }
    } else {
      if (userGetx.isGoogleVerify) {
        googleVerific = true;
      }
      showMyBottomDialog(
          Get.context,
          padding: EdgeInsets.fromLTRB(0.w, 19.h, 0.w, 0),
          _bottomSafeGoWidget(
            status,
            onTap,
            newMobileVerific: newMobileVerific,
            newEmailVerific: newEmailVerific,
            emailVerific: emailVerific,
            mobileVerific: mobileVerific,
            googleVerific: googleVerific,
          ),
          isDismissible: false);
      return;
    }
  }

  Widget _bottomSafeGoWidget(
    type,
    onTap, {
    SafeGoModel? newMobileVerific,
    SafeGoModel? newEmailVerific,
    SafeGoModel? emailVerific,
    SafeGoModel? mobileVerific,
    bool googleVerific = false,
  }) {
    return GetBuilder<SafeGetx>(builder: (assetsController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.user11.tr,
                    style: AppTextStyle.f_20_600,
                  ),
                  25.verticalSpace,
                  newMobileVerific != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextFieldWidget(
                              controller: newMobileCode,
                              hintText: LocaleKeys.user247.tr,
                              title: LocaleKeys.user253.tr,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              isTopText: false,
                              suffixIcon: MySendCode(
                                sendCodeType: newMobileVerific.type,
                                verificatioData:
                                    newMobileVerific.verificatioData,
                              ),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            verificsendtoWidget(
                                newMobileVerific.verificatioData),
                            SizedBox(
                              height: 30.w,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  newEmailVerific != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              MyTextFieldWidget(
                                controller: newEmailCode,
                                hintText: LocaleKeys.user248.tr,
                                title: LocaleKeys.user252.tr,
                                isTopText: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                suffixIcon: MySendCode(
                                  sendCodeType: newEmailVerific.type,
                                  verificatioData:
                                      newEmailVerific.verificatioData,
                                ),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              verificsendtoWidget(
                                  newEmailVerific.verificatioData),
                              SizedBox(
                                height: 30.w,
                              ),
                            ])
                      : const SizedBox(),
                  emailVerific != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              MyTextFieldWidget(
                                controller: emailCode,
                                hintText: LocaleKeys.user249.tr,
                                title: LocaleKeys.user244.tr,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                isTopText: false,
                                suffixIcon: MySendCode(
                                  sendCodeType: emailVerific.type,
                                  verificatioData: emailVerific.verificatioData,
                                ),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              verificsendtoWidget(emailVerific.verificatioData),
                              SizedBox(
                                height: 30.w,
                              ),
                            ])
                      : const SizedBox(),
                  mobileVerific != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              MyTextFieldWidget(
                                controller: smsCode,
                                hintText: LocaleKeys.user250.tr,
                                title: LocaleKeys.user246.tr,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                isTopText: false,
                                suffixIcon: MySendCode(
                                  sendCodeType: mobileVerific.type,
                                  verificatioData:
                                      mobileVerific.verificatioData,
                                ),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              verificsendtoWidget(
                                  mobileVerific.verificatioData),
                              SizedBox(
                                height: 30.w,
                              ),
                            ])
                      : const SizedBox(),
                  googleVerific == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              MyTextFieldWidget(
                                controller: googleCode,
                                hintText: LocaleKeys.user251.tr,
                                title: LocaleKeys.user245.tr,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                isTopText: false,
                                suffixIcon: InkWell(
                                    onTap: () async {
                                      var res =
                                          await CopyUtil.getText(amount: 6);
                                      googleCode.text = res;
                                      update();
                                    },
                                    child: Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 70.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      alignment: Alignment.center,
                                      child: Text(
                                        LocaleKeys.public5.tr,
                                        style: TextStyle(
                                            color: AppColor.color0075FF,
                                            fontSize: 14.sp),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                            ])
                      : const SizedBox(),
                ],
              )),
          Container(
              padding: EdgeInsets.all(16.w),
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: AppColor.colorECECEC))),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton.borderWhiteBg(
                      height: 48.w,
                      text: LocaleKeys.public2.tr,
                      onTap: () {
                        cleanTextController();
                        Get.back();
                      },
                    ),
                  ),
                  7.horizontalSpace,
                  Expanded(
                      child: MyButton(
                    height: 48.w,
                    text: LocaleKeys.public1.tr,
                    onTap: () async {
                      var data = {};

                      if (newMobileVerific != null) {
                        if (newMobileCode.text.isEmpty) {
                          UIUtil.showToast(
                            LocaleKeys.user247.tr,
                          );
                          return;
                        }
                        data.addAll({'smsNewCode': newMobileCode.text});
                      }
                      if (newEmailVerific != null) {
                        if (newEmailCode.text.isEmpty) {
                          UIUtil.showToast(
                            LocaleKeys.user248.tr,
                          );
                          return;
                        }
                        data.addAll({'emailNewCode': newEmailCode.text});
                      }
                      if (emailVerific != null) {
                        if (emailCode.text.isEmpty) {
                          UIUtil.showToast(LocaleKeys.user249.tr);
                          return;
                        }
                        data.addAll({'emailCode': emailCode.text});
                        // var res = emailVerific.verificatioData.toJson();
                        // data.addAll(res);
                      }
                      if (mobileVerific != null) {
                        if (smsCode.text.isEmpty) {
                          UIUtil.showToast(LocaleKeys.user250.tr);
                          return;
                        }

                        data.addAll({'smsCode': smsCode.text});
                      }
                      if (googleVerific == true) {
                        if (googleCode.text.isEmpty) {
                          UIUtil.showToast(LocaleKeys.user251.tr);
                          return;
                        }
                        data.addAll({'googleCode': googleCode.text});
                      }
                      cleanTextController();
                      Get.back();
                      onTap(data);
                    },
                  )),
                ],
              )),
        ],
      );
    });
  }

  Widget verificsendtoWidget(VerificationDataModel? verificatioData) {
    return verificatioData != null
        ? RichText(
            overflow: TextOverflow.clip,
            text: TextSpan(
              text: '${LocaleKeys.user33.tr} ',
              style: AppTextStyle.f_11_400.colorABABAB,
              children: <TextSpan>[
                TextSpan(
                  text: verificatioData.isMask
                      ? '${verificatioData.country ?? ''} ${verificatioData.showAccount ?? ''}'
                          .accountMask()
                      : '${verificatioData.country ?? ''} ${verificatioData.showAccount ?? ''}',
                  style: AppTextStyle.f_11_400,
                ),
              ],
            ),
          )
        : 0.verticalSpace;
  }

  /// 加载完成
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// 控制器被释放
  @override
  void onClose() {
    newMobileCode.dispose();
    newEmailCode.dispose();
    emailCode.dispose();
    smsCode.dispose();
    googleCode.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
