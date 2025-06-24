import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/model/invite_time_option_type.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class InviteFilterModel {
  //本周/本月/昨日
  InviteTimeFilterType timeOption;
  int? startTime;
  int? endTime;

  InviteFilterModel({
    this.startTime,
    this.endTime,
    this.timeOption = InviteTimeFilterType.thisWeek,
  }) {
    // 获取当前时间
    DateTime now = DateTime.now();
    // 如果没有提供 startTime 和 endTime，则根据 timeOption 计算默认值
    if (startTime == null || endTime == null) {
      switch (timeOption) {
        case InviteTimeFilterType.yesterday:
          DateTime dayBeforeYesterday = now.subtract(Duration(days: 1));
          DateTime startOfDayBeforeYesterday = DateTime(dayBeforeYesterday.year,
                  dayBeforeYesterday.month, dayBeforeYesterday.day)
              .toUtc();
          DateTime endOfDayBeforeYesterday = DateTime(dayBeforeYesterday.year,
                  dayBeforeYesterday.month, dayBeforeYesterday.day, 23, 59, 59)
              .toUtc();
          startTime =
              (startOfDayBeforeYesterday.millisecondsSinceEpoch).round();
          endTime = (endOfDayBeforeYesterday.millisecondsSinceEpoch).round();
          break;
        case InviteTimeFilterType.thisWeek:
          DateTime sevenDaysAgoStart = DateTime(now.year, now.month, now.day)
              .subtract(Duration(days: 7))
              .toUtc();
          DateTime todayEnd =
              DateTime(now.year, now.month, now.day - 1, 23, 59, 59).toUtc();
          startTime = (sevenDaysAgoStart.millisecondsSinceEpoch).round();
          endTime = (todayEnd.millisecondsSinceEpoch).round();
          break;
        case InviteTimeFilterType.thisMonth:
          DateTime thirtyOneDaysAgoStart =
              DateTime(now.year, now.month, now.day)
                  .subtract(Duration(days: 30))
                  .toUtc();
          DateTime todayEnd =
              DateTime(now.year, now.month, now.day - 1, 23, 59, 59).toUtc();
          startTime = (thirtyOneDaysAgoStart.millisecondsSinceEpoch).round();
          endTime = (todayEnd.millisecondsSinceEpoch).round();
          break;
      }
    }
  }
}

class InviteTimeSelectorController extends GetxController {
  var filterModel = InviteFilterModel().obs;

  void setTimeOption(InviteTimeFilterType? option) {
    if (option != null) {
      filterModel.update((model) {
        model!.timeOption = option;
        _updateDateRange(model);
      });
    }
  }

  void _updateDateRange(InviteFilterModel model) {
    final now = DateTime.now().toUtc();
    final todayStart = DateTime.utc(now.year, now.month, now.day, 0, 0, 0);
    final todayEnd = DateTime.utc(now.year, now.month, now.day, 23, 59, 59);
    DateTimeRange dateRange;

    switch (model.timeOption) {
      case InviteTimeFilterType.yesterday:
        final yesterdayStart = todayStart.subtract(Duration(days: 1));
        final yesterdayEnd = todayEnd.subtract(Duration(days: 1));
        dateRange = DateTimeRange(start: yesterdayStart, end: yesterdayEnd);
        break;
      case InviteTimeFilterType.thisWeek:
        final weekStart = todayStart.subtract(Duration(days: 7));
        dateRange = DateTimeRange(
            start: weekStart, end: todayEnd.subtract(Duration(days: 1)));
        break;
      case InviteTimeFilterType.thisMonth:
        final monthStart = todayStart.subtract(Duration(days: 30));
        dateRange = DateTimeRange(
            start: monthStart, end: todayEnd.subtract(Duration(days: 1)));
        break;
    }

    model.startTime = (dateRange.start.millisecondsSinceEpoch).round();
    model.endTime = (dateRange.end.millisecondsSinceEpoch).round();
  }

