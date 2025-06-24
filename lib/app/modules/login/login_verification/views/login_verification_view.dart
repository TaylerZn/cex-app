import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/modules/login/login_verification/controllers/login_verification_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/app/widgets/components/send_code.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pinput/pinput.dart';

class LoginVerificationView extends GetView<LoginVerificationController> {
  const LoginVerificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        child: Scaffold(
            appBar: AppBar(
              leading: const MyPageBackWidget(),
            ),
            body: GetBuilder<LoginVerificationController>(
                builder: (assetsController) {
              return SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.w, horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.user11.tr,
                        style: AppTextStyle.f_24_600,
                      ),
                      8.verticalSpace,
                      Text(
                        controller.currentType.name,
                        style: AppTextStyle.f_12_500.color999999,
                      ),
                      40.verticalSpace,
                      controller.verficList.length > 1
                          ? Row(
                              children: [
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    controller.changeCurrentType();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        LocaleKeys.user12.tr,
                                        style:
                                            AppTextStyle.f_12_400.color999999,
                                        textAlign: TextAlign.right,
                                      ),
                                      MyImage(
                                        'default/go'.svgAssets(),
                                        width: 10.w,
                                        color: AppColor.color999999,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          : 0.verticalSpace,
                      SizedBox(
                        height: 16.h,
                      ),
                      Pinput(
                          controller: controller.pinController,
                          length: 6,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          defaultPinTheme: PinTheme(
                              width: 48.w,
                              height: 48.w,
                              decoration: BoxDecoration(
                                color: AppColor.colorF5F5F5, // 默认背景颜色
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle:
                                  AppTextStyle.f_20_600.copyWith(height: 1.2)),
                          focusedPinTheme: PinTheme(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: AppColor.colorF5F5F5,
                              border: Border.all(
                                  color: AppColor.color111111), // 默认边框颜色
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          separatorBuilder: (index) {
                            return SizedBox(
                              width: 6.w,
                            );
                          },
                          autofocus: true,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) {
                            controller.onSubmit(pin);
                          }),
                      8.verticalSpace,
                      SizedBox(
                          height: 22.h,
                          child: Row(
                            children: [
                              Expanded(
                                child: PageView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    controller: controller.pageController,
                                    children: [
                                      const SizedBox(),
                                      KeepAliveWrapper(
                                          child: MySendCode(
                                        sendCodeType: UserSafeVerificationEnum
                                            .MOBILE_LOGIN,
                                        verificatioData:
                                            controller.verificatioData,
                                        isKeepleft: true,
                                        autoClick: true,
                                      )),
                                      KeepAliveWrapper(
                                          child: MySendCode(
                                        sendCodeType: UserSafeVerificationEnum
                                            .EMAIL_LOGIN,
                                        verificatioData:
                                            controller.verificatioData,
                                        isKeepleft: true,
                                        autoClick: true,
                                      )),
                                    ]),
                              ),
                              const Spacer(),
                              InkWell(
                                  onTap: () async {
                                    var res = await CopyUtil.getText(amount: 6);
                                    controller.pinController.text = res;
                                    controller.update();
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 60.w),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      LocaleKeys.public5.tr,
                                      style: TextStyle(
                                          color: AppColor.color0075FF,
                                          fontSize: 14.sp),
                                    ),
                                  )),
                            ],
                          ))
                    ],
                  ),
                ),
              );
            })));
  }
}
