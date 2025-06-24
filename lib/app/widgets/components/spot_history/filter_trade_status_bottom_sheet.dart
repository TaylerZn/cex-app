import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_out_line_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../transaction/bottom_sheet/bottom_sheet_util.dart';
import '../transaction/bottom_sheet/common_bottom_sheet.dart';

/// 状态切换

Future<List<Status>?> showTradeStatusBottomSheet(
    { List<Status>? statusList,required List<Status> status}) async {
  // 状态：
  // 0-初始订单
  // 1-新订单
  // 2-完全成交
  // 3-部分成交
  // 4-已撤单
  // 5-待撤单
  // 6-异常订单
  List<Status> statusList1 =  [
    Status(LocaleKeys.trade141.tr, 2), // 已完成
    Status(LocaleKeys.trade125.tr, 4), // 已取消
    Status(LocaleKeys.trade124.tr, 6), // 过期
  ];

  final res = await showBSheet<List<Status>?>(
    StatusBottomSheet(
      title: LocaleKeys.assets125.tr,
      items: statusList ?? statusList1,
      selectedItems: status,
    ),
  );
  if (res == null) {
    return null;
  }
  return res;
}

class StatusBottomSheet extends StatefulWidget {
  const StatusBottomSheet(
      {super.key,
      required this.title,
      required this.items,
      required this.selectedItems});
  final String title;
  final List<Status> items;
  final List<Status> selectedItems;

  @override
  State<StatusBottomSheet> createState() => _StatusBottomSheetState();
}

class _StatusBottomSheetState extends State<StatusBottomSheet> {
  List<Status> selecteds = [];

  @override
  void initState() {
    selecteds = widget.selectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: AppTextStyle.f_20_600.color111111,
              ).marginOnly(bottom: 20.h),
              ListView.separated(
                itemCount: widget.items.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Status status = widget.items[index];
                  return bottomSheetBuildTitle(
                      status.name, selecteds.contains(status), () {
                    if (selecteds.contains(status)) {
                      if (selecteds.length == 1) return;
                      selecteds.remove(status);
                    } else {
                      selecteds.add(status);
                    }
                    setState(() {});
                  });
                },
                separatorBuilder: (BuildContext context, int index) {
                  return 10.verticalSpace;
                },
              ),
            ],
          ),
        ),
        Divider(
          height: 1.h,
          color: AppColor.colorF5F5F5,
        ).marginSymmetric(vertical: 16.h),
        MyOutLineButton(
            title: LocaleKeys.public1.tr,
            onTap: () => Get.back(result: selecteds)),
        16.verticalSpace,
      ],
    );
  }
}

class Status {
  String name;
  int status;

  Status(this.name, this.status);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Status &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          status == other.status;

  @override
  int get hashCode => name.hashCode ^ status.hashCode;
}
