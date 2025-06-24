import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/controllers/entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_enum.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_bottomSheet.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:sliver_tools/sliver_tools.dart';

//

class EntrustFilter extends StatelessWidget {
  EntrustFilter({super.key, required this.model, required this.controller});
  final TransactionModel model;
  final EntrustController controller;

  final desStyle = TextStyle(
    fontSize: 12.sp,
    color: AppColor.color999999,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        height: 45.h + boundingTextSize(model.desText, desStyle),
        color: AppColor.colorWhite,
        // color: Colors.red,
        padding: EdgeInsets.only(left: 16, right: 16, top: 12.h, bottom: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [getLeftWidget(), getRightWidget()],
            ),
            getBottomWidget()
          ],
        ),
      ),
    );
  }

  Widget getLeftWidget() {
    return model.filterModelArray != null
        ? Row(
            children: model.filterModelArray!
                .map((e) => GestureDetector(
                      onTap: () {
                        showBottomSheetView(e);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.h, vertical: 6.h),
                        margin: EdgeInsets.only(right: 6.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                width: 1, color: AppColor.colorF5F5F5)),
                        child: Row(
                          children: [
                            Obx(() => Text(e.topTitle.value,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.color333333,
                                  fontWeight: FontWeight.w500,
                                ))),
                            SizedBox(width: 6.w),
                            MyImage(
                              'trade/entrust_filter_arrow'.svgAssets(),
                              width: 12.w,
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          )
        : const SizedBox();
  }

  Widget getRightWidget() {
    return model.rightModel?.rightBtn != null
        ? GestureDetector(
            onTap: () {
              controller.cancelAllOrder();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 1,
                  color: AppColor.colorBorderStrong,
                ),
              ),
              child: Text(model.rightModel!.rightBtn!,
                  style: AppTextStyle.f_12_400.color111111),
            ),
          )
        : model.rightModel?.rightText != null
            ? Text(model.rightModel!.rightText!,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColor.color666666,
                  fontWeight: FontWeight.w400,
                ))
            : GestureDetector(
                onTap: () {
                  showBottomSheetView(model.rightModel!,
                      bottomType: BottomViewType.dateView);
                },
                child: model.rightModel?.rightIcon != null
                    ? Container(
                        width: 32.w,
                        height: 24.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFEEEEEE)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Center(
                          child: MyImage(
                            'assets/filter'.svgAssets(),
                            width: 14.w,
                            height: 14.w,
                          ),
                        ),
                      )
                    : const SizedBox(),
              );
  }

  Widget getBottomWidget() {
    return model.desText != null
        ? Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Text(model.desText!, style: desStyle),
          )
        : const SizedBox();
  }

  double boundingTextSize(String? text, TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (model.desText == null) {
      return 0;
    } else {
      final TextPainter textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(text: text, style: style),
          maxLines: maxLines)
        ..layout(maxWidth: maxWidth);
      return textPainter.size.height + 36;
    }
  }
}
