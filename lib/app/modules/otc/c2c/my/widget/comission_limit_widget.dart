import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/sales_comission/controllers/sales_comission_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/widget/select_option_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ComissionLimitWidget extends StatefulWidget {
  const ComissionLimitWidget({super.key});

  @override
  State<ComissionLimitWidget> createState() => _ComissionLimitWidgetState();
}

class _ComissionLimitWidgetState extends State<ComissionLimitWidget> {
  List<String> list = [
    LocaleKeys.c2c39.tr,
    LocaleKeys.c2c40.tr,
    LocaleKeys.c2c41.tr
  ];
  final controller = Get.find<SalesComissionController>();

  RxList<int> selectedList = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(LocaleKeys.c2c38.tr, style: AppTextStyle.f_16_600),
        SizedBox(height: 16.h),
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Obx(() => InkWell(
                    onTap: () {
                      if (selectedList.contains(index)) {
                        selectedList.remove(index);
                        controller.formFill.transUserLimit = selectedList;
                        return;
                      }
                      selectedList.add(index);
                      controller.formFill.transUserLimit = selectedList;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.r)),
                          border: Border.all(
                            color: AppColor.colorEEEEEE,
                          )),
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 43.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(list[index])),
                          10.horizontalSpace,
                          SelectOptionWidget(
                            selected: selectedList.contains(index),
                          )
                        ],
                      ),
                    ),
                  ));
            }),
      ],
    );
  }
}
