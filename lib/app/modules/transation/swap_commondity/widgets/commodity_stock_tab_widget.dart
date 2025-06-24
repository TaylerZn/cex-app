import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class CommodityStockTabWidget extends StatelessWidget {
  const CommodityStockTabWidget({super.key, required this.dataArray});
  final List<String> dataArray;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 22.h,
      child: TabBar(
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_12_500,
        unselectedLabelStyle: AppTextStyle.f_12_500,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 2.w, bottom: 0),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: const Color(0xFFF3F3F5),
        ),
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
