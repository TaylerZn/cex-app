// 发帖
import 'dart:convert';
import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/api/file/file_interface.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/post_image_editor/post_image_editor_logic.dart';

/// 发送视频帖子
sendPostVideo(dynamic value,
    {
    /// 发送失败
    Function()? postError,

    /// 发送成功
    Function()? postSuccess}) async {
  var dataImgList = [];

  var imageModel = value['videoList'][0];
  var width = imageModel.width;
  var height = imageModel.height;
  var file = await imageModel.file;
  // String? mimeType = lookupMimeType(file.path);
  String fileName = file.path.split('/').last; // 获取文件名
  List<String> parts = fileName.split('.'); // 分割文件名
  var fileExtension = '';
  if (parts.length > 1) {
    fileExtension = parts.last; // 获取最后一个部分，即后缀名
    print('文件后缀名：$fileExtension');
  } else {
    print('文件没有后缀名');
  }
  var res = await communitystorageupload(file, fileType: FileType.Video);
  if (res != null) {
    dataImgList.add({
      'sortNum': '1',
      'fileType': 'VIDEO',
      "fileUrl": res,
      "width": '$width',
      "height": '$height',
    });

      value['videoList'] = jsonEncode(dataImgList);
    var coverFile = value['coverInfo'];
    var coverurl = await communitystorageupload(await coverFile);
    value['coverInfo'] = {
      'sortNum': '1',
      'fileType': 'PIC',
      "fileUrl": coverurl,
      "width": '$width',
      "height": '$height',
    };
    value.forEach((key, values) {
      if (values is! String) {
        if(key != 'votingOptionList' || key != 'symbolList'){
          value[key] = jsonEncode(values); // 使用jsonEncode将Map转为JSON字符串
        }
      }
    });
    try {
      if(ObjectUtil.isNotEmpty(value?['postTime'])){
        await CommunityApi.instance().topicAddSchedulePost(value);
      }else{
        await CommunityApi.instance().topicaddpost(value);
      }
      Bus.getInstance().emit(EventType.postSend, null);
      if (postSuccess != null) postSuccess();
    } on DioException catch (e) {
      if (postError != null) postError();
      UIUtil.showError('${e.error}');
    }
  } else {
    if (postError != null) postError();
  }
}

/// 发送图片帖子
sendPostImageNote(
  dynamic value, {
  Function()? postError,

  /// 发送失败
  Function()? postSuccess,

  /// 发送成功
  Function(File firstImage)? imageNoteFirstImage,

  /// 发送的第一张图片
}) async {
  var temp = value?['picList'] ?? [];
  var dataImgList =  [];
  for (var i = 0; i < temp.length; i++) {
    var imageModel = temp[i];
    if ((imageModel is EditImageModel) == false) {
      throw ('post image type error');
    }
    EditImageModel imgModel = imageModel;
    var imageFile = imgModel.imageFile;
    var width = imgModel.realImgSize?.width;
    var height = imgModel.realImgSize?.height;
    if (i == 0) {
      if (imageNoteFirstImage != null && imageFile != null) {
        imageNoteFirstImage(imageFile);
      }
    }
    var res = await communitystorageupload(imageFile);
    if (res != null) {
      var url = res;
      dataImgList.add({
        'sortNum': '1',
        'fileType': 'PIC',
        "fileUrl": url,
        "width": '$width',
        "height": '$height',
      });
    } else {
      return false;
    }
  }
  value['picList'] = jsonEncode(dataImgList) ;
  if (dataImgList.isNotEmpty) {
    value['coverInfo'] = jsonEncode(dataImgList[0]) ; ;
  }
  // value.forEach((key, values) {
  //   if (values is! String) {
  //     if(key != 'votingOptionList' || key != 'symbolList'){
  //       value[key] = jsonEncode(values); // 使用jsonEncode将Map转为JSON字符串
  //     }
  //   }
  // });


  try {

    if(ObjectUtil.isNotEmpty(value?['postTime'])){
      await CommunityApi.instance().topicAddSchedulePost(value);
    }else{

      await CommunityApi.instance().topicaddpost(value);
    }

    if (postSuccess != null) postSuccess();
    Bus.getInstance().emit(EventType.postSend, null);
  } on DioException catch (e) {
    if (postError != null) postError();
    UIUtil.showError('${e.error}');
  }
}
