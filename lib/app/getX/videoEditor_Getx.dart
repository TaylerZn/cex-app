import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:video_editor/video_editor.dart';

class VideoEditorGetx extends GetxController {
  VideoEditorController? controller;
  var file;

  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);

  @override
  getController(file) async {
    controller = VideoEditorController.file(
      file,
      minDuration: Duration(seconds: 3),
      maxDuration: Duration(seconds: 900),
    );
    controller?.initialize().then((_) {
      // controller?.video.play();
      update();
    }).catchError((error) {
      UIUtil.showToast(LocaleKeys.community36.trArgs(['3', '900']));
      // '请将视频时长控制在为3s~900s之间"');
      Get.back();
    }, test: (e) {
      return true;
    });
  }

  disposeVideo() {
    print(controller);
    controller?.dispose();
  }

  exportVideo() async {
    // var files;
    // _exportingProgress.value = 0;
    // _isExporting.value = true;
    // // NOTE: To use `-crf 1` and [VideoExportPreset] you need `ffmpeg_kit_flutter_min_gpl` package (with `ffmpeg_kit` only it won't work)
    // await controller?.exportVideo(
    //   // scale: 0.7,
    //   // preset: VideoExportPreset.medium,
    //   // customInstruction: "-crf 17",
    //   onProgress: (stats, value) => _exportingProgress.value = value,
    //   onError: (e, s) {
    //     return null;
    //   },
    //   onCompleted: (file) {
    //     _isExporting.value = false;
    //     files = file;
    //     return files;
    //     // showDialog(
    //     //   context: context,
    //     //   builder: (_) => VideoResultPopup(video: file as File),
    //     // );
    //   },
    // );
  }

  /// 控制器被释放
  @override
  void onClose() {
    controller?.dispose();
    _exportingProgress.dispose();
    _isExporting.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
