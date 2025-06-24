import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/save_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class MyShareView extends StatefulWidget {
  const MyShareView({
    super.key,
    required this.content,
    this.url,
  });

  final Widget content;
  final String? url;

  @override
  State<StatefulWidget> createState() {
    return MyShareViewState();
  }
}

class MyShareViewState extends State<MyShareView> {
  ScreenshotController controller = ScreenshotController();
  var fileUint8;
  var filePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned.fill(
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          bottom: 140.h),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Screenshot(
                                    controller: controller,
                                    child: widget.content))
                          ],
                        ),
                      )))),
          Positioned(
              bottom: 0.w,
              left: 0.w,
              child: Container(
                width: 375.w,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.colorWhite,
                ),
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                child: Row(
                  children: [
                    shareColumnWidget(
                      LocaleKeys.public33.tr,
                      'default/share_img',
                      () async {
                        fileUint8 ??= await controller.capture(pixelRatio: 2);
                        await Future.delayed(const Duration(milliseconds: 100));

                        SaveUtil.saveImage(fileUint8 as Uint8List);
                      },
                    ),
                    shareColumnWidget(LocaleKeys.public61.tr, 'default/share',
                        () async {
                      final box = context.findRenderObject() as RenderBox?;
                      await controller
                          .capture(delay: const Duration(milliseconds: 10))
                          .then((Uint8List? image) async {
                        if (image != null) {
                          final directory =
                              await getApplicationDocumentsDirectory();
                          final imagePath =
                              await File('${directory.path}/image.png')
                                  .create();
                          await imagePath.writeAsBytes(image);
                          Share.shareXFiles(
                            [XFile(imagePath.path)],
                            sharePositionOrigin:
                                box!.localToGlobal(Offset.zero) & box.size,
                          );
                        }
                      });
                    }),
                    widget.url != null
                        ? shareColumnWidget(
                            LocaleKeys.public62.tr, 'default/share_url',
                            () async {
                            Share.shareUri(Uri.parse(widget.url!));
                          })
                        : const SizedBox()
                  ],
                ),
              ))
        ],
      ),
    );
  }

  shareColumnWidget(String title, image, onTap) {
    return Expanded(
      child: InkWell(
          onTap: () {
            onTap();
          },
          child: Column(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                    color: AppColor.colorF5F5F5,
                    borderRadius: BorderRadius.circular(43)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage(
                      '$image'.svgAssets(),
                      width: 20.w,
                      height: 20.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              )
            ],
          )),
    );
  }
}
