import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/dialog/dialog_topWidget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class WithdrawAssetsNetworkSelect extends StatelessWidget {
  const WithdrawAssetsNetworkSelect({
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
          12.verticalSpaceFromWidth,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.w),
            decoration: BoxDecoration(
                color: AppColor.colorBackgroundSecondary,
                borderRadius: BorderRadius.all(Radius.circular(8.r))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyImage('assets/yel_notice'.svgAssets()).marginOnly(top: 4.w),
                10.horizontalSpace,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.assets133.tr,
                        style: AppTextStyle.f_12_400.colorTextDescription)
                  ],
                ))
              ],
            ),
          ),
          24.verticalSpaceFromWidth,
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
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
