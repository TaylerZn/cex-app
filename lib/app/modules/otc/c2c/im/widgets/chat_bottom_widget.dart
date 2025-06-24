import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ChatBottomWidget extends StatefulWidget {
  const ChatBottomWidget({super.key, this.onSend, this.onSendImage});
  final ValueChanged<String>? onSend;
  final ValueChanged<String>? onSendImage;

  @override
  _ChatBottomWidgetState createState() => _ChatBottomWidgetState();
}

class _ChatBottomWidgetState extends State<ChatBottomWidget> {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  bool _isShowPic = false;

  @override
  void initState() {
    textEditingController = TextEditingController()..addListener(() {});
    focusNode = FocusNode()
      ..addListener(() {
        if (focusNode.hasFocus) {
          setState(() {
            _isShowPic = false;
          });
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52.h,
          color: AppColor.colorFFFFFF,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  // 选择图片
                  textEditingController.clear();
                  focusNode.unfocus();
                  setState(() {
                    _isShowPic = !_isShowPic;
                  });
                },
                child: Container(
                  width: 56.w,
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: MyImage(
                      _isShowPic
                          ? 'assets/images/otc/c2c/im_pic_close.svg'
                          : 'assets/images/otc/c2c/im_add.png',
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColor.colorF5F5F5,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  margin: EdgeInsets.only(right: 16.w),
                  alignment: Alignment.center,
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: textEditingController,
                    style: TextStyle(fontSize: 14.sp),
                    cursorColor: AppColor.color111111,
                    focusNode: focusNode,
                    onSubmitted: (value) {
                      // 发送消息
                      if (widget.onSend != null) {
                        widget.onSend!(value);
                      }
                      textEditingController.clear();
                      focusNode.unfocus();
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 0, bottom: 0, left: 6.w),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      disabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: '说点什么',
                      hintStyle: TextStyle(
                        color: AppColor.colorABABAB,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isShowPic)
          Container(
            height: 114.h,
            alignment: Alignment.centerLeft,
            color: AppColor.colorF5F5F5,
            padding: EdgeInsets.only(left: 24.w, top: 23.h),
            child: InkWell(
              onTap: () async {
                /// 选择图片
                ImagePicker picker = ImagePicker();
                if (await requestPhotosPermission()) {
                  var res = await picker.pickImage(source: ImageSource.gallery);

                  if (res != null) {
                    if (widget.onSendImage != null) {
                      widget.onSendImage!(res.path);
                      setState(() {
                        _isShowPic = false;
                      });
                    }
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyImage('assets/images/otc/c2c/im_pic.svg'),
                  8.verticalSpace,
                  Text(
                    LocaleKeys.other47.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColor.color999999),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