  String formatDateRange() {
    final startDateTime =
        MyTimeUtil.timestampToDate(filterModel.value.startTime!, toUtc: true);
    // DateTime.fromMillisecondsSinceEpoch(filterModel.value.startTime!);
    final endDateTime =
        MyTimeUtil.timestampToDate(filterModel.value.endTime!, toUtc: true);
    // DateTime.fromMillisecondsSinceEpoch(filterModel.value.endTime!);
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');

    return '${dateFormat.format(startDateTime)} - ${dateFormat.format(endDateTime)}';
  }

  String timeOptionToString(InviteTimeFilterType option) {
    switch (option) {
      case InviteTimeFilterType.yesterday:
        return LocaleKeys.user305.tr;
      case InviteTimeFilterType.thisWeek:
        return LocaleKeys.user306.tr;
      case InviteTimeFilterType.thisMonth:
        return LocaleKeys.user307.tr;
      default:
        return '';
    }
  }
}

class InviteTimeSelector extends StatelessWidget {
  final InviteFilterModel filterModel;
  final Function(InviteFilterModel) onFilterChanged;

  InviteTimeSelector({
    Key? key,
    required this.filterModel,
    required this.onFilterChanged,
  }) : super(key: key);

  final InviteTimeSelectorController controller =
      Get.put(InviteTimeSelectorController());

  @override
  Widget build(BuildContext context) {
    if (filterModel != null) {
      controller.filterModel.value = filterModel;
      controller.setTimeOption(filterModel.timeOption);
    }

    return Obx(() {
      return Padding(
        padding: EdgeInsets.fromLTRB(16.0.w, 20.0.h, 16.0.w, 18.0.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 替换原先的 DropdownButton 为 CustomDropdown
            Container(
              height: 24.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r), // 添加圆角
                border: Border.all(
                  color: AppColor.colorEEEEEE,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 8.w,right: 8.w),
                child: CustomDropdown(
                  // 这里使用 controller 和 onFilterChanged
                  controller: controller,
                  onFilterChanged: onFilterChanged,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: AppColor.colorF5F5F5,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0.w, 6.0.h, 16.0.w, 6.0.h),
                child: Text(
                  '${controller.formatDateRange()}(UTC+0)',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.color999999,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class CustomDropdown extends StatelessWidget {
  final InviteTimeSelectorController controller;
  final Function(InviteFilterModel) onFilterChanged;

  CustomDropdown({required this.controller, required this.onFilterChanged});

Future<InviteTimeFilterType?> _showCustomPopupMenuBottomSheet({
  required BuildContext context,
  required InviteTimeFilterType? currentSelection,
}) async {
  List<InviteTimeFilterType> options = InviteTimeFilterType.values;

  int selectedIndex = options.indexWhere((element) => element == currentSelection);
  if (selectedIndex == -1) {
    selectedIndex = 0;
  }

  final res = await showBSheet<int?>(
    CommonBottomSheet(
      title: null,
      items: options.map((e) => controller.timeOptionToString(e)).toList(),
      selectedIndex: selectedIndex,
    ),
  );
  if (res == null) {
    return null;
  }
  return options[res];
}

void _showCustomPopupMenu(BuildContext context) async {
  final InviteTimeFilterType? selectedValue = await _showCustomPopupMenuBottomSheet(
    context: context,
    currentSelection: controller.filterModel.value.timeOption,
  );

  if (selectedValue != null) {
    controller.setTimeOption(selectedValue);
    onFilterChanged(controller.filterModel.value);
  }
}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () => _showCustomPopupMenu(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller
                  .timeOptionToString(controller.filterModel.value.timeOption),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            MyImage('default/arrow_bottom'.svgAssets(), width: 12.w),
            // Icon(Icons.arrow_drop_down, size: 13),
          ],
        ),
      );
    });
  }
}
