import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_extended_textfield.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../sales_comission/controllers/sales_comission_controller.dart';

class ComissionDescWidget extends StatefulWidget {
  final String? title;
  final bool showSwitch;
  final bool switchValue;
  final Function(String?)? onChanged;
  final Function(bool)? onSwitch;
  const ComissionDescWidget(
      {super.key,
      this.title,
      this.showSwitch = false,
      this.onChanged,
      this.onSwitch,
      this.switchValue = false});

  @override
  State<ComissionDescWidget> createState() => _ComissionDescWidgetState();
}

class _ComissionDescWidgetState extends State<ComissionDescWidget> {
  final controller = Get.find<SalesComissionController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.c2c42.tr, style: AppTextStyle.f_15_500),
        16.h.verticalSpace,
        MyExtendedTextField(
            value: controller.formFill.transDescription,
            maxLength: 500,
            onChanged: (val) {
              controller.formFill.transDescription = val;
              widget.onChanged?.call(val);
            })
      ],
    );
  }
}
