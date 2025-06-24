import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/app/widgets/feedback/toast.dart';
import 'package:nt_app_flutter/app/widgets/feedback/dialog.dart';
import 'package:intl/intl.dart';
import '../../../generated/locales.g.dart';

class UIUtil {
  static _showToastCustom(String msg, {required String img}) {
    Widget toast = MyToast(img: img, msg: msg);
    showCustomNotification(Get.context as BuildContext, toast);
    // Get.snackbar('', '',
    //     titleText: const SizedBox(
    //       height: 0,
    //     ),
    //     duration: const Duration(seconds: 2),
    //     animationDuration: const Duration(milliseconds: 300),
    //     messageText: toast,
    //     maxWidth: 343.w,
    //     borderRadius: 6.r,
    //     backgroundColor: Colors.white,
    //     margin: const EdgeInsets.all(0),
    //     padding: EdgeInsets.only(bottom: 5.h, top: 0),
    //     isDismissible: false,
    //     boxShadows: <BoxShadow>[
    //       BoxShadow(
    //         offset: const Offset(0, 8),
    //         blurRadius: 24, //阴影范围
    //         spreadRadius: 0, //阴影浓度
    //         color: AppColor.colorBlack.withOpacity(0.08), //阴影颜色
    //       ),
    //     ]);
  }

  //顶部通用吐司
  static showToast(msg) {
    _showToastCustom(msg, img: 'default/toast_warn'.svgAssets());
  }

  //顶部成功
  static showSuccess(msg) {
    _showToastCustom(msg, img: 'default/toast_success'.svgAssets());
  }

  //顶部错误
  static showError(msg) {
    Get.log('Error message: $msg'); // 打印错误消息
    _showToastCustom(msg, img: 'default/toast_error'.svgAssets());
  }

  //中部Alert 单个按钮
  static showAlert(title,
      {bool isDismissible = false,
      String? content,
      String? confirmText,
      Function? confirmHandler,
      Widget? contentWidget}) {
    return Get.dialog(
        barrierDismissible: isDismissible,
        MyDialog(
          title: title,
          content: content,
          confirmText: confirmText,
          contentWidget: contentWidget,
          confirmHandler: confirmHandler ?? () => {Get.back(result: true)},
        ));
  }

  //中部确认 取消 确认 按钮
  static showConfirm(title,
      {bool isDismissible = false,
      String? content,
      Function? confirmHandler,
      Function? cancelHandler,
      String? confirmText,
      String? cancelText,
      Color? confirmBackgroundColor,
      TextStyle? titleStyle,
      Widget? contentWidget}) {
    return Get.dialog(
        barrierDismissible: isDismissible,
        MyDialog(
          title: title,
          content: content,
          contentWidget: contentWidget,
          confirmHandler: confirmHandler ?? () => {Get.back(result: true)},
          cancelHandler: cancelHandler ?? () => {Get.back(result: false)},
          confirmText: confirmText,
          cancelText: cancelText,
          confirmBackgroundColor: confirmBackgroundColor,
          titleStyle: titleStyle,
        ));
  }

  static void showCustomNotification(BuildContext context, child) {
    late OverlayEntry overlayEntry;
    Timer? dismissTimer;
    bool isTimerPaused = false;
    late AnimationController animationController;

    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: Navigator.of(context),
    );

    void handleDismiss() {
      if (overlayEntry.mounted) {
        animationController.reverse().then((value) {
          overlayEntry.remove();
          animationController.dispose(); // 确保释放控制器资源
        });
      }
    }

    void startDismissTimer() {
      if (!isTimerPaused && (dismissTimer == null || !dismissTimer!.isActive)) {
        dismissTimer = Timer(const Duration(seconds: 2), handleDismiss);
      }
    }

    void cancelDismissTimer() {
      if (dismissTimer != null && dismissTimer!.isActive) {
        dismissTimer?.cancel();
        dismissTimer = null;
      }
    }

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 10,
        right: 10,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(CurvedAnimation(
                  parent: animationController, curve: Curves.easeOut)),
          child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              onDismissed: (_) {
                cancelDismissTimer();
                if (overlayEntry.mounted) {
                  overlayEntry.remove();
                }
              },
              onUpdate: (details) {
                if (details.progress > 0 && !isTimerPaused) {
                  isTimerPaused = true;
                  cancelDismissTimer();
                } else if (details.progress <= 0 && isTimerPaused) {
                  isTimerPaused = false;
                  startDismissTimer();
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  child,
                ],
              )),
        ),
      ),
    );

    if (context.mounted) {
      Overlay.of(context).insert(overlayEntry);
      animationController.forward();
      startDismissTimer();
    }
  }

  static void showDatePicker(
      {required BuildContext context,
      DateTime? initialDate,
      DateTime? minValue,
      DateTime? maxValue,
      required Function(DateTime) onConfirm}) {
    DateTime? dateTime = initialDate ?? DateTime.now();
    final widget = Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kYMD,
          isNumberMonth: true,
          value: initialDate ?? DateTime.now(),
          minValue: DateTime(1950, 1, 1),
          maxValue: DateTime.now(),
        ),
        itemExtent: 40.h,
        height: 200.h,
        selectedTextStyle: AppTextStyle.f_20_600.colorTextPrimary,
        textStyle: AppTextStyle.f_16_400.colorTextTips,
        columnPadding: EdgeInsets.zero,
        onBuilderItem: (BuildContext context, String? text, Widget? child,
            bool selected, int col, int index) {
          List<double> pading = [60, 60, 0];
          return Container(
            alignment: Alignment.center,
            height: 40.h,
            padding: EdgeInsets.only(right: pading[col].w),
            child: Text(
              text ?? '',
              style: selected
                  ? AppTextStyle.f_20_600.colorTextPrimary
                  : AppTextStyle.f_16_400.colorTextTips,
            ),
          );
        },
        selectionOverlay: Container(
          height: 40.h,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColor.colorBorderStrong, width: 1),
              bottom: BorderSide(color: AppColor.colorBorderStrong, width: 1),
            ),
          ),
        ),
        builderHeader: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ).copyWith(top: 20.h),
            height: 48.h,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 73.w,
                      height: 28.h,
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.public2.tr,
                        style: AppTextStyle.f_13_500.colorTextDescription,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.user321.tr,
                    style: AppTextStyle.f_16_600.colorTextPrimary,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      if (dateTime != null) {
                        onConfirm(dateTime!);
                      }
                      Get.back();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColor.bgColorDark,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        LocaleKeys.public1.tr,
                        style: AppTextStyle.f_13_500.colorWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        onSelect: (Picker picker, int index, List<int> selected) {
          dateTime = DateFormat('yyyy-MM-dd').parse(picker.adapter.toString());
        }).makePicker();
    showBSheet(widget);
  }
}
