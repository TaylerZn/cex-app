import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/cancel_config_bottom_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'bottom_sheet_util.dart';

class MarginTypeBottomSheet extends StatefulWidget {
  const MarginTypeBottomSheet({super.key, required this.marginModel});

  final int marginModel;

  static Future<int?> show({required int marginModel}) async {
    return await showBSheet<int>(MarginTypeBottomSheet(
      marginModel: marginModel,
    ));
  }

  @override
  State<MarginTypeBottomSheet> createState() => _MarginTypeBottomSheetState();
}

class _MarginTypeBottomSheetState extends State<MarginTypeBottomSheet> {
  int marginModel = 1; // 1: 全仓 2: 逐仓

  @override
  void initState() {
    marginModel = widget.marginModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            Text(
              LocaleKeys.follow96.tr,
              style: TextStyle(
                color: AppColor.color111111,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                    child:
                        _buildBtn(LocaleKeys.trade77.tr, marginModel == 1, () {
                  setState(() {
                    marginModel = 1;
                  });
                })),
                9.horizontalSpace,
                Expanded(
                  child: _buildBtn(
                    LocaleKeys.trade78.tr,
                    marginModel == 2,
                    () {
                      setState(() {
                        marginModel = 2;
                      });
                    },
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              LocaleKeys.trade216.tr,
              style: TextStyle(
                color: AppColor.color333333,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            23.verticalSpace,
            InkWell(
              onTap: () {
                UIUtil.showAlert(
                  LocaleKeys.trade217.tr,
                  content: LocaleKeys.trade218.tr,
                  confirmText: LocaleKeys.trade219.tr,
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    size: 12.sp,
                    color: AppColor.color999999,
                  ),
                  4.horizontalSpace,
                  Text(
                    '${LocaleKeys.trade220.tr}?',
                    style: TextStyle(
                      color: AppColor.color666666,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).marginSymmetric(horizontal: 16.w),
        28.verticalSpace,
        Divider(
          height: 1.w,
          color: AppColor.colorF5F5F5,
        ),
        16.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CancelConfirmBottomButton(
            onCancel: () => Get.back(),
            onConfirm: () => Get.back(result: marginModel),
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}

Widget _buildBtn(String title, bool isSelected, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 44.h,
      alignment: Alignment.center,
      decoration: isSelected
          ? BoxDecoration(
              border: Border.all(color: AppColor.colorBlack, width: 1.w),
              borderRadius: BorderRadius.circular(6.r),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: AppColor.colorF5F5F5,
            ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? AppColor.colorBlack : AppColor.color666666,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
