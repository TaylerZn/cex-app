import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:nt_app_flutter/app/utils/utilities/permission_util.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

Future pickImage(BuildContext context) async {
  if (await requestPhotosPermission()) {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        pathThumbnailSize: ThumbnailSize.square(84),
        gridCount: 4,
        pageSize: 300,
        requestType: RequestType.image,
        textDelegate: EnglishAssetPickerTextDelegate(),
      ),
    );
    if (result != null) {
      return result.first;
      // result.first.originBytes;
    }
    return null;
  } else {
    return null;
  }
}

class ImageSaver {
  const ImageSaver._();

  static Future<String?> save(String name, Uint8List fileData) async {
    final String title = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final AssetEntity? imageEntity = await PhotoManager.editor.saveImage(
      fileData,
      title: title,
    );
    final File? file = await imageEntity?.file;
    return file?.path;
  }
}
