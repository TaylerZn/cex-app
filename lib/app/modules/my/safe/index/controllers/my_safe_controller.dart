import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/user.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/modules/my/widgets/Kyc_Info_Page.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySafeController extends GetxController {
  @override
  void onInit() {
    getUserrefresh();
    super.onInit();
  }

  getUserrefresh() async {
    await Get.find<UserGetx>().getRefresh();
  }

  List<MenuEntry> entriesOne(BuildContext context) {
    var userGetx = UserGetx.to;
    UserInfo? userInfo = userGetx.user?.info;
    return [
      MenuEntry(
        name: LocaleKeys.user156.tr,
        icon: '',
        behindName:
            userGetx.isSetMobile ? userGetx.mobile : LocaleKeys.user157.tr,
        showNewPoint: userGetx.isSetMobile ? false : true,
        behindNameColor:
            userGetx.isSetMobile ? AppColor.color111111 : AppColor.color999999,
        onTap: () {
          if (userGetx.isSetMobile) {
            Get.toNamed(Routes.MY_SAFE_MOBILE);
          } else {
            Get.toNamed(Routes.MY_SAFE_MOBILE_BIND);
          }
        },
      ),
      MenuEntry(
          name: LocaleKeys.user158.tr,
          icon: '',
          behindName:
              '${userGetx.isSetEmail ? userInfo?.email : LocaleKeys.user157.tr}',
          behindNameColor:
              userGetx.isSetEmail ? AppColor.color111111 : AppColor.color999999,
          showNewPoint: userGetx.isSetEmail ? false : true,
          onTap: () {
            if (userGetx.isSetEmail) {
              Get.toNamed(Routes.MY_SAFE_EMAIL);
            } else {
              Get.toNamed(Routes.MY_SAFE_EMAIL_BIND);
            }
          },
          bottomBorder: false),
    ];
  }

  List<MenuEntry> entriesTwo(BuildContext context) {
    var userGetx = UserGetx.to;
    return [
      MenuEntry(
        name: LocaleKeys.user29.tr,
        icon: '',
        behindName: '',
        onTap: () {
          if (userGetx.isGoogleVerify == false &&
              userGetx.isMobileVerify == false) {
            UIUtil.showToast(LocaleKeys.user159.tr);
          } else {
            Get.toNamed(Routes.MY_SAFE_PWD_CHANGE);
          }
        },
      ),
      MenuEntry(
          name: LocaleKeys.user160.tr,
          icon: '',
          behindName: UserAuditStatus.getTypeTitle(userGetx.getAuthStatus),
          behindNameColor: userGetx.getAuthStatus == UserAuditStatus.Success
              ? AppColor.color111111
              : AppColor.color999999,
          showNewPoint:
              userGetx.getAuthStatus == UserAuditStatus.Success ? false : true,
          showSelected:
              userGetx.getAuthStatus == UserAuditStatus.Success ? true : false,
          rightWidget: userGetx.getAuthStatus == UserAuditStatus.Reviewing
              ? Expanded(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 4.w),
                      child: MyImage(
                        'my/setting/kyc_loading'.pngAssets(),
                        width: 14.w,
                        height: 14.w,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        UserAuditStatus.getTypeTitle(userGetx.getAuthStatus),
                        style: AppTextStyle.f_12_500
                            .copyWith(height: 1.5, color: AppColor.color111111),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ))
              : null,
          onTap: () {
            if (userGetx.getAuthStatus == UserAuditStatus.noSubmit) {
              Get.toNamed(Routes.KYC_INDEX);
            } else {
              Get.to(KycInfoPage());
            }
          },
          bottomBorder: false),
      MenuEntry(
          name: LocaleKeys.user161.tr,
          icon: '',
          behindName: userGetx.isGoogleVerify
              ? LocaleKeys.user162.tr
              : LocaleKeys.user163.tr,
          behindNameColor: userGetx.isGoogleVerify
              ? AppColor.color111111
              : AppColor.color999999,
          showNewPoint: userGetx.isGoogleVerify ? false : true,
          showSelected: userGetx.isGoogleVerify ? true : false,
          onTap: () {
            Get.toNamed(Routes.MY_SAFE_GOOGLE);
          },
          bottomBorder: false),
      MenuEntry(
          name: LocaleKeys.user341.tr,
          icon: '',
          behindName: LocaleKeys.follow13.tr,
          behindNameColor: AppColor.color111111,
          showNewPoint: false,
          showSelected: false,
          onTap: () {
            Get.toNamed(Routes.THIRD_ACCOUNT);
          },
          bottomBorder: false),
    ];
  }

  List<MenuEntry> entriesThree(BuildContext context) {
    return [
      MenuEntry(
        name: LocaleKeys.user122.tr,
        icon: '',
        behindName: '',
        onTap: () {
          Get.toNamed(Routes.DEL_ACCOUNT);
        },
      ),
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
