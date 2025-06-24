import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/my/settings/index/controllers/settings_index_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySettingsView extends GetView<MySettingsController> {
  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        child: Scaffold(
      appBar: AppBar(
          leading: const MyPageBackWidget(),
          centerTitle: true,
          title: Text(LocaleKeys.user194.tr,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          elevation: 0),
      body: Container(
          padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
          child: Column(
            children: [
              SizedBox(
                height: 10.w,
              ),
              GetBuilder<AssetsGetx>(builder: (assetsGetx) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppColor.colorWhite,
                  ),
                  child: universalListWidget(context, controller.entries),
                );
              }),
              Container(
                height: 1.h,
                color: AppColor.colorEEEEEE,
              ),
              universalListWidget(context, controller.entriesTwo),
            ],
          )),
    ));
  }
}
