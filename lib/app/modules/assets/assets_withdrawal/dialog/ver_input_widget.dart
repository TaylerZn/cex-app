import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../enums/safe.dart';
import '../../../../models/user/res/user.dart';
import 'asset_send_code.dart';

class VerifInputWidget extends StatefulWidget {
  final Function(String) onChanged;
  final UserSafeVerificationEnum type;

  const VerifInputWidget(
      {super.key, required this.type, required this.onChanged});

  @override
  State<VerifInputWidget> createState() => _VerifInputWidgetState();
}

class _VerifInputWidgetState extends State<VerifInputWidget> {
  String buildTitle() {
    switch (widget.type) {
      case UserSafeVerificationEnum.EMAIL_CRYTO_WITHDRAW:
        return LocaleKeys.user132.tr;
      case UserSafeVerificationEnum.MOBILE_CRYTO_WITHDRAW:
        return LocaleKeys.assets192.tr;
      default:
        return LocaleKeys.assets193.tr;
    }
  }

  String hint() {
    switch (widget.type) {
      case UserSafeVerificationEnum.EMAIL_CRYTO_WITHDRAW:
        return LocaleKeys.user249.tr;
      case UserSafeVerificationEnum.MOBILE_CRYTO_WITHDRAW:
        return LocaleKeys.assets194.tr;
      default:
        return LocaleKeys.user251.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(buildTitle(), style: AppTextStyle.f_13_500.color4D4D4D),
        8.verticalSpaceFromWidth,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              color: AppColor.colorBackgroundSecondary),
          padding: EdgeInsets.only(right: 13.w),
          child: Row(
            children: [
              Expanded(
                  child: MyTextFieldWidget(
                hintText: hint(),
                hintStyle: AppTextStyle.f_14_500.colorABABAB,
                onChanged: widget.onChanged,
                isTopText: false,
                focusedBorderColor: Colors.transparent,
                enabledBorderColor: Colors.transparent,
              )),
              Visibility(
                  visible: widget.type !=
                      UserSafeVerificationEnum.CLOSE_GOOGLE_VALID,
                  child: AssetSendCode(
                    sendCodeType: UserSafeVerificationEnum.EMAIL_CRYTO_WITHDRAW,
                    verificatioData: VerificationDataModel()
                      ..showAccount = UserGetx.to.user?.info?.email ?? '',
                  ))
            ],
          ),
        )
      ],
    );
  }
}
