import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

import '../../../../config/theme/app_color.dart';

class PercentPickerWidget extends StatelessWidget {
  const PercentPickerWidget(
      {super.key, required this.percent, required this.onValueChanged});

  final double percent;
  final ValueChanged<double> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [0.25, 0.5, 0.75, 1.00]
          .map((e) => _buildBtn('${(e * 100).toInt()}%', e == percent, () {
                onValueChanged(e);
              }))
          .toList(),
    );
  }

  Widget _buildBtn(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 39.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.color111111 : AppColor.colorEEEEEE,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(6.w),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.f_12_500.copyWith(
            color: isSelected ? AppColor.color111111 : AppColor.colorABABAB,
          ),
        ),
      ),
    );
  }
}
