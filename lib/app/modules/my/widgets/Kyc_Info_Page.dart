import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/user.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class KycInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return KycInfoPageState();
  }
}

class KycInfoPageState extends State<KycInfoPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(child: GetBuilder<UserGetx>(builder: (userGetx) {
      var audit = userGetx.getAuthStatus;
      var isError = UserAuditStatus.isError(audit);
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(
              24.w, 16.h, 24.w, 16.h + MediaQuery.of(context).padding.bottom),
          decoration: const BoxDecoration(
              color: AppColor.colorWhite,
              border: Border(
                  top: BorderSide(width: 1, color: AppColor.colorEEEEEE))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyButton(
                width: 327.w,
                height: 48.w,
                text: isError ? LocaleKeys.user210.tr : LocaleKeys.public1.tr,
                backgroundColor: AppColor.color111111,
                color: AppColor.colorWhite,
                goIcon: true,
                onTap: () {
                  Get.back();
                  if (isError) {
                    Get.toNamed(Routes.KYC_INDEX)?.then((value) async {
                      if (value == true) {
                        EasyLoading.show();
                        await Get.find<UserGetx>().getRefresh();
                        EasyLoading.dismiss();
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              height: 44.w,
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6.w, 8.w, 6.w, 8.w),
                      child: MyImage(
                        'default/close'.svgAssets(),
                        fit: BoxFit.fill,
                        width: 16.w,
                        height: 16.w,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            70.verticalSpace,
            MyImage(
              UserAuditStatus.getTypeImage(audit).pngAssets(),
              width: 84.w,
            ),
            20.verticalSpace,
            Text(
              UserAuditStatus.getTypeInfoTitle(audit),
              style: AppTextStyle.f_20_500,
            ),
            8.verticalSpace,
            Text(
              userGetx.user?.info?.notPassReason != null &&
                      userGetx.user?.info?.notPassReason != ''
                  ? userGetx.user?.info?.notPassReason ?? ''
                  : UserAuditStatus.getTypeInfoConnect(audit),
              style: AppTextStyle.f_12_400.color999999,
            ),
            const Spacer(),
          ],
        )),
      );
    }));
  }
}
