import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'widget/label_info_bean.dart';

class PostImageEditorLogic extends GetxController {
  List<AssetEntity?> imageAssets;

  List<File> imageFiles = [];

  List<EditImageModel> editImageModels = [];

  int _currentImageIndex = 0;

  int get currentImageIndex => _currentImageIndex;

  Size? containerSize;
  Offset? containerOffset;

  bool _anyMarksStartDrag = false;

  bool get anyMarksStartDrag => _anyMarksStartDrag;

  set anyMarksStartDrag(bool value) {
    _anyMarksStartDrag = value;
    update(['dragStart']);
  }

  /// 正在有标签拖动

  set currentImageIndex(int value) {
    _currentImageIndex = value;
    update(['pageChanged']);
  }

  PostImageEditorLogic(this.imageAssets) {
    getImageFiles();
  }

  /*
  *
  * Future<List> getAllFinalItems() async {
  List finalItems = [];
  // Get the item keys from the network
  List itemsKeysList =   await getItemsKeysList()

  // Future.wait will wait until I get an actual list back!
  await Future.wait(itemsKeysList.map((item) {
    finalItem = await getFinalItem(item);
    finalItems.add(finalItem)
  }).toList())

  return finalItems;
 }
  *
  * */

  void getImageFiles() async {
    for (int i = 0; i < imageAssets.length; i++) {
      var item = imageAssets[i];
      var finalItem = await item?.file;
      if (finalItem != null) {
        imageFiles.add(finalItem);
        var editImageModel = EditImageModel(
            imageFile: finalItem,
            realImgSize: (Size(double.parse('${item?.width}'),
                double.parse('${item?.height}'))));
        editImageModels.add(editImageModel);
      }
    }
    update(['imageFiles']);
  }

  void clipCurrentImage(File clipImage) async {
    final String? filePath = await ImageSaver.save(
        'send_post_image_cropped_image_${currentImageIndex}.jpg',
        clipImage.readAsBytesSync());
    var file = File(filePath!);
    imageFiles[currentImageIndex] = file;
    var editImageModel = editImageModels[currentImageIndex];
    editImageModel.imageFile = file;
    editImageModel.imageRect = null;
    update(['imageFiles']);
  }
}

class EditImageModel {
  Size? realImgSize;
  Offset? imgStartOffset;
  Offset? imgOffset;
  Rect? imageRect;
  int imageIndex;
  File? imageFile;
  List<LabelInfoBean>? imageMarks;
  EditImageModel(
      {this.realImgSize,
      this.imgStartOffset,
      this.imgOffset,
      this.imageMarks,
      this.imageIndex = 0,
      this.imageFile});
}
