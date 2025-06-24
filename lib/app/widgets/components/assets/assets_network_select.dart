import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/dialog/dialog_topWidget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_text_style.dart';

class AssetsNetworkSelect extends StatelessWidget {
  const AssetsNetworkSelect({
    Key? key,
    required this.list,
    required this.value,
    required this.isDeposit,
  }) : super(key: key);

  final List list;
  final String value;
  final bool isDeposit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          dialogTopWidget(
              isDeposit ? LocaleKeys.assets39.tr : LocaleKeys.assets96.tr,
              LocaleKeys.assets133.tr),
          SizedBox(height: 29.h),
          _buildList(context),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 300.h),
      child: ListView.separated(
        itemCount: list.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return 16.verticalSpace;
        },
        itemBuilder: (BuildContext context, int index) {
          final item = list[index];
          return InkWell(
            onTap: () {
              Get.back(result: index);
            },
            child: Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                      width: 1,
                      color: item == value
                          ? AppColor.color111111
                          : AppColor.colorBorderGutter)),
              child: Text(
                item,
                style: AppTextStyle.f_15_500.colorTextPrimary,
                textAlign: TextAlign.left,
              ),
            ),
          );
        },
      ),
    );
  }
}
