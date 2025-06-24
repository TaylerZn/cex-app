import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/post_service.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

void postStatusDialog(value, {SendType sendType = SendType.sendImage}) {
  Get.dialog(
      barrierDismissible: false,
      Center(
          child: SingleChildScrollView(
              child: Container(
        width: 200.w,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: postStatusPage(
          message: value,
          sendType: sendType,
          showCancelButton: true,
          postProgressEnd: () {
            Get.back();
            Get.back();
          },
          postError: () {
            Get.back();
          },
          onCancel: () {},
        ),
      ))));
}

class postStatusPage extends StatefulWidget {
  dynamic message;
  SendType sendType;

  /// 是否展示关闭状态拦按钮
  bool showCancelButton;

  /// 关闭状态拦时间回调
  Function()? onCancel;

  /// 发送失败
  Function()? postError;

  /// 发送成功
  Function()? postSuccess;

  /// 发送百分比 到100%
  Function()? postProgressEnd;

  postStatusPage(
      {Key? key,
      required this.message,
      this.sendType = SendType.sendImage,
      this.showCancelButton = false,
      this.onCancel,
      this.postSuccess,
      this.postError,
      this.postProgressEnd})
      : super(key: key);

  _postStatusPageState? state;

  void showPostStatus(
      {dynamic message, SendType sendType = SendType.sendImage}) {
    if (state != null)
      state!._showPostStatus(message: message, sendType: sendType);
  }

  @override
  _postStatusPageState createState() => state = _postStatusPageState();
}

class _postStatusPageState extends State<postStatusPage> {
  Timer? resendTimer;
  int sendPostNum = 0;
  var sendPostName;
  // ignore: prefer_typing_uninitialized_variables
  var sendPostImage;
  late Timer _rotationTimer;

  double _rotationAngle = 360;

  late final Completer<void>
      _completer; // Add Completer to signal task completion

  @override
  void initState() {
    if (widget.message != null) getValue();
    _completer = Completer<void>(); // Initialize Completer
    startRotation();
    super.initState();
  }

  void startRotation() {
    const duration = Duration(milliseconds: 10);
    _rotationTimer = Timer.periodic(duration, (timer) {
      setState(() {
        _rotationAngle -= 3.0;
        if (_rotationAngle <= 0.0) {
          _rotationAngle = 360.0;
        }
      });
    });
  }

  void _cancelTask() {
    if (!_completer.isCompleted) {
      _completer.completeError(
          "Task cancelled"); // Complete the completer with error to cancel the task
    }
  }

  Future<void> getValue() async {
    var value = widget.message;
    if (widget.sendType == SendType.sendImage) {
      initResendTimer(95);
      if (mounted) setState(() {});
      try {
        await sendPostImageNote(
          value,
          postSuccess: () {
            initResendTimer(100, milliseconds: 100);
            if (widget.postSuccess != null) widget.postSuccess!();
            _completer.complete();
          },
          postError: () {
            sendPostNum = 0;
            if (mounted) setState(() {});
            if (widget.postError != null) widget.postError!();
          },
          imageNoteFirstImage: (imageFile) {
            sendPostImage = imageFile;
            if (mounted) setState(() {});
          },
        );
      } catch (e) {
        _completer.completeError(e);
      }
    } else {
      try {
        initResendTimer(50);
        if (mounted) setState(() {});
        initResendTimer(95);
        if (mounted) setState(() {});
        sendPostVideo(value, postSuccess: () {
          initResendTimer(100, milliseconds: 100);
          if (widget.postSuccess != null) widget.postSuccess!();
          _completer.complete();
        }, postError: () {
          sendPostNum = 0;
          if (mounted) setState(() {});
          if (widget.postError != null) widget.postError!();
        });
      } catch (e) {
        _completer.completeError(e);
      }
    }
  }

  void _showPostStatus(
      {dynamic message, SendType sendType = SendType.sendImage}) {
    widget.message = message;
    widget.sendType = sendType;
    getValue();
  }

//轮询
  initResendTimer(numIndex, {milliseconds = 20}) async {
    resetResendTimer();
    resendTimer =
        Timer.periodic(Duration(milliseconds: milliseconds), (timer) async {
      //轮询获取头部 收益率
      if (mounted) {
        if (sendPostNum >= numIndex) {
          if (sendPostNum == 100) {
            setState(() {
              sendPostNum = 0;
            });
            UIUtil.showSuccess(LocaleKeys.community25.tr);
            if (widget.postProgressEnd != null) widget.postProgressEnd!();
          }
          timer.cancel();
          resendTimer = null;
        } else {
          setState(() {
            sendPostNum += 1;
          });
        }
      }
    });
  }

  resetResendTimer() {
    if (resendTimer != null) {
      resendTimer?.cancel();
      resendTimer = null;
    }
  }

  @override
  void dispose() {
    _cancelTask();
    _rotationTimer.cancel();
    resetResendTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return sendPostNum != 0
        ? Column(
            children: [
              Container(
                height: 138.w,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Transform.rotate(
                        angle: _rotationAngle * 3.14159265359 / 180, // 将角度转为弧度
                        child: MyImage(
                          'community/loading'.pngAssets(),
                          width: 90.w,
                          height: 90.w,
                        )),
                    Positioned(
                        child: Container(
                            width: 90.w,
                            height: 90.w,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$sendPostNum%',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  LocaleKeys.community26.tr,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Color(0xffABABAB),
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )))
                  ],
                ),
              ),
              // Divider(
              //   height: 0.5.w,
              //   color: Color(0xffF5F5FA),
              // ),
              // MyButton(
              //   height: 46.w,
              //   text: LocaleKeys.community27.tr,
              //   textStyle: AppTextStyle.medium_500,
              //   color: AppColor.colorABABAB,
              //   backgroundColor: AppColor.colorWhite,
              //   onTap: () {
              //     _cancelTask();
              //     Get.back();
              //   },
              // )
            ],
          )
        : Container();
  }
}

enum SendType {
  /// 发送视频
  sendVideo,

  /// 发送图片
  sendImage
}
