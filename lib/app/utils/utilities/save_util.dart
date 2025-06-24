import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';

import 'package:nt_app_flutter/app/utils/utilities/permission_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class SaveUtil {
  // 保存网络图片
  static Future<dynamic> saveNetworkImg(String imgUrl) async {
    var response = await Dio()
        .get(imgUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100);
    if (result['isSuccess']) {
      UIUtil.showSuccess(LocaleKeys.public20.tr);
    } else {
      UIUtil.showError(LocaleKeys.public21.tr);
    }
  }

// 保存图片
  static Future<dynamic> saveImage(Uint8List imageBytes) async {
    if (await requestPhotosPermission()) {
      // fileUint8 ??= await controller.capture(pixelRatio: 2);
      await Future.delayed(const Duration(milliseconds: 100));
      final result = await ImageGallerySaver.saveImage(imageBytes,
          isReturnImagePathOfIOS: true);

      if (result['isSuccess']) {
        UIUtil.showSuccess(LocaleKeys.public20.tr);
      } else {
        UIUtil.showError(LocaleKeys.public21.tr);
      }
    }
  }
}
