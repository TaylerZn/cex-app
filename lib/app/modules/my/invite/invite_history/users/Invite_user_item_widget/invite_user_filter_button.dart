import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class InviteUserFilterButton extends StatelessWidget {
  const InviteUserFilterButton(
      {super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        side: BorderSide(color: AppColor.colorEEEEEE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      child: Row(
        children: [
          Text(
            title, //LocaleKeys.assets124.tr, //'筛选',
            style: TextStyle(color: AppColor.color333333),
          ),
      SizedBox(width: 12.w),
      MyImage('default/arrow_bottom'.svgAssets(), width: 12.w),
        ],
      ),
    );
  }
}

//筛选按钮的底部弹窗 封装
Future<InvitefilterType?> showUserHistoryFilterTypeBottomSheet({
  required InvitefilterType? orderType,
}) async {
  List<InvitefilterType> orderTypes = [
    InvitefilterType(LocaleKeys.assets108.tr, 1), //全部
    InvitefilterType(LocaleKeys.user298.tr, 2),
    InvitefilterType(LocaleKeys.user299.tr, 3),
    InvitefilterType(LocaleKeys.user300.tr, 4),
    InvitefilterType(LocaleKeys.user301.tr, 5),
  ];

  int selectedIndex = orderTypes.indexWhere((element) => element == orderType);
  if (selectedIndex == -1) {
    selectedIndex = 0;
  }

  final res = await showBSheet<int?>(
    CommonBottomSheet(
      title: null,
      items: orderTypes.map((e) => e.name).toList(),
      selectedIndex: selectedIndex,
    ),
  );
  if (res == null) {
    return null;
  }
  return orderTypes[res];
}

class InvitefilterType {
  String name;
  int? type;

  InvitefilterType(this.name, this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvitefilterType &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}
