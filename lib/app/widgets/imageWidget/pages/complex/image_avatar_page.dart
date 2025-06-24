import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/image_picker/image_picker.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/utils/crop_editor_helper.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/widget/common_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:path_provider/path_provider.dart';

class ImageAvatarPage extends StatefulWidget {
  final File file;
  const ImageAvatarPage({super.key, required this.file});
  @override
  _ImageAvatarPageState createState() => _ImageAvatarPageState();
}

class _ImageAvatarPageState extends State<ImageAvatarPage> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  final GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>> popupMenuKey =
      GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>>();
  final List<AspectRatioItem> _aspectRatios = <AspectRatioItem>[
    AspectRatioItem(text: '1*1', value: CropAspectRatios.ratio1_1),
  ];
  AspectRatioItem? _aspectRatio;

  EditorCropLayerPainter? _cropLayerPainter;

  @override
  void initState() {
    _memoryImage = widget.file.readAsBytesSync();
    _aspectRatio = _aspectRatios.first;
    _cropLayerPainter = const EditorCropLayerPainter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        color: SystemColor.white,
        child: Scaffold(
            backgroundColor: Colors.black87,
            body: Column(children: <Widget>[
              Expanded(
                child: ExtendedImage.memory(
                  _memoryImage!,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.editor,
                  enableLoadState: true,
                  extendedImageEditorKey: editorKey,
                  initEditorConfigHandler: (ExtendedImageState? state) {
                    return EditorConfig(
                        maxScale: 8.0,
                        cropRectPadding: const EdgeInsets.all(20.0),
                        hitTestSize: 20.0,
                        cropLayerPainter: _cropLayerPainter!,
                        initCropRectType: InitCropRectType.imageRect,
                        cropAspectRatio: _aspectRatio!.value,
                        editorMaskColorHandler: (_, ___) {
                          return Colors.black38;
                        });
                  },
                  cacheRawData: true,
                ),
              ),
            ]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 0.5.w, color: Colors.black))),
              padding: EdgeInsets.fromLTRB(
                  6.w, 16.w, 6.w, MediaQuery.of(context).padding.bottom),
              child: Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Container(
                        child: Text(
                          LocaleKeys.public2.tr,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Container(
                        child: Text(
                          LocaleKeys.community35.tr,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      editorKey.currentState!.reset();
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Text(
                        LocaleKeys.public1.tr,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () async {
                      var fileData = await cropImageDataWithNativeLibrary(
                          state: editorKey.currentState!);
                      bool cropBool = checkCrop();
                      File file;
                      if (cropBool) {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final String? fileFath = await ImageSaver.save(
                            '${directory.path}/image.png', fileData!);
                        file = File(fileFath!);
                      } else {
                        file = widget.file;
                      }
                      Get.back(result: file);
                    },
                  )
                ],
              ),
            )));
  }

  bool hasImageBeenCropped() {
    final ExtendedImageEditorState? state = editorKey.currentState;
    if (state == null) {
      return false;
    }

    // 获取裁剪矩形
    Rect? cropRect = state.getCropRect();

    // 获取当前图片尺寸
    Size? imageSize = state.image?.width != null && state.image?.height != null
        ? Size(state.image!.width.toDouble(), state.image!.height.toDouble())
        : null;

    if (cropRect != null && imageSize != null) {
      return cropRect.width != imageSize.width ||
          cropRect.height != imageSize.height;
    }

    return false;
  }

// 使用方法
  bool checkCrop() {
    bool cropped = hasImageBeenCropped();
    print("图片是否被裁剪： $cropped");
    return cropped;
  }

  Uint8List? _memoryImage;
}

class CustomEditorCropLayerPainter extends EditorCropLayerPainter {
  const CustomEditorCropLayerPainter();
  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Paint paint = Paint()
      ..color = painter.cornerColor
      ..style = PaintingStyle.fill;
    final Rect cropRect = painter.cropRect;
    const double radius = 6;
    canvas.drawCircle(Offset(cropRect.left, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.left, cropRect.bottom), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.bottom), radius, paint);
  }
}

class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  const CircleEditorCropLayerPainter();

  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    // do nothing
  }

  @override
  void paintMask(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect rect = Offset.zero & size;
    final Rect cropRect = painter.cropRect;
    final Color maskColor = painter.maskColor;
    canvas.saveLayer(rect, Paint());
    canvas.drawRect(
        rect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = maskColor);
    canvas.drawCircle(cropRect.center, cropRect.width / 2.0,
        Paint()..blendMode = BlendMode.clear);
    canvas.restore();
  }

  @override
  void paintLines(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect cropRect = painter.cropRect;
    if (painter.pointerDown) {
      canvas.save();
      canvas.clipPath(Path()..addOval(cropRect));
      super.paintLines(canvas, size, painter);
      canvas.restore();
    }
  }
}
