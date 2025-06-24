import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/file/file_interface.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/im/chat/models/message.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/ws/core/socket_io.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ChatController extends GetxController with WidgetsBindingObserver {
  final String orderInd;
  CustomerOrderDetailModel? orderState;
  Buyer? me;
  Buyer? other;
  List<C2CMessage> messages = [];
  late SocketIO socketIO;
  late ScrollController scrollController;
  Timer? _timer;
  ChatController({required this.orderInd});

  @override
  void onInit() {
    scrollController = ScrollController();
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    EasyLoading.show();
    await _timerFetchOrderState();
    initMyAndOther();
    await fetchMessageTips();
    EasyLoading.dismiss();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.onClose();
  }

  void sendTextMessage(String value) {
    if (value.isEmpty) return;
    socketSend(value);
  }

  Future<void> sendImageMessage(String value) async {
    /// 上传图片
    try {
      final res = await commonuploadimg(File(value));
      String? fileName = res?.filename;
      if (ObjectUtil.isEmpty(fileName)) {
        return;
      }

      socketSend(fileName!);
    } catch (e) {
      Get.log('error: $e.tosString()');
    }
  }

  void socketSend(String value) {
    C2CMessage message = C2CMessage(
        orderId: orderState?.sequence.toString() ?? '',
        from: me?.uid.toString() ?? '',
        to: other?.uid.toString() ?? '',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        content: value);
    socketIO.send({'message': message.toJson()});
  }
}

extension AppealControllerX on ChatController {
  initMyAndOther() {
    if (orderState == null) return;
    if (orderState?.buyer?.uid == UserGetx.to.user?.info?.id) {
      me = orderState?.buyer;
      other = orderState?.seller;
    } else {
      me = orderState?.seller;
      other = orderState?.buyer;
    }

    /// 用户id拼接字符串，base64
    try {
      String path = '${me?.uid}${other?.uid}';
      // 将字符串转换为字节数组
      Uint8List bytes = utf8.encode(path);

      // 对字节数组进行 Base64 编码
      String base64Encoded = base64Encode(bytes);

      socketIO = SocketIO('${BestApi.getApi().imUrl}/$base64Encoded');
      socketIO.connect();
      socketIO.receive((data) {
        C2CMessage message = C2CMessage.fromJson(data['message']);
        message.chatId = data['chatId'];

        /// 限频消息的提示
        if (message.chatId == 0) {
          UIUtil.showToast(message.content);
          return;
        }
        // print('hhhhhhhhhhhhhh-------收到的消息 ${message.toJson()} -------hhhhhhhhhhdata: ${data.toString()}');

        messages.add(message);
        showTime(messages);
        update();
        Future.delayed(const Duration(milliseconds: 200), () {
          if (isClosed) return;
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      });
    } catch (e) {
      Get.log('error: $e.tosString()');
    }
  }

  /// 订单状态
  Future<void> fetchOrderState() async {
    try {
      final res = await OtcApi.instance().getOrderhWithId(id: orderInd);
      orderState = res;
      orderState?.id = orderInd.toInt();
      update();
    } catch (e) {
      Get.log(e.toString());
    }
  }

  Future _timerFetchOrderState() async {
    _timer?.cancel();
    _timer = null;
    await fetchOrderState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await fetchOrderState();
    });
  }

  /// 商家发布的信息
  Future<void> fetchMessageTips() async {
    int i = 0;
    try {
      if (orderState == null) return;
      final res =
          await OtcApi.instance().chatMsgMessage(orderState!.sequence.toString(), me?.uid.toString(), other?.uid.toString());
      messages = res.map((e) {
        i = i + 1;

        return C2CMessage(
            orderId: e.orderId.toString(),
            from: e.fromId ?? '',
            to: e.toId ?? '',
            content: e.content ?? '',
            chatId: e.chatId ?? 0,
            timestamp: e.ctime);
      }).toList();
      showTime(messages);
      update();
    } catch (e) {
      Get.log(e.toString());
    }
  }

  showTime(List<C2CMessage> messages) {
    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      final prevMessage = i > 0 ? messages[i - 1] : null;
      var messageTime = DateTime.fromMillisecondsSinceEpoch((message.timestamp ?? 0).toInt());
      final showTime = prevMessage == null ||
          messageTime.difference(DateTime.fromMillisecondsSinceEpoch((prevMessage.timestamp ?? 0).toInt())).inMinutes > 5;

      message.timeStr = showTime ? formatTimestamp(messageTime) : '';
    }
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
