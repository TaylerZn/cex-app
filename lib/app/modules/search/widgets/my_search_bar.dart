import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({
    Key? key,
    this.text = '',
    this.hintText = '',
    this.onPressed,
  }) : super(key: key);
  final String text;
  final String hintText;
  final Function(String)? onPressed;

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  @override
  void initState() {
    _controller.text = widget.text;
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget back = InkWell(
      child: Text(
        LocaleKeys.public2.tr,
        style: TextStyle(fontSize: 16.sp, color: Color(0xFF707070)),
      ),
      onTap: () {
        _focus.unfocus();
        Navigator.maybePop(context);
      },
    );

    final Widget textField = Expanded(
      child: Container(
          height: 36.w,
          decoration: BoxDecoration(
            color: Color(0xffF7F7F7),
            borderRadius: BorderRadius.circular(6.0),
          ),
          // alignment: Alignment.centerRight,
          child: Row(
            children: [
              SizedBox(width: 10.w),
              MyImage(
                'icon_search'.svgAssets(),
                width: 16.w,
                height: 16.w,
              ),
              SizedBox(width: 10.w),
              Expanded(
                  child: TextField(
                // readOnly: true,
                key: Key('search_text_field'),
                controller: _controller,
                focusNode: _focus,
                textInputAction: TextInputAction.search,
                style: TextStyle(fontSize: 12.sp),
                onSubmitted: (String val) {
                  _focus.unfocus();
                  // 点击软键盘的动作按钮时的回调
                  widget.onPressed?.call(val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  disabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: widget.hintText,
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: Color(0xFFBBBBBB)),
                ),
              )),
              SizedBox(width: 9.w),
              Visibility(
                visible: _controller.text.isNotEmpty,
                child: InkWell(
                  child: Semantics(
                    label: '清空',
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
                      child: Image.asset("home/delete".pngAssets()),
                    ),
                  ),
                  onTap: () {
                    // print('123123123');
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _controller.text = '';
                      });
                    });
                  },
                ),
              ),
              SizedBox(width: 9.w),
            ],
          )),
    );

    return
        //  AnnotatedRegion<SystemUiOverlayStyle>(
        //   value: SystemUiOverlayStyle.light,
        //   child:
        Row(
      children: <Widget>[
        SizedBox(width: 16.w),
        textField,
        SizedBox(width: 16.w),
        back,
        SizedBox(width: 16.w)
      ],
    );
  }
}
