import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/email_bind_controller.dart';

class MySafeEmailBindView extends GetView<MySafeEmailBindController> {
  const MySafeEmailBindView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySafeEmailBindController>(builder: (controller) {
      return MySystemStateBar(
          child: Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(
              24.w, 16.w, 24.w, 16.h + MediaQuery.of(context).padding.bottom),
          decoration: const BoxDecoration(
              color: AppColor.colorWhite,
              border: Border(
                  top: BorderSide(width: 1, color: AppColor.colorECECEC))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                  height: 48.w,
                  text: LocaleKeys.public3.tr,
                  color: AppColor.colorWhite,
                  backgroundColor: controller.canNext()
                      ? AppColor.color111111
                      : AppColor.colorCCCCCC,
                  goIcon: true,
                  onTap: () async {
                    controller.onSubmit();
                  }),
            ],
          ),
        ),
        body: GetBuilder<AreaGetx>(builder: (areaGetx) {
          return Container(
            padding: EdgeInsets.all(24.w),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  UserGetx.to.isSetEmail
                      ? LocaleKeys.user135.tr
                      : LocaleKeys.user136.tr,
                  style: TextStyle(
                      height: 1, fontSize: 24.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 40.w,
                ),
                MyTextFieldWidget(
                  controller: controller.newEmail,
                  hintText: LocaleKeys.user137.tr,
                  title: LocaleKeys.user138.tr,
                  isTopText: false,
                ),
              ],
            )),
          );
        }),
      ));
    });
  }
}
