import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:nt_app_flutter/app/api/file/file.dart';
import 'package:nt_app_flutter/app/models/file/file.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

////图片上传接口(登录状态)
Future<CommonuploadimgModel?> commonuploadimg(file, {type}) async {
  var base64 = await MyFileUtil.getBase64(file.path);
  var data = {"imageData": base64};
  try {
    var res = await FileApi.instance().commonuploadimg(data);
    return res;
  } on dio.DioException catch (e) {
    EasyLoading.dismiss();
    return null;
  } catch (e) {
    EasyLoading.dismiss();
    return null;
  }
}

////上传文件-图片-视频
Future<String?> communitystorageupload(file,
    {FileType fileType = FileType.Image,
    UploadBizType bizType = UploadBizType.topics,
    int quality = 60,
    int maxByte = 200 * 1024}) async {
  var filePath = file.path;
  var beforeByteLength = file.readAsBytesSync().length;
  // 如果是图片文件，对文件进行压缩
  if (fileType == FileType.Image) {
    var compressImageFile = await imageCompressAndGetFile(
        file: file, quality: quality, maxByte: maxByte);

    /// 压缩后大小
    if (compressImageFile != null) {
      filePath = compressImageFile.path;
      var byteLength = compressImageFile.readAsBytesSync().length;
    }
  } else if (fileType == FileType.Video) {
    // try {
    //   var minVideoByte = 1024 * 1024 * 5;
    //   print('===== 视频<=${MyFileUtil.filesize(minVideoByte)}不压缩');
    //   print('===== 视频压缩前大小 ${MyFileUtil.filesize(beforeByteLength)}');
    //   if (beforeByteLength >= minVideoByte) {
    //     MediaInfo? mediaInfo = await VideoCompress.compressVideo(filePath,
    //         quality: VideoQuality.Res1280x720Quality);
    //     if (mediaInfo?.path != null) {
    //       filePath = mediaInfo?.path;
    //       var beforeByteLength = mediaInfo!.file!.readAsBytesSync().length;
    //       print('===== 视频压缩后大小 ${MyFileUtil.filesize(beforeByteLength)}');
    //     }
    //   }
    // } catch (e) {
    //   debugPrint('==== 视频压缩失败 $e');
    // }
  }
  dio.MultipartFile newfila = await dio.MultipartFile.fromFile(filePath);
  var datas = {"file": newfila, "bizType": bizType.value};
  dio.FormData data = dio.FormData.fromMap(datas);
  try {
    CommonuploadimgModel res = await FileApi.instance().commonuploadfile(data);
    var url = '${res.baseImageUrl}${res.filenameStr}';
    return url;
  } on dio.DioException catch (e) {
    UIUtil.showError('${e.error}');
    EasyLoading.dismiss();
    return null;
  }
}

/// 压缩图片
Future<File?> imageCompressAndGetFile(
    {required File file,
    String? targetPath,
    int quality = 80,
    int? maxByte,
    int compressTimes = 1}) async {
  try {
    if (targetPath == null) {
      final dir = await getTemporaryDirectory();
      targetPath = dir.absolute.path + '/temp.jpg';
    }
    var data = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
    );
    if (data != null) {
      File result = File(data.path);
      if (maxByte != null) {
        var resultByte = result.readAsBytesSync();
        print(
            '压缩后大小 ---- ${MyFileUtil.filesize(resultByte.length)}压缩质量$quality 压缩次数$compressTimes 最大大小${MyFileUtil.filesize(maxByte)}');
        if (maxByte >= resultByte.length) {
          return result;
        } else {
          print('开始图片压缩循环 ${compressTimes + 1}');
          var nextQuality = quality - 10;
          if (nextQuality <= 0) {
            return result;
          }
          return imageCompressAndGetFile(
              file: file,
              targetPath: targetPath,
              quality: quality - 10,
              maxByte: maxByte,
              compressTimes: compressTimes + 1);
        }
      } else {
        print(
            '压缩后大小 ---- ${MyFileUtil.filesize(result!.readAsBytesSync().length)} 压缩次数 $compressTimes');
        return result;
      }
    }
  } catch (e) {
    return null;
  }
  return null;
}

enum FileType { Image, Video }

// topics：社区
// user：头像
// realName：实名认证
// feedback：问题反馈
enum UploadBizType {
  topics,
  user,
  realName,
  feedback;

  String get value => ['topics', 'user', 'realName', 'feedback'][index];
}
