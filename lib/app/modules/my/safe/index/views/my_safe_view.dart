import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/my/safe/index/controllers/my_safe_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySafeView extends GetView<MySafeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySafeController>(builder: (controller) {
      return MySystemStateBar(
          color: SystemColor.white,
          child: Scaffold(
            appBar: AppBar(
                leading: const MyPageBackWidget(),
                centerTitle: true,
                title: Text(LocaleKeys.user164.tr,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w600)),
                elevation: 0),
            body: SafeArea(child: SingleChildScrollView(
                child: GetBuilder<UserGetx>(builder: (userGetx) {
              // // 构建UI时调用entriesOne方法
              // // 使用闭包，确保传递 BuildContext
              // Function(BuildContext) entriesBuilder =
              //     (ctx) => controller.entriesOne(ctx, userGetx);
              // Function(BuildContext) entriesTwoBuilder =
              //     (ctx) => controller.entriesTwo(ctx, userGetx);
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0),
                    decoration: BoxDecoration(
                        color: AppColor.colorFFFFFF,
                        borderRadius: BorderRadius.circular(6)),
                    child: universalListWidget(
                      context,
                      controller.entriesOne,
                      paddingHorizontal: 0,
                    ),
                  ),
                  Container(
                    height: 1,
                    color: AppColor.colorEEEEEE,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0),
                    decoration: BoxDecoration(
                        color: AppColor.colorFFFFFF,
                        borderRadius: BorderRadius.circular(6)),
                    child: universalListWidget(
                      context,
                      controller.entriesTwo,
                      paddingHorizontal: 0,
                    ),
                  ),
                  Container(
                    height: 1,
                    color: AppColor.colorEEEEEE,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0),
                    decoration: BoxDecoration(
                        color: AppColor.colorFFFFFF,
                        borderRadius: BorderRadius.circular(6)),
                    child: universalListWidget(
                      context,
                      controller.entriesThree,
                      paddingHorizontal: 0,
                    ),
                  ),
                ],
              );
            }))),
          ));
    });
  }

  //已登录
  Widget _UserLoginWidget(BuildContext context, UserGetx userGetx) {
    return Column(children: [
      InkWell(
          onTap: () {
            userGetx.goIsLogin();
          },
          child: SizedBox(
              height: 60.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                        color: AppColor.colorWhite,
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UserAvatar(
                          userGetx.avatar,
                          width: 60.w,
                          height: 60.w,
                          // memberType: userGetx.user?.info?.memberType,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                      child: InkWell(
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${userGetx.userName}'.stringSplit(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppColor.colorBlack,
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                            ),
                            InkWell(
                              onTap: () {
                                CopyUtil.copyText('${userGetx.user?.info?.id}');
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'UID：${userGetx.user?.info?.id ?? '--'}'
                                        .stringSplit(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColor.color999999,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                        SizedBox(
                          width: 8.w,
                        ),
                        MyImage(
                          'default/go'.svgAssets(),
                          width: 16.w,
                          color: AppColor.color111111,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ))
                ],
              ))),
      SizedBox(
        height: 15.w,
      ),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.colorF5F5F5),
          child: Stack(
            children: [
              Positioned(
                right: 62.w,
                bottom: -13.w,
                child: MyImage(
                  'my/user_kyc_bg'.svgAssets(),
                  width: 80.w,
                  height: 80.w,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.user106.tr.stringSplit(),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColor.colorBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              LocaleKeys.user107.tr.stringSplit(),
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColor.color999999,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      MyButton(
                        text: LocaleKeys.user108.tr,
                        textStyle: AppTextStyle.f_10_400,
                        padding: EdgeInsets.fromLTRB(10.w, 4.w, 10.w, 4.w),
                      )
                    ],
                  ))
            ],
          )),
      SizedBox(
        height: 20.w,
      ),
      Container(
        height: 1.w,
        color: AppColor.colorEEEEEE,
      )
    ]);
  }

  //已登录
  Widget _UserNoLoginWidget(BuildContext context, UserGetx userGetx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.user109.tr.stringSplit(),
          style: TextStyle(
              fontSize: 24.sp,
              color: AppColor.colorBlack,
              fontWeight: FontWeight.w700),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 18.w,
        ),
        MyButton.mainBg(
          text: LocaleKeys.user110.tr,
          width: 165.w,
          height: 42.w,
          fontSize: 14.sp,
          onTap: () {
            userGetx.goIsLogin();
          },
        ),
        SizedBox(
          height: 24.w,
        ),
        Container(
          height: 1.w,
          color: AppColor.colorEEEEEE,
        )
      ],
    );
  }
}
