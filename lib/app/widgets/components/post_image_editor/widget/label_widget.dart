import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class LabelWidget extends StatefulWidget {
  ///标签名字
  final String name;

  ///圆圈大小
  final double circleSize;

  ///标签高度
  final double labelHeight;

  LabelWidget({
    Key? key,
    required this.name,
    this.circleSize = 12.0,
    this.labelHeight = 20.0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LabelWidgetState();
  }
}

class LabelWidgetState extends State<LabelWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return tagLabel(widget.name);
  }

  Widget tagLabel(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24.w,
          height: 20.w,
          child: MyImage(
            'icon_remark_left'.svgAssets(),
            width: 24.w,
            height: 20.w,
            fit: BoxFit.fill,
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
              height: widget.labelHeight,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 2, right: 5.5.w),
              decoration: BoxDecoration(
                color: Color(0xff4D4D4D66).withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
