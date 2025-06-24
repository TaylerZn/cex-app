import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_enum.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_model.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/widgets/wallet_history_sheet.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class WalletHistoryFilter extends StatelessWidget {
  const WalletHistoryFilter(
      {super.key,
      required this.model,
      required this.onChangeTap,
      this.viewType = WalletHistoryFilterViewType.filterPicker});
  final WalletHistoryFilterModel model;
  final VoidCallback? onChangeTap;
  final WalletHistoryFilterViewType viewType;

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenWidgets;
    switch (this.viewType) {
      case WalletHistoryFilterViewType.filterPicker:
        childrenWidgets = [
          getLeftWidget(),
          SizedBox(width: 9.w),
          Expanded(child: getRightWidget())
        ];
        break;
      case WalletHistoryFilterViewType.timePicker:
        childrenWidgets = [getPickerWidget()];
        break;
      case WalletHistoryFilterViewType.allBtnFilterPicker:
        childrenWidgets = [getAllBtnWidget(), getRightWidget()];
      default:
        childrenWidgets = [
          getLeftWidget(),
          SizedBox(width: 9.w),
          Expanded(child: getRightWidget())
        ];
    }
    return Container(
      color: AppColor.colorWhite,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: childrenWidgets,
      ),
    );
  }

  Widget getAllBtnWidget() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: Get.context!,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (BuildContext context) {
            return getCoinListView(context, model);
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 5.w, right: 6.w, top: 5.h, bottom: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1, color: AppColor.colorEEEEEE)),
        child: Row(
          children: [
            Obx(() => Text(
                model.coin.value.coinName == LocaleKeys.assets108.tr
                    ? LocaleKeys.trade323.tr //全部币种 LocaleKeys.markets10.tr 数字货币
                    : model.coin.value.coinName ?? LocaleKeys.trade323.tr,
                style: AppTextStyle.f_12_500.color333333)),
            // Text('e.topTitle.value', //全部币种 TOOD: 处理下
            //     style: AppTextStyle.small_500.color333333),
            SizedBox(width: 12.w),
            MyImage(
              'trade/entrust_filter_arrow'.svgAssets(),
              width: 12.w,
            )
          ],
        ),
      ),
    );
  }

  Widget getLeftWidget() {
    return Row(
      children: [
        Obx(
          () => MyButton(
            width: 124.w,
            height: 30.h,
            text: MyTimeUtil.getYMDime(model.startTime.value),
            backgroundColor: AppColor.colorF5F5F5,
            color: AppColor.color111111,
            textStyle: AppTextStyle.f_12_400,
            onTap: () async {
              var res = await showWalletHistorySheetView(model,
                  time: model.startTime,
                  bottomType: WalletHistoryBottomType.selStartTimeView);
              print(res);
              if (res == true) {
                onChangeTap!();
              }
            },
          ),
        ),
        Container(
            width: 48.w,
            child: Center(
              child: Text(LocaleKeys.assets78.tr,
                  style: AppTextStyle.f_13_400.colorTextDisabled),
            )),
        Obx(() => MyButton(
              width: 124.w,
              height: 30.h,
              text: MyTimeUtil.getYMDime(model.endTime.value),
              backgroundColor: AppColor.colorF5F5F5,
              color: AppColor.color111111,
              textStyle: AppTextStyle.f_12_400,
              onTap: () async {
                var res = await showWalletHistorySheetView(model,
                    time: model.endTime,
                    bottomType: WalletHistoryBottomType.selEndTimeView);
                if (res == true) {
                  onChangeTap!();
                }
              },
            )),
      ],
    );
  }

  Widget getPickerWidget() {
    return Row(
      children: [
        Obx(
          () => MyButton(
            width: 152.w,
            height: 30.h,
            color: AppColor.color111111,
            text: MyTimeUtil.getYMDime(model.startTime.value),
            backgroundColor: AppColor.colorF5F5F5,
            textStyle: AppTextStyle.f_11_400,
            onTap: () async {
              var res = await showWalletHistorySheetView(model,
                  time: model.startTime,
                  bottomType: WalletHistoryBottomType.selStartTimeView);
              print(res);
              if (res == true) {
                onChangeTap!();
              }
            },
          ),
        ),
        Container(
            width: 39.w,
            child: Center(
              child: Text(LocaleKeys.assets78.tr, style: AppTextStyle.f_12_400),
            )),
        Obx(() => MyButton(
              width: 152.w,
              height: 30.h,
              text: MyTimeUtil.getYMDime(model.endTime.value),
              backgroundColor: AppColor.colorF5F5F5,
              color: AppColor.color111111,
              textStyle: AppTextStyle.f_11_400,
              onTap: () async {
                var res = await showWalletHistorySheetView(model,
                    time: model.endTime,
                    bottomType: WalletHistoryBottomType.selEndTimeView);
                print(res);
                if (res == true) {
                  onChangeTap!();
                }
              },
            )),
      ],
    );
  }

  Widget getRightWidget() {
    return InkWell(
        onTap: () async {
          var res = await showWalletHistorySheetView(model,
              bottomType: WalletHistoryBottomType.defaultView);
          if (res == true) {
            onChangeTap!(); //时间筛选图标响应
          }
        },
        child: Container(
            width: 32.w,
            height: 30.h,
            // margin: EdgeInsets.only(left: 7.w),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColor.colorEEEEEE),
                borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: MyImage(
                'assets/filter'.svgAssets(),
                width: 14.w,
                color: AppColor.color111111,
              ),
            )));

    // model.rightModel?.rightBtn != null
    //     ? GestureDetector(
    //         onTap: () {
    //           print('全部撤销');
    //         },
    //         child: Container(
    //           padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(4),
    //               border: Border.all(width: 1, color: AppColor.colorBlack)),
    //           child: Text(model.rightModel!.rightBtn!,
    //               style: TextStyle(
    //                 fontSize: 12.sp,
    //                 color: AppColor.color111111,
    //                 fontWeight: FontWeight.w400,
    //               )),
    //         ),
    //       )
    //     : model.rightModel?.rightText != null
    //         ? Text(model.rightModel!.rightText!,
    //             style: TextStyle(
    //               fontSize: 11.sp,
    //               color: AppColor.color666666,
    //               fontWeight: FontWeight.w400,
    //             ))
    //         : GestureDetector(
    //             onTap: () {
    //               showBottomSheetView(model.rightModel!,
    //                   bottomType: BottomViewType.dateView);
    //             },
    //             child: model.rightModel?.rightIcon != null
    //                 ? Icon(
    //                     model.rightModel!.rightIcon!,
    //                     size: 14,
    //                   )
    //                 : const SizedBox(),
    //           );
  } //右侧filter 按钮

  Widget getBottomWidget() {
    return const SizedBox();
  }

  Widget getCoinListView(BuildContext context, WalletHistoryFilterModel model) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(LocaleKeys.public2.tr,
                          style: AppTextStyle.f_14_500.color4D4D4D))),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Get.back();
                    onChangeTap!();
                  },
                  child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(LocaleKeys.public1.tr,
                          style: AppTextStyle.f_14_500.color4D4D4D))),
            ],
          ),
          Container(
              height: 176.w,
              color: AppColor.colorWhite,
              margin: EdgeInsets.only(
                  bottom: 16.h + MediaQuery.of(context).padding.bottom),
              child: CupertinoPicker(
                  itemExtent: 32.0, // 高度，每个选项的高度
                  backgroundColor: CupertinoColors.white,
                  scrollController: FixedExtentScrollController(
                    initialItem: model.coinIndex.value,
                  ),
                  onSelectedItemChanged: (int index) {
                    model.coinIndex.value = index;
                  },
                  children: List<Widget>.generate(model.tradeCoinList.length,
                      (index) {
                    var item = model.tradeCoinList[index];
                    return Center(
                        child: Text(
                      item.coinName ?? '--',
                      style: AppTextStyle.f_18_500,
                    ));
                  })))
        ],
      ),
    );
  }
}
