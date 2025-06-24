import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/login/registered_verification/controllers/login_registered_verification_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/send_code.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pinput/pinput.dart';

class LoginRegisteredVerificationView
    extends GetView<LoginRegisteredVerificationController> {
  const LoginRegisteredVerificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return MySystemStateBar(
        child: Scaffold(
            appBar: AppBar(
              leading: const MyPageBackWidget(),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.isGoogle
                          ? LocaleKeys.user31.tr
                          : LocaleKeys.user32.tr,
                      style: TextStyle(
                          height: 1,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 14.w,
                    ),
                    controller.isGoogle
                        ? const SizedBox()
                        : RichText(
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: '${LocaleKeys.user33.tr} ',
                              style: TextStyle(
                                  color: AppColor.colorABABAB, fontSize: 12.sp),
                              children: <TextSpan>[
                                TextSpan(
                                    text: (controller
                                                .verificatioData?.showAccount ??
                                            '')
                                        .accountMask(),
                                    style: TextStyle(
                                      color: AppColor
                                          .colorBlack, //Color(0xff0075FF),
                                      fontSize: 12.sp,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 30.w,
                    ),
                    Pinput(
                        controller: controller.pinController,
                        length: 6,
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
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) {
                          controller.onSubmit(pin);
                        }),
                    SizedBox(
                      height: 20.w,
                    ),
                    Row(
                      children: [
                        controller.isGoogle == false
                            ? MySendCode(
                                sendCodeType: controller.type,
                                verificatioData: controller.verificatioData,
                                isKeepleft: true,
                                autoClick: true,
                              )
                            : const SizedBox(),
                        const Expanded(child: SizedBox()),
                        InkWell(
                            onTap: () async {
                              var res = await await CopyUtil.getText(amount: 6);
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
                    )
                  ],
                ),
              ),
            )));
    // });
  }
}
