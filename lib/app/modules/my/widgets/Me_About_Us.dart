import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/package_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/app/widgets/dialog/app_update_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:url_launcher/url_launcher.dart';

class MeAboutUs extends StatefulWidget {
  @override
  _MeAboutUsState createState() => _MeAboutUsState();
}

class _MeAboutUsState extends State<MeAboutUs>
    with SingleTickerProviderStateMixin {
  String? language;
  int? selectedValue;
  Map<String, dynamic>? checkUpdateResponse;
  List<MenuEntry> _entries(BuildContext context) {
    return [
      MenuEntry(
        name: 'Twitter',
        icon: 'my/setting/share_twitter'.svgAssets(),
        iconSize: 20.w,
        onTap: () {
          launchUrl(Uri.parse(LinksGetx.to.twitter));
          // Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.twitter});
        },
      ),
      MenuEntry(
        name: 'Discord',
        icon: 'my/setting/share_discoverd'.svgAssets(),
        iconSize: 20.w,
        onTap: () {
          launchUrl(Uri.parse(LinksGetx.to.discord));
          // Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.discord});
        },
      ),
      MenuEntry(
        name: 'Telegram',
        icon: 'my/setting/share_telegram'.svgAssets(),
        iconSize: 20.w,
        onTap: () {
          launchUrl(Uri.parse(LinksGetx.to.telegram));
          // Get.toNamed(Routes.WEBVIEW,
          //     arguments: {'url': LinksGetx.to.telegram});
        },
      ),
    ];
  }

  List<MenuEntry> _entriesTwo(BuildContext context) {
    return [
      MenuEntry(
          name: LocaleKeys.user186.tr,
          behindName: LinksGetx.to.email,
          goIcon: false,
          bottomBorder: true,
          onTap: () async {
            CopyUtil.copyText(LinksGetx.to.email);
          }),
    ];
  }

  List<MenuEntry> _entriesThree(BuildContext context) {
    return [
      MenuEntry(
        name: LocaleKeys.user212.tr,
        onTap: () {
          Get.toNamed(Routes.WEBVIEW,
              arguments: {'url': LinksGetx.to.userProtocal});
        },
      ),
      MenuEntry(
        name: LocaleKeys.user213.tr,
        onTap: () {
          Get.toNamed(Routes.WEBVIEW,
              arguments: {'url': LinksGetx.to.riskProtocal});
        },
      ),
      MenuEntry(
        name: LocaleKeys.user214.tr,
        onTap: () {
          Get.toNamed(Routes.WEBVIEW,
              arguments: {'url': LinksGetx.to.privacyProtocal});
        },
      ),
      MenuEntry(
        name: LocaleKeys.user215.tr,
        onTap: () {
          Get.toNamed(Routes.WEBVIEW,
              arguments: {'url': LinksGetx.to.platformIntroduce});
        },
      ),
      MenuEntry(
        name: LocaleKeys.user219.tr,
        onTap: () {
          Get.toNamed(Routes.WEBVIEW,
              arguments: {'url': LinksGetx.to.usLicense});
        },
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _checkAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const MyPageBackWidget(),
            centerTitle: true,
            title: Text(LocaleKeys.user211.tr,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            elevation: 0),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.fromLTRB(0, 14.h, 0, 0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.w)),
                  child: MyImage(
                    'logo'.pngAssets(),
                    width: 64.w,
                    radius: 14.r,
                  ),
                ),
                12.verticalSpace,
                Text(
                  "V${PackageUtil.versionCode}",
                  style: AppTextStyle.f_16_600,
                ),
                Container(
                  height: 30.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: universalListWidget(
                    context,
                    _entries,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: universalListWidget(
                    context,
                    _entriesTwo,
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: universalListWidget(
                    context,
                    _entriesThree,
                  ),
                ),
                SizedBox(
                  height: 6.w,
                ),
                // Container(
                //   child: userListWidget(context, _entriesTwo, paddingHorizontal: 8.w),
                //   // padding: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
                //   decoration: BoxDecoration(
                //       color: Colors.white, borderRadius: BorderRadius.circular(16)),
                // ),
              ],
            ),
          ),
        ));
  }

  /// 检测app版本
  void _checkAppVersion() {
    CheckAppUpdate.onlyCheckUpdate().then((response) {
      if (response != null) {
        checkUpdateResponse = response;
        if (mounted) setState(() {});
      }
    });
  }
}
