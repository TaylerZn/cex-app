import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/mobile_index_controller.dart';

class MySafeMobileView extends GetView<MySafeMobileController> {
  const MySafeMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserGetx>(builder: (userGetx) {
      return GetBuilder<MySafeMobileController>(builder: (controller) {
        return MySystemStateBar(
            child: Scaffold(
          appBar: AppBar(
            leading: const MyPageBackWidget(),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.fromLTRB(24.w, 0.w, 24.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.w,
                ),
                Text(
                  LocaleKeys.user172.tr,
                  style: TextStyle(
                      height: 1, fontSize: 24.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 40.w,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        UserGetx.to.mobile,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () async {
                              controller.onEdit();
                            },
                            child: Container(
                                padding: EdgeInsets.only(left: 10.w),
                                child: MyImage(
                                  'my/safe_edit'.svgAssets(),
                                  width: 16.w,
                                  height: 16.w,
                                )))
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  height: 1.w,
                  color: AppColor.colorEEEEEE,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.user173.tr,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    FlutterSwitch(
                      width: 37.w,
                      height: 20.w,
                      toggleSize: 16.w,
                      value: userGetx.isMobileVerify,
                      borderRadius: 30.0,
                      padding: 2.w,
                      activeColor: AppColor.mainColor,
                      inactiveColor: AppColor.colorDDDDDD,
                      onToggle: (val) {
                        controller.changemobileverify();
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
        ));
      });
    });
  }
}
