import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import '../controllers/http_overrides_controller.dart';

class SetHttpOverridesView extends GetView<SetHttpOverridesController> {
  const SetHttpOverridesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetHttpOverridesController>(builder: (controller) {
      return MySystemStateBar(
          child: Scaffold(
        appBar: AppBar(leading: const MyPageBackWidget(), elevation: 0),
        bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(
                24.w, 16.w, 24.w, 16.w + MediaQuery.of(context).padding.bottom),
            color: AppColor.colorWhite,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              MyButton(
                width: 315.w,
                height: 48.w,
                text: '确定',
                goIcon: true,
                onTap: () async {
                  controller.onSubmit(context);
                },
              )
            ])),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 16.w, 30.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '设置代理',
                    style: TextStyle(
                        height: 1,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16.w,
                  ),
                  Text(
                    '当前代理地址：${StringKV.httpLocalhost.get() ?? '--'}',
                    style: TextStyle(
                        height: 1,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.colorABABAB),
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  MyTextFieldWidget(
                    controller: controller.localhostController,
                    hintText: '代理地址',
                    inputFormatters: [],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                ],
              ),
            ),
          ],
        )),
      ));
    });
  }
}
