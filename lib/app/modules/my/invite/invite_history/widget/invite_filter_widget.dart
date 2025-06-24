import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/model/invite_time_filter_type.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class InviteFilterWidget extends StatelessWidget {
  final Function(InviteTimeFilterType) onTimeFilterChanged;
  final Function(String) onCategoryChanged;

  // 响应式变量来存储当前选中的 InviteTimeFilterType 值
  final Rx<InviteTimeFilterType> selectedTimeFilterType =
      InviteTimeFilterType.all.obs;

  // 响应式变量来存储当前选中的分类标签索引
  final RxInt selectedCategoryIndex = 0.obs;

  InviteFilterWidget({
    Key? key,
    required this.onTimeFilterChanged,
    required this.onCategoryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: List.generate(3, (index) {
              return Obx(() => FilterInkWellWidget(
                    label: _getLabelForIndex(index),
                    isSelected: selectedCategoryIndex.value == index,
                    onSelected: () => _onCategorySelected(index),
                  ));
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return InviteUserTimeFilterButton(
                onTap: () {
                  _showUserHistoryFilterTypeBottomSheet(
                    orderType: selectedTimeFilterType.value,
                  ).then((value) {
                    if (value != null) {
                      onTimeFilterChanged(value);
                      selectedTimeFilterType.value = value;
                    }
                  });
                },
                title: selectedTimeFilterType.value.displayString,
              );
            }),
            Expanded(
                child: Obx(
                    () => Text(selectedTimeFilterType.value.formattedTimeRange,
                        style: TextStyle(
                          color: AppColor.color333333,
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                        )))),
          ],
        ),
      ],
    );
  }

  void _onCategorySelected(int index) {
    selectedCategoryIndex.value = index;
    switch (index) {
      case 0:
        onCategoryChanged('');
        break;
      case 1:
        onCategoryChanged('0,1,2,3');
        break;
      case 2:
        onCategoryChanged('4,5');
        break;
      case 3:
        onCategoryChanged('6,7');
        break;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return LocaleKeys.public35.tr;
      case 1:
        return LocaleKeys.user53.tr;
      case 2:
        return LocaleKeys.user280.tr;
      case 3:
        return LocaleKeys.user281.tr;
      default:
        return '';
    }
  }

  //筛选按钮的底部弹窗 封装
  Future<InviteTimeFilterType?> _showUserHistoryFilterTypeBottomSheet({
    required InviteTimeFilterType? orderType,
  }) async {
    List<InviteTimeFilterType> orderTypes = InviteTimeFilterType.values;

    int selectedIndex =
        orderTypes.indexWhere((element) => element == orderType);
    if (selectedIndex == -1) {
      selectedIndex = 0;
    }

    final res = await showBSheet<int?>(
      CommonBottomSheet(
        title: null,
        items: orderTypes.map((e) => e.displayString).toList(),
        selectedIndex: selectedIndex,
      ),
    );
    if (res == null) {
      return null;
    }
    return orderTypes[res];
  }
}

class FilterInkWellWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const FilterInkWellWidget({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: AppColor.colorFFFFFF,
          border: Border.all(
            color: isSelected ? AppColor.color111111 : Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColor.color111111 : AppColor.colorABABAB,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}

class InviteUserTimeFilterButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  InviteUserTimeFilterButton(
      {Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0.h, vertical: 8.0.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(1.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: AppColor.color333333),
            ),
            MyImage('default/arrow_bottom'.svgAssets(), width: 12.w),
          ],
        ),
      ),
    );
  }
}
