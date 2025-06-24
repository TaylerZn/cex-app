import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_extended_textfield.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../sales_comission/controllers/sales_comission_controller.dart';

class ComissionReplyWidget extends StatefulWidget {
  final String? title;
  final bool showSwitch;
  final bool switchValue;
  final Function(String?)? onChanged;
  final Function(bool)? onSwitch;
  const ComissionReplyWidget(
      {super.key,
      this.title,
      this.showSwitch = false,
      this.onChanged,
      this.onSwitch,
      this.switchValue = false});
  @override
  State<ComissionReplyWidget> createState() => _ComissionReplyWidgetState();
}

class _ComissionReplyWidgetState extends State<ComissionReplyWidget> {
  final controller = Get.find<SalesComissionController>();
  bool isOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isOpen = controller.formFill.chatAuto == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(LocaleKeys.c2c44.tr, style: AppTextStyle.f_15_500),
            FlutterSwitch(
              width: 37.w,
              height: 20.w,
              toggleSize: 16.w,
              value: isOpen,
              borderRadius: 30.0,
              padding: 2.w,
              activeColor: AppColor.color111111,
              inactiveColor: AppColor.colorDDDDDD,
              onToggle: (val) {
                isOpen = !isOpen;
                controller.formFill.chatAuto = val ? 1 : 0;
                setState(() {});
                widget.onSwitch?.call(val);
              },
            ),
          ],
        ),
        17.h.verticalSpace,
        MyExtendedTextField(
            value: controller.formFill.chatAutoReply,
            maxLength: null,
            onChanged: (val) {
              controller.formFill.chatAutoReply = val;
              widget.onChanged?.call(val);
            })
      ],
    );
  }
}
