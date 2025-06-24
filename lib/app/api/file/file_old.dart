import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:nt_app_flutter/app/api/file/file.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

////图片上传接口(登录状态)
commonuploadimg(file, {type}) async {
  var base64 = await MyFileUtil.getBase64(file.path);
  var data = {"imageData": base64};
  try {
    var res = await FileApi.instance().commonuploadimg(data);

    return res;
  } on dio.DioException catch (e) {
    print(e.error);
    EasyLoading.dismiss();
  }
}

//上传文件(从服务端获取URL)
memberfileOss(type, file,
    {mediaType = "",
    fileExtension = "",
    isCompress = false,
    FileType fileType = FileType.Image,
    int quality = 60,
    int maxByte = 200 * 1024}) async {
  var data = {
    "type": type,
    "mediaType": mediaType,
    "fileExtension": fileExtension
  };
  try {
    var res = await FileApi.instance().memberfileOss(data);
    if (res != null) {
      var fileToOssBool = await putFileToOssUrl(res['url'], file,
          isCompress: isCompress,
          fileType: fileType,
          quality: quality,
          maxByte: maxByte);
      if (fileToOssBool == true) {
        var url = res['url'].split('?')[0];
        return url;
      } else {
        UIUtil.showError('上传失败');
        return null;
      }
    }
    UIUtil.showError('$res');
    return null;
  } on dio.DioException catch (e) {
    print(e.error);
    UIUtil.showError('${e.error}');
  }
}

Future<bool> putFileToOssUrl(url, file,
    {isCompress = false,
    FileType fileType = FileType.Image,
    int quality = 60,
    int maxByte = 200 * 1024}) async {
  var signedUrl = Uri.parse(url);
  dio.Dio dios = dio.Dio();

  if (!file.existsSync()) {
    return false;
  }
  String? mimeType = lookupMimeType(file.path);
  var filaDate = file;
  if (isCompress) {
    var filePath = file.path;
    var beforeByteLength = file.readAsBytesSync().length;
    print('===== 压缩前大小 ${MyFileUtil.filesize(beforeByteLength)}');
    // 如果是图片文件，对文件进行压缩
    if (fileType == FileType.Image) {
      var compressImageFile = await imageCompressAndGetFile(
          file: file, quality: quality, maxByte: maxByte);

      /// 压缩后大小
      if (compressImageFile != null) {
        filePath = compressImageFile.path;
        var byteLength = compressImageFile.readAsBytesSync().length;
        print('===== 压缩后准备上传图片压缩后大小 ${MyFileUtil.filesize(byteLength)}');
      }
    } else if (fileType == FileType.Video) {
      try {
        var minVideoByte = 1024 * 1024 * 5;
        print('===== 视频<=${MyFileUtil.filesize(minVideoByte)}不压缩');
        print('===== 视频压缩前大小 ${MyFileUtil.filesize(beforeByteLength)}');
        if (beforeByteLength >= minVideoByte) {
          MediaInfo? mediaInfo = await VideoCompress.compressVideo(filePath,
              quality: VideoQuality.Res1280x720Quality);
          if (mediaInfo?.path != null) {
            filePath = mediaInfo?.path;
            var beforeByteLength = mediaInfo!.file!.readAsBytesSync().length;
            print('===== 视频压缩后大小 ${MyFileUtil.filesize(beforeByteLength)}');
          }
        }
      } catch (e) {
        debugPrint('==== 视频压缩失败 $e');
      }
    }
    // contentType: MediaType
    // filaDate = await dio.MultipartFile.fromFile(filePath);
    filaDate = File(filePath);
  }
  print("文件类型:$mimeType");
  try {
    dio.Response response = await dios.putUri(
      signedUrl,
      data: filaDate.openRead(), // 以 Stream 的形式发送数据
      options: dio.Options(
        headers: {
          HttpHeaders.contentTypeHeader: mimeType, // 根据实际文件类型调整
          // 如有其他头部信息，按需添加
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } on dio.DioException catch (e) {
    print("上传异常: $e");
    if (e.response != null) {
      print("响应数据：${e.response!.data}");
      print("响应头：${e.response!.headers}");
      print("请求头：${e.requestOptions.headers}");
    }
    return false;
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
            '压缩后大小 ---- ${MyFileUtil.filesize(result.readAsBytesSync().length)} 压缩次数 $compressTimes');
        return result;
      }
    }
  } catch (e) {
    return null;
  }
}

enum FileType { Image, Video }
