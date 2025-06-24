import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';
import '../transaction/bottom_sheet/bottom_sheet_util.dart';
import '../transaction/cancel_config_bottom_button.dart';

class FilterDateTimeBottomSheet extends StatefulWidget {
  const FilterDateTimeBottomSheet({super.key, required this.dateType});

  final DateType dateType;

  static Future<DateType?> show({required DateType dateType}) async {
    return await showBSheet<DateType?>(
      FilterDateTimeBottomSheet(
        dateType: dateType,
      ),
    );
  }

  @override
  State<FilterDateTimeBottomSheet> createState() =>
      _FilterDateTimeBottomSheetState();
}

class _FilterDateTimeBottomSheetState extends State<FilterDateTimeBottomSheet> {
  DateType _dateType = DateType(LocaleKeys.trade40.tr, 1);

  List<DateType> dateTypeList = [
    DateType(LocaleKeys.trade126.tr, 0),
    DateType(LocaleKeys.trade127.tr, 1),
    DateType(LocaleKeys.trade128.tr, 2),
    DateType(LocaleKeys.trade129.tr, 3),
  ];

  @override
  void initState() {
    _dateType = widget.dateType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            Text(
              LocaleKeys.trade159.tr,
              style: AppTextStyle.f_20_600.color111111,
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: dateTypeList
                  .map((e) => buildTitle(e.title, e.type == _dateType.type, () {
                        setState(() {
                          _dateType = e;
                        });
                      }))
                  .toList(),
            ),
          ],
        ).marginSymmetric(horizontal: 16.w),
        20.verticalSpace,
        Divider(
          height: 1.h,
          color: AppColor.colorF5F5F5,
        ),
        CancelConfirmBottomButton(onCancel: () {
          Get.back();
        }, onConfirm: () {
          Get.back(result: _dateType);
        }).marginAll(16.w),
      ],
    );
  }

  Widget buildTitle(String title, bool isSelected, VoidCallback onTap) {
    return MyButton(
      onTap: onTap,
      height: 32.h,
      width: 78.w,
      border: Border.all(
        color: isSelected ? AppColor.color111111 : AppColor.colorF5F5F5,
        width: 1.w,
      ),
      backgroundColor: AppColor.colorAlwaysWhite,
      text: title,
      color: AppColor.colorTextPrimary,
      textStyle: AppTextStyle.f_13_500,
    );
  }
}

class DateType {
  final String title;
  final int type;

  DateType(this.title, this.type);

  List<int> getStartTimeEndTime() {
    /// 获取当天的开始时间和结束时间
    DateTime now = DateTime.now();

    switch (type) {
      case 0:
        return [
          now.subtract(const Duration(days: 1)).millisecondsSinceEpoch,
          now.millisecondsSinceEpoch
        ];
      case 1:
        return [
          now.subtract(const Duration(days: 7)).millisecondsSinceEpoch,
          now.millisecondsSinceEpoch
        ];
      case 2:
        return [
          now.subtract(const Duration(days: 30)).millisecondsSinceEpoch,
          now.millisecondsSinceEpoch
        ];
      case 3:
        return [
          now.subtract(const Duration(days: 90)).millisecondsSinceEpoch,
          now.millisecondsSinceEpoch
        ];
      default:
        return [
          now.subtract(const Duration(days: 1)).millisecondsSinceEpoch,
          now.millisecondsSinceEpoch
        ];
    }
  }
}
