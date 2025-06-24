import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/enums/user.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/my/me/controllers/me_index_controller.dart';
import 'package:nt_app_flutter/app/modules/my/widgets/Kyc_Info_Page.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MeIndexView extends GetView<MeIndexController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MeIndexController>(builder: (controller) {
      return GetBuilder<UserGetx>(builder: (userGetx) {
        return MySystemStateBar(
            color: SystemColor.white,
            child: Scaffold(
              appBar: AppBar(
                leading: const MyPageBackWidget(),
              ),
              body: SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: true,
                enablePullUp: false,
                onRefresh: () async {
                  await userGetx.getRefresh(notify: true);
                  controller.refreshController.refreshToIdle();
                },
                onLoading: () async {
                  controller.refreshController.loadComplete();
                },
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.w),
                            userGetx.isLogin
                                ? _UserLoginWidget(context, userGetx)
                                : _UserNoLoginWidget(context, userGetx),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: universalListWidget(
                                    context, controller.entries,
                                    paddingHorizontal: 0.w)),
                            SizedBox(height: 40.h),
                            Get.find<UserGetx>().isLogin
                                ? Column(
                                    children: [
                                      MyButton(
                                        text: LocaleKeys.user99.tr,
                                        height: 48.h,
                                        backgroundColor: AppColor.colorEEEEEE,
                                        color: AppColor.color111111,
                                        onTap: () async {
                                          bool? res = await UIUtil.showConfirm(
                                            LocaleKeys.user99.tr,
                                            content: LocaleKeys.user100.tr,
                                          );
                                          if (res == true) {
                                            Get.find<UserGetx>()
                                                .signOut(isToast: false);
                                          }
                                        },
                                      ),
                                      SizedBox(height: 30.h),
                                    ],
                                  )
                                : Container(),
                          ])),
                ),
              ),
            ));
      });
    });
  }

  //已登录
  Widget _UserLoginWidget(BuildContext context, UserGetx userGetx) {
    return Column(children: [
      InkWell(
          onTap: () {
            Get.toNamed(Routes.MY_SETTINGS_USER);
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
                          isTrader: userGetx.isKol,
                          tradeIconSize: 20.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
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
                          SizedBox(
                            height: 4.w,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: InkWell(
                                      onTap: () {
                                        CopyUtil.copyText(
                                            '${userGetx.user?.info?.id}');
                                        print(userGetx.user?.token);
                                      },
                                      child: Text(
                                        'UID：${userGetx.user?.info?.id ?? '--'}'
                                            .stringSplit(),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColor.color999999,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                            ],
                          ),
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
                  ))
                ],
              ))),
      Container(
          margin: EdgeInsets.only(top: 2.w),
          child: Row(
            children: [
              SizedBox(
                width: 70.w,
              ),
              MyButton(
                text: () {
                  if (userGetx.getAuthStatus == UserAuditStatus.noSubmit) {
                    return LocaleKeys.user103.tr;
                  } else if (userGetx.getAuthStatus ==
                      UserAuditStatus.Reviewing) {
                    return LocaleKeys.user102.tr;
                  } else if (userGetx.getAuthStatus ==
                      UserAuditStatus.Success) {
                    return LocaleKeys.user101.tr;
                  } else {
                    return LocaleKeys.user103.tr;
                  }
                }(),
                height: 20.h,
                textStyle: AppTextStyle.f_10_500,
                color: userGetx.getAuthStatus == UserAuditStatus.Success
                    ? AppColor.colorSuccess
                    : AppColor.colorABABAB,
                borderRadius: BorderRadius.circular(4),
                backgroundColor: AppColor.colorWhite,
                border: Border.all(
                    width: 1.w,
                    color: userGetx.getAuthStatus == UserAuditStatus.Success
                        ? AppColor.colorSuccess
                        : AppColor.colorDCDCDC),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                onTap: () {
                  if (userGetx.getAuthStatus == UserAuditStatus.noSubmit) {
                    Get.toNamed(Routes.KYC_INDEX);
                  } else if (userGetx.getAuthStatus ==
                      UserAuditStatus.Reviewing) {
                    Get.to(KycInfoPage());
                  } else if (userGetx.getAuthStatus ==
                      UserAuditStatus.Success) {
                    Get.to(KycInfoPage());
                  } else {
                    Get.to(KycInfoPage());
                  }
                },
              ).marginOnly(right: 6.w),
              MyButton(
                text: userGetx.isKol
                    ? LocaleKeys.user104.tr
                    : LocaleKeys.user105.tr,
                height: 20.h,
                color:
                    userGetx.isKol ? AppColor.mainColor : AppColor.colorD7A800,
                textStyle: AppTextStyle.f_10_500,
                backgroundColor: userGetx.isKol
                    ? AppColor.colorWhite
                    : AppColor.colorFFD429.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4.r),
                border: userGetx.isKol
                    ? Border.all(width: 1.w, color: AppColor.mainColor)
                    : null,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
              )
            ],
          )),
      userGetx.getAuthStatus == UserAuditStatus.noSubmit ||
              userGetx.getAuthStatus == UserAuditStatus.Error
          ? InkWell(
              onTap: () {
                if (userGetx.getAuthStatus == UserAuditStatus.noSubmit) {
                  Get.toNamed(Routes.KYC_INDEX);
                } else {
                  Get.to(KycInfoPage());
                }
              },
              child: Container(
                  margin: EdgeInsets.only(top: 15.w),
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
                                      style: AppTextStyle.f_16_600.color111111,
                                    ),
                                    SizedBox(
                                      height: 6.w,
                                    ),
                                    Text(
                                      LocaleKeys.user107.tr.stringSplit(),
                                      style:
                                          AppTextStyle.f_11_400.color999999,
                                    ),
                                  ],
                                ),
                              ),
                              //阻止子级点击事件
                              AbsorbPointer(
                                  absorbing: true,
                                  child: MyButton(
                                      text: LocaleKeys.user108.tr,
                                      height: 24.w,
                                      textStyle: AppTextStyle.f_10_500,
                                      color: AppColor.colorWhite,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w)))
                            ],
                          ))
                    ],
                  )),
            )
          : const SizedBox(),
      SizedBox(
        height: 20.h,
      ),
      Container(
        height: 1.w,
        color: AppColor.colorEEEEEE,
      ),
      SizedBox(
        height: 20.h,
      ),
      Row(
        children: [
          meBoxWidget('my/t_deposit', LocaleKeys.assets35.tr, () {
            Get.toNamed(Routes.CURRENCY_SELECT,
                arguments: {'type': AssetsCurrencySelectEnumn.depoit});
          }),
          Spacer(),

          meBoxWidget('my/t_follow', LocaleKeys.follow17.tr, () {
            Get.untilNamed(Routes.MAIN_TAB);
            MainTabController.to.changeTabIndex(3);
          }),
          Spacer(),

          meBoxWidget('my/t_assets_management', LocaleKeys.user296.tr, () {
            Get.toNamed(Routes.COUPONS_INDEX);
          }),
          // meBoxWidget('my/t_otc', 'OTC', () {})
        ],
      ).marginOnly(bottom: 20.h, left: 25.w, right: 25.w),
      Container(
        height: 1.w,
        color: AppColor.colorEEEEEE,
      ),
    ]);
  }

  //已登录
  Widget _UserNoLoginWidget(BuildContext context, UserGetx userGetx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.user25.tr.stringSplit(),
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

  meBoxWidget(String image, String title, GestureTapCallback? onTap) {
    return Expanded(
        child: InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Column(
        children: [
          Container(
              width: 54.w,
              height: 54.w,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                ),
              ),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyImage(
                      image.svgAssets(),
                      width: 24.w,
                      height: 24.w,
                    ),
                  ])),
          SizedBox(
            height: 16.h,
          ),
          Text(
            title,
            style: TextStyle(height: 1, fontSize: 12.sp),
          )
        ],
      ),
    ));
  }
}
