import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/my_settings_user_controller.dart';

class MySettingsUserView extends GetView<MySettingsUserController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySettingsUserController>(builder: (controller) {
      return MySystemStateBar(
        child: Scaffold(
            appBar: AppBar(
                leading: const MyPageBackWidget(),
                centerTitle: true,
                title: Text(LocaleKeys.user209.tr,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w600)),
                elevation: 0),
            body: SafeArea(
              child: GetBuilder<UserGetx>(
                // init: counter,
                builder: (userGetx) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: universalListWidget(context, controller.entries),
                      ),
                      Container(
                        height: 1.h,
                        color: AppColor.colorEEEEEE,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child:
                            universalListWidget(context, controller.entriesTwo),
                      ),
                    ],
                  ));
                },
              ),
            )),
      );
    });
  }
}
