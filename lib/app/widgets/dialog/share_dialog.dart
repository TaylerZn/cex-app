import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/save_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/url_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../utils/utilities/copy_util.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  static Future<void> show({required Widget child, EdgeInsets? padding}) async {
    return Get.dialog(ShareDialog(
      padding: padding,
      child: child,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        shareWidget(),
        shareButtons(),
      ],
    );
  }

  shareWidget() {
    return Expanded(
        child: Container(
      padding: padding ?? EdgeInsets.only(top: 120.w),
      alignment: Alignment.topCenter,
      child: RepaintBoundary(key: saveImageKey, child: child),
    ));
  }

  shareButtons() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        decoration: BoxDecoration(
          color: AppColor.colorBackgroundPrimary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.w)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(LocaleKeys.public34.tr,
                      style: AppTextStyle.f_20_600.colorTextPrimary),
                  const Spacer(),
                  MyImage(
                    'default/guide_close'.svgAssets(),
                    width: 16.w,
                  ),
                ],
              ),
            ),
            16.verticalSpaceFromWidth,
            SizedBox(
              height: 58.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: _shareItemBuilder,
                itemCount: shareItems.length,
              ),
            )
          ],
        ));
  }

  Widget? _shareItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        shareItems[index]['onTap']();
      },
      child: SizedBox(
        width: 93.75.w,
        height: 58.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Container(
                color: AppColor.colorBackgroundSecondary,
                alignment: Alignment.center,
                width: 40.w,
                height: 40.w,
                child: MyImage(
                  shareItems[index]['icon'],
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ),
            Text(shareItems[index]['title'],
                style: AppTextStyle.f_12_400.colorTextPrimary),
          ],
        ),
      ),
    );
  }
}

GlobalKey saveImageKey = GlobalKey();
List shareItems = [
  {
    'icon': 'activity/copy_link'.svgAssets(),
    'title': '复制链接',
    'onTap': () {
      CopyUtil.copyText(
          'https://www.bitget.fit/zh-CN/events/activities/1cf452c67ce25cc6b6fdb00d131cf460?clacCode=&color=white&shareid=twitter');
    },
  },
  {
    'icon': 'activity/download'.svgAssets(),
    'title': '下载图片',
    'onTap': () async {
      // 获取widget的RenderObject
      final renderObject = saveImageKey.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      // 将widget绘制到图片中
      final image = await renderObject.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      SaveUtil.saveImage(pngBytes);
    },
  },
  {
    'icon': 'activity/x'.svgAssets(),
    'title': 'x',
    'onTap': () {
      String uri =
          'twitter://post?message=参与活动赢取好礼！ https://www.bitget.fit/zh-CN/events/activities/1cf452c67ce25cc6b6fdb00d131cf460?clacCode=&color=white&shareid=twitter';
      MyUrlUtil.openUrl(uri);
    },
  },
  {
    'icon': 'activity/telegram'.svgAssets(),
    'title': 'Telegram',
    'onTap': () {
      String uri =
          'tg://msg?text=参与活动赢取好礼！ https://www.bitget.fit/zh-CN/events/activities/1cf452c67ce25cc6b6fdb00d131cf460?clacCode=&color=white&shareid=telegram';
      MyUrlUtil.openUrl(uri);
    },
  },
];
