import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';

//

class EntrustTabbar extends StatelessWidget {
  const EntrustTabbar(
      {super.key,
      required this.dataArray,
      required this.controller,
      this.haveTopBorder = true,
      this.haveBottomBorder = true,
      this.isCenter = false});
  final List<String> dataArray;
  final bool haveTopBorder;
  final bool haveBottomBorder;
  final bool isCenter;

  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: AppColor.colorWhite,
        // color: Colors.red,
        border: Border(
          bottom: BorderSide(
              width: 0.5,
              color:
                  haveBottomBorder ? AppColor.colorEEEEEE : Colors.transparent),
        ),
      ),
      alignment: isCenter ? Alignment.center : null,
      height: 40.h,
      width: haveBottomBorder ? double.infinity : null,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_13_500,
        unselectedLabelStyle: AppTextStyle.f_13_500,
        indicator: MyUnderlineTabIndicator(
            borderSide: BorderSide(width: 2.h, color: AppColor.color111111)),
        labelPadding: EdgeInsets.only(
            right: isCenter ? 45 : 24,
            top: 0,
            bottom: 0),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
