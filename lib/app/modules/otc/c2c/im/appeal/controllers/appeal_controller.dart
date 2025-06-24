import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:nt_app_flutter/app/api/file/file_interface.dart';
import 'package:nt_app_flutter/app/api/otc/ctc_message_api.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/c2c_detail_problem_res.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:intl/intl.dart';

class AppealController extends GetxController with WidgetsBindingObserver {
  final String complainId;
  AppealController({required this.complainId});

  List<RqReplyList> rqReplyList = [];

  Timer? timer;

  late ScrollController scrollController;

  @override
  void onInit() {
    scrollController = ScrollController();
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onReady() {
    super.onReady();
    fetchMessageList();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
    scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  /// 消息列表
  Future<void> fetchMessageList() async {
    _fetchMessageList();
    timer?.cancel();
    timer = Timer.periodic(5.seconds, (timer) {
      _fetchMessageList();
    });
  }

  _fetchMessageList() async {
    try {
      final res = await CtcMessageApi.instance().detailsProblem(complainId);

      rqReplyList = showTime(res.rqReplyList ?? []);

      update();
    } catch (e) {}
  }

  /// 发送消息
  Future<void> sendTextMessage(String value) async {
    if (value.isEmpty) {
      return;
    }
    replyCreate(value);
  }

  void sendImageMessage(String value) {
    if (value.isEmpty) {
      return;
    }

    uploadPic(value);
  }

  replyCreate(String value, [int contentType = 1]) async {
    if (value.isEmpty) {
      return;
    }
    try {
      await CtcMessageApi.instance().replyCreate(complainId, value, contentType.toString());
      fetchMessageList();
    } on DioException catch (e) {
      UIUtil.showError(e.error);
    }
  }

  Future<void> uploadPic(String value) async {
    if (value.isEmpty) {
      return;
    }
    try {
      /// 上传图片
      // final res = await OtcApi.instance().uploadImg(File(value));
      final res = await commonuploadimg(File(value));
      String? fileName = res?.filename;
      if (fileName == null) {
        return;
      }
      replyCreate(fileName, 2);
    } on DioException catch (e) {
      UIUtil.showError(e.error);
    } catch (e) {
      UIUtil.showError('上传失败');
    }
  }

  List<RqReplyList> showTime(List<RqReplyList> messages) {
    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      final prevMessage = i > 0 ? messages[i - 1] : null;
      var messageTime = DateTime.fromMillisecondsSinceEpoch((message.ctime ?? 0).toInt());
      final showTime = prevMessage == null ||
          messageTime.difference(DateTime.fromMillisecondsSinceEpoch((prevMessage.ctime ?? 0).toInt())).inMinutes > 5;

      message.timeStr = showTime ? formatTimestamp(messageTime) : '';
    }
    return messages;
  }

  String formatTimestamp(DateTime timestamp) {
    // final now = DateTime.now();
    // final yesterday = now.subtract(const Duration(days: 1));

    // if (timestamp.year == now.year && timestamp.month == now.month && timestamp.day == now.day) {
    //   return DateFormat('HH:mm').format(timestamp);
    // } else if (timestamp.year == yesterday.year && timestamp.month == yesterday.month && timestamp.day == yesterday.day) {
    //   return '${LocaleKeys.public26.tr} ${DateFormat('HH:mm').format(timestamp)}';
    // } else {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
    // }
  }
}
