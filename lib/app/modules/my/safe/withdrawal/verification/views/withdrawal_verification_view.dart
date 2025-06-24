import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/modules/my/safe/withdrawal/verification/controllers/withdrawal_verification_controller.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/send_code.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pinput/pinput.dart';

class MySafeWithdrawalVerificationView
    extends GetView<MySafeWithdrawalVerificationController> {
  const MySafeWithdrawalVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return GetBuilder<MySafeWithdrawalVerificationController>(
        builder: (controller) {
      return MySystemStateBar(
          child: Scaffold(
              appBar: AppBar(
                leading: const MyPageBackWidget(),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.w, horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.user11.tr,
                        style: TextStyle(
                            height: 1,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 14.w,
                      ),
                      Text(
                        '${Ver2FAEnum.getTypeName(int.parse(controller.verificatioData?.type as String))}',
                        style: TextStyle(
                            height: 1,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.colorABABAB),
                      ),
                      SizedBox(
                        height: 60.w,
                      ),
                      Pinput(
                          controller: controller.pinController,
                          length: 6,
                          defaultPinTheme: PinTheme(
                              width: 48.w,
                              height: 48.w,
                              decoration: BoxDecoration(
                                color: AppColor.colorF5F5F5,
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
                      SizedBox(
                        height: 20.w,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              LocaleKeys.user12.tr,
                              style: AppTextStyle.f_12_400.color0075FF,
                            ),
                          )),
                          Expanded(
                              child: controller.isGoogle == false
                                  ? MySendCode(
                                      sendCodeType: controller.type,
                                      verificatioData:
                                          controller.verificatioData,
                                      isKeepleft: false,
                                      autoClick: true,
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        var res =
                                            await CopyUtil.getText(amount: 6);
                                        controller.pinController.text = res;
                                        controller.update();
                                      },
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 60.w),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          LocaleKeys.public5.tr,
                                          style: TextStyle(
                                              color: AppColor.color0075FF,
                                              fontSize: 14.sp),
                                        ),
                                      ))),
                        ],
                      )
                    ],
                  ),
                ),
              )));
    });
    // });
  }
}
