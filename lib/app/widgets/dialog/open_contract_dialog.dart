import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

var _isShowing = false;

class OpenContractDialog extends StatefulWidget {
  const OpenContractDialog({super.key});

  static Future<bool?> showDialog() async {
    if (_isShowing) return null;
    _isShowing = true;
    return await Get.dialog<bool?>(const OpenContractDialog(),
        barrierDismissible: true);
  }

  @override
  State<OpenContractDialog> createState() => _OpenContractDialogState();
}

class _OpenContractDialogState extends State<OpenContractDialog> {
  bool _isChecked = false;

  @override
  void dispose() {
    super.dispose();
    _isShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(22.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.trade228.tr,
              style: TextStyle(
                color: AppColor.color111111,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            16.verticalSpace,
            Text(
              LocaleKeys.trade229.tr,
              style: TextStyle(
                color: AppColor.color666666,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            16.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                  },
                  child: Icon(
                    _isChecked
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank_rounded,
                    size: 16.sp,
                  ),
                ),
                4.horizontalSpace,
                Expanded(
                    child: RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: LocaleKeys.trade230.tr,
                    style: AppTextStyle.f_12_400,
                    children: <TextSpan>[
                      const TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                          text: '${LocaleKeys.trade231.tr} ',
                          style: AppTextStyle.f_12_400.copyWith(
                            color: AppColor.color0075FF,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(Routes.WEBVIEW, arguments: {
                                'url': LinksGetx.to.contractUsageAgreement
                              });
                            }),
                    ],
                  ),
                ))
              ],
            ),
            14.verticalSpace,
            MyButton(
              text: LocaleKeys.trade232.tr,
              height: 44.h,
              width: double.infinity,
              color: AppColor.colorWhite,
              backgroundColor:
                  _isChecked ? AppColor.colorBlack : AppColor.color999999,
              onTap: () async {
                if (!_isChecked) {
                  return;
                }
                Get.back(result: true);
                Get.toNamed(Routes.OPEN_CONTRACT);
              },
            )
          ],
        ),
      ),
    );
  }
}
