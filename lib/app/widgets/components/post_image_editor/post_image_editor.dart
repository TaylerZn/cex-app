import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/pages/complex/image_avatar_page.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'post_image_editor_logic.dart';
import 'widget/label_info_bean.dart';
import 'widget/label_widget.dart';

class PostImageEditor extends StatefulWidget {
  final List<AssetEntity?> imageAssets;
  final List<String>? lastSelectNftKeys;

  const PostImageEditor(
      {Key? key, required this.imageAssets, this.lastSelectNftKeys})
      : super(key: key);

  @override
  State<PostImageEditor> createState() => _PostImageEditorState();
}

typedef LabelChange = void Function(LabelInfoBean label, bool willDelete);

class _PostImageEditorState extends State<PostImageEditor> {
  GlobalKey pageKey = GlobalKey();
  late PostImageEditorLogic _editorLogic =
      Get.put<PostImageEditorLogic>(PostImageEditorLogic(widget.imageAssets));

  ///标签圆圈的大小
  double circleSize = 12.w;

  ///标签的高度
  double labelHeight = 20.w;

  double deleteRectHeight = 76.w;

  ///删除矩形在屏幕上的位置
  late Rect deleteRect;
  LabelChange? labelChange;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    deleteRect = Rect.fromLTWH(
        0, size.height - deleteRectHeight, size.width, deleteRectHeight);
    return MySystemStateBar(
      color: SystemColor.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            leading: const MyPageBackWidget(
              backColor: AppColor.colorWhite,
            ),
            // Navigator.maybePop(context);
            title: GetBuilder<PostImageEditorLogic>(
                init: _editorLogic,
                id: 'pageChanged',
                builder: (logic) {
                  return Text(
                    '${logic.currentImageIndex + 1}/${widget.imageAssets.length}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  );
                }),
          ),
          body: Column(
            children: [
              Expanded(
                  child: GetBuilder<PostImageEditorLogic>(
                      init: _editorLogic,
                      id: 'imageFiles',
                      builder: (logic) {
                        return PageView(
                          key: pageKey,
                          children: logic.imageFiles.map<Widget>((e) {
                            var index = logic.imageFiles.indexOf(e);
                            return _buildImageEditPage(e, index);
                          }).toList(),
                          onPageChanged: (index) {
                            logic.currentImageIndex = index;
                          },
                        );
                      })),
              Container(
                height: 76.w,
                child: Stack(
                  children: [
                    _buildEditArea(),
                    // _buildDeleteArea(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildImageEditPage(File imageFile, int index) {
    var editModel = _editorLogic.editImageModels[index];
    return Stack(
      children: [
        Positioned.fill(
            child: ExtendedImage.file(
          imageFile,
          fit: BoxFit.contain,
          loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.completed) {
              /// 加载成功如下代码就可以拿到图片高宽了
              var imageInfo = state.extendedImageInfo?.image;
              print(
                  'imageInfo --- width : ${imageInfo?.width} height:${imageInfo?.height}');
              _calcImgRect(imageInfo, index);
            }
            return null;
          },
        )),
        ...(editModel.imageMarks ?? []).map((e) {
          var label = LabelWidget(
            key: e.key,
            name: e.name,
            labelHeight: 20.w,
          );
          return Positioned(
              left: e.offset.dx,
              top: e.offset.dy,
              child: Container(child: label));
        }).toList()
      ],
    );
  }

  ///计算图片实际位置
  void _calcImgRect(ui.Image? image, index) {
    var editImgModel = _editorLogic.editImageModels[index];
    if (editImgModel.imageRect != null) return;
    if (_editorLogic.containerSize == null) return;
    Size realImgSize = _calcImgSize(image);
    editImgModel.realImgSize = realImgSize;
    print('img----计算图片的真实大小：$realImgSize');
    double imgOffsetX =
        (_editorLogic.containerSize!.width - realImgSize.width) / 2;
    double imgOffsetY =
        (_editorLogic.containerSize!.height - realImgSize.height) / 2;
    editImgModel.imgStartOffset = Offset(imgOffsetX, imgOffsetY);
    print('img----计算图片左上角在stack上的位置：${editImgModel.imgStartOffset}');

    ///计算图片左上角在屏幕上的位置
    Offset imgOffset =
        _editorLogic.containerOffset! + Offset(imgOffsetX, imgOffsetY);
    print('img----计算图片左上角在屏幕上的位置：$imgOffset');
    editImgModel.imgOffset = imgOffset;
    Rect rect = imgOffset & realImgSize;
    print('img----图片矩形在屏幕的位置：$rect');
    editImgModel.imageRect = rect;

    if (editImgModel.imageMarks != null &&
        editImgModel.imageMarks!.isNotEmpty) {
      _updateImageMarksLocation(editImgModel);
    }
  }

  ///计算图片的真实大小
  ///[image] 图片模式
  ///[BoxFit.contain] 计算模式
  Size _calcImgSize(ui.Image? image) {
    if (image == null || _editorLogic.containerSize == null) return Size.zero;
    Size result = Size.zero;
    double imageAspectRatio = image.width.toDouble() / image.height.toDouble();
    double containerRatio =
        _editorLogic.containerSize!.width / _editorLogic.containerSize!.height;
    if (containerRatio > imageAspectRatio) {
      result = Size(imageAspectRatio * _editorLogic.containerSize!.height,
          _editorLogic.containerSize!.height);
    } else {
      result = Size(
          _editorLogic.containerSize!.width,
          image.height.toDouble() *
              _editorLogic.containerSize!.width /
              image.width.toDouble());
    }
    return result;
  }

  /// 计算xy与图片的比例
  Point calculateXYRatio(Offset imageOffset, EditImageModel editModel) {
    var imageSize = editModel.realImgSize;
    var imageStartOffset = editModel.imgStartOffset;
    var tempDy = imageOffset.dy - (imageStartOffset?.dy ?? 0);
    var tempDx = imageOffset.dx - (imageStartOffset?.dx ?? 0);
    var xRatio = imageSize?.width == null || imageSize?.width == 0.0
        ? 0.0
        : tempDx / imageSize!.width;
    var yRatio = imageSize?.height == null || imageSize?.height == 0
        ? 0.0
        : tempDy / imageSize!.height;
    return Point(xRatio, yRatio);
  }

  _buildEditArea() {
    return Positioned(
        child: Container(
      margin: EdgeInsets.only(top: 10.w, left: 16.w, right: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 16.w,
          ),
          InkWell(
            onTap: _onTapClip,
            child: Column(
              children: [
                MyImage(
                  'community/icon_cj'.svgAssets(),
                  color: Colors.white,
                  width: 12.w,
                  height: 12.w,
                ),
                Text(
                  LocaleKeys.community28.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.w,
                      color: Colors.white),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.only(top: 5.w),
            child: MyButton(
              height: 26.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              onTap: _onNext,
              border: Border.all(width: 1, color: AppColor.colorSuccess),
              child: Text(
                LocaleKeys.public3.tr,
                style: AppTextStyle.f_12_400.colorSuccess,
              ),
            ),
          )
        ],
      ),
    ));
  }

  _buildDeleteArea() {
    return GetBuilder<PostImageEditorLogic>(
        init: _editorLogic,
        id: 'dragStart',
        builder: (logic) {
          return AnimatedPositioned(
              bottom: logic.anyMarksStartDrag ? 0 : -(deleteRectHeight + 40),
              left: 0,
              right: 0,
              duration: Duration(milliseconds: 300),
              child: Container(
                height: deleteRectHeight,
                color: Color(0xffE43030),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage(
                      'svgAssets/del'.svgAssets(),
                      width: 28.w,
                      height: 28.w,
                    ),
                    Text(
                      '移动到此处删除',
                      style: TextStyle(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ));
        });
  }

  /// 下一步
  void _onNext() {
    Get.back(
      result: _editorLogic.editImageModels,
    );
  }

  /// 裁剪
  void _onTapClip() async {
    // var currentImgFileByte = await _editorLogic
    //     .imageFiles[_editorLogic.currentImageIndex]
    //     .readAsBytes();
    Get.to(ImageAvatarPage(
            file: _editorLogic.imageFiles[_editorLogic.currentImageIndex]))
        ?.then((value) {
      if (value != null) {
        _editorLogic.clipCurrentImage(value);
      }
    });
  }

  /// 重新更新标签位置
  void _updateImageMarksLocation(EditImageModel editModel) {
    var imageSize = editModel.realImgSize;
    var imageStartOffset = editModel.imgStartOffset;
    editModel.imageMarks!.forEach((element) {
      var x =
          (imageStartOffset?.dx ?? 0) + imageSize!.width * element.realXRatio;
      var y =
          (imageStartOffset?.dy ?? 0) + imageSize.height * element.realYRatio;
      element.offset = Offset(x, y);
      element.lastOffset = element.offset;
    });
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      if (mounted) setState(() {});
    });
  }
}
