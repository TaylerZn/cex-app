import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_enum.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_model.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../assets_transfer/enums/account_enums.dart';
import '../../assets_transfer/models/account_enums.dart';

//

Future showWalletHistorySheetView(
  WalletHistoryFilterModel model, {
  WalletHistoryBottomType? bottomType,
  time,
}) async {
  WalletHistoryFilterModel changeModel = model.clone();
  return Get.bottomSheet(
    CustomBottomSheet(
        model: model,
        bottomType: bottomType,
        time: time,
        changeModel: changeModel),
    isScrollControlled: true,
  );
  // showModalBottomSheet(
  //   context: Get.context!,
  //   isScrollControlled: true,
  //   useSafeArea: true,
  //   builder: (BuildContext context) {
  //     return CustomBottomSheet(
  //         model: model, bottomType: bottomType, time: time);
  //   },
  // );
}

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet({
    super.key,
    required this.model,
    required this.bottomType,
    required this.time,
    required this.changeModel,
  });

  final WalletHistoryFilterModel model;
  final WalletHistoryFilterModel changeModel;
  final WalletHistoryBottomType? bottomType;
  final time;

  //复用 划转的model
  final List<AssetsTransferItemModel> list = [
    //跟单账户
    AssetsTransferItemModel(
        id: 0,
        name: LocaleKeys.assets56.tr,
        request: 'follow',
        supportIdList: [1, 2, 3]),
    //标准合约账户
    AssetsTransferItemModel(
        id: 1,
        name: LocaleKeys.assets75.tr,
        request: 'standard',
        supportIdList: [0, 2, 3]),
    //永续合约账户
    AssetsTransferItemModel(
        id: 2,
        name: LocaleKeys.assets76.tr,
        request: 'contract',
        supportIdList: [0, 1, 3]),
    //现货账户
    AssetsTransferItemModel(
        id: 3,
        name: LocaleKeys.assets94.tr,
        request: 'wallet',
        c2cRequest: '1',
        supportIdList: [0, 1, 2, 4]),
    //资金账户
    AssetsTransferItemModel(
        id: 4,
        name: LocaleKeys.assets143.tr,
        request: 'otc',
        c2cRequest: '2',
        supportIdList: [3]),
  ];

  @override
  Widget build(BuildContext context) {
    var type = bottomType ?? model.bottomType;

    switch (type) {
      case WalletHistoryBottomType.selStartTimeView:
        return getTimeView(
            context, time, WalletHistoryTimePickerType.selStartTime);
      case WalletHistoryBottomType.selEndTimeView:
        return getTimeView(
            context, time, WalletHistoryTimePickerType.selEndTime);
      case WalletHistoryBottomType.selectView:
        return getAssetsView(context);
      default:
        return getDefaultView(context);
    }
  }

  Widget getDefaultView(BuildContext context) {
    // WalletHistoryFilterModel changeModel = model.copyWith();

    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only( top: 24.w,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleKeys.assets124.tr, //筛选
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ).marginOnly(left: 16.w,right: 16.w),
          Obx(() => changeModel.actionArray.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
                      child: Text(LocaleKeys.assets125.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.color999999,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Wrap(
                        spacing: 16.w,
                        runSpacing: 6.h,
                        children: List.generate(changeModel.actionArray.length,
                            (index) {
                          var item = changeModel.actionArray[index];
                          return GestureDetector(
                              onTap: () {
                                changeModel.actionArrayIndex.value = index;
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          width: 1.w,
                                          color: index ==
                                                  changeModel
                                                      .actionArrayIndex.value
                                              ? AppColor.color111111
                                              : AppColor.colorEEEEEE)),
                                  child: Text(
                                    item.name,
                                    style: AppTextStyle.f_14_400.copyWith(
                                        color: index ==
                                                changeModel
                                                    .actionArrayIndex.value
                                            ? AppColor.color111111
                                            : AppColor.colorABABAB),
                                  )));
                        }))
                  ],
                ).marginOnly(left: 16.w,right: 16.w)
              : changeModel.type == WalletHistoryType.transfer
                  ? getFromToTransferView(context, changeModel) //划转账户选择
                  : 0.horizontalSpace),
          Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 16.h,left: 16.w,right: 16.w),
            child: Text(LocaleKeys.assets126.tr, //日期
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.color999999,
                  fontWeight: FontWeight.w400,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Expanded(
                    child: MyButton(
                      height: 36.h,
                      text: MyTimeUtil.getYMDime(changeModel.startTime.value),
                      backgroundColor: AppColor.colorF5F5F5,
                      color: AppColor.color111111,
                      textStyle: AppTextStyle.f_14_500,
                      onTap: () async {
                        showWalletHistorySheetView(changeModel,
                            time: changeModel.startTime,
                            bottomType:
                                WalletHistoryBottomType.selStartTimeView);
                      },
                    ),
                  )),
              Container(
                  width: 35.w,
                  child: Center(
                    child: Text(LocaleKeys.assets78.tr, //到
                        style: AppTextStyle.f_14_500.color999999),
                  )),
              Obx(() => Expanded(
                      child: MyButton(
                    height: 36.h,
                    text: MyTimeUtil.getYMDime(changeModel.endTime.value),
                    backgroundColor: AppColor.colorF5F5F5,
                    color: AppColor.color111111,
                    textStyle: AppTextStyle.f_14_500,
                    onTap: () async {
                      await showWalletHistorySheetView(changeModel,
                          time: changeModel.endTime,
                          bottomType: WalletHistoryBottomType.selEndTimeView);
                    },
                  ))),
            ],
          ).marginOnly(left: 16.w,right: 16.w),
          getCoinView(context, changeModel.type).marginOnly(left: 16.w,right: 16.w),
          const Divider(height: 1,color: AppColor.colorBorderGutter),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.w),
                  child: MyButton(
                    text: LocaleKeys.public2.tr,
                    backgroundColor: AppColor.colorFFFFFF,
                    color: AppColor.color111111,
                    height: 48.w,
                    border: Border.all(width: 1, color: AppColor.color111111),
                    borderRadius: BorderRadius.circular(100.r),
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.color111111,
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.w),
                  child: MyButton(
                    text: LocaleKeys.public1.tr,
                    backgroundColor: AppColor.color111111,
                    color: AppColor.colorWhite,
                    height: 48.w,
                    borderRadius: BorderRadius.circular(100.r),
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.colorWhite,
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: () {
                      Get.back(result: true);
                      model.updateFrom(changeModel);
                      print(model);
                    },
                  ),
                ),
              ),
            ],
          ).marginOnly(left: 16.w,right: 16.w),
          Get.mediaQuery.viewPadding.bottom.verticalSpace,
        ],
      ),
    );
  }

  Widget getCoinView(BuildContext context, WalletHistoryType type) {
    switch (type) {
      case WalletHistoryType.topUp:
      case WalletHistoryType.withdrawal:
      case WalletHistoryType.conver:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h, bottom: 16.h),
              child: Text(
                  type == WalletHistoryType.conver
                      ? LocaleKeys.markets10.tr // 数字货币
                      : LocaleKeys.assets127.tr, //交易币种
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.color999999,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: Get.context!,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return getCoinListView(context, changeModel);
                    },
                  );
                },
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.only(bottom: 28.h),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.colorF5F5F5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(changeModel.coin.value.coinName ?? '--',
                            style: AppTextStyle.f_14_500.color111111),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 14.w,
                        color: AppColor.color666666,
                      ),
                    ],
                  ),
                ))
          ],
        );
      case WalletHistoryType.spotTrading:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h, bottom: 16.h),
              child: Text(LocaleKeys.assets128.tr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.color999999,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: Get.context!,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return getCoinPairView(context, changeModel);
                    },
                  );
                },
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.only(bottom: 28.h),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.colorF5F5F5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(changeModel.coinPair.value.showName,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.color333333,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 14.w,
                        color: AppColor.color666666,
                      ),
                    ],
                  ),
                ))
          ],
        );
      default:
        return 0.horizontalSpace;
    }
  }

  Widget getAssetsView(BuildContext context) {
    var height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        74;
    var containH = 164.w + model.actionArray.length * 44.w;
    return Container(
      height: containH < height ? containH : height,
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
          Container(
            height: 32.h,
            margin:
                EdgeInsets.only(top: 32.h, bottom: 15.h, left: 16, right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.colorF5F5F5),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 14.w,
                  color: AppColor.color666666,
                ),
                Text(LocaleKeys.assets63.tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.color333333,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 48.w,
              alignment: Alignment.center,
              margin: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 1, color: AppColor.colorABABAB)),
              child: Text(LocaleKeys.public2.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTimeView(
    BuildContext context,
    Rx<DateTime>? time,
    WalletHistoryTimePickerType pickerTimeType,
  ) {
    // DateTime dayDataTime = model.startTime;
    DateTime? dataTime;
    final widget = Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kYMD,
          isNumberMonth: true,
          minValue: pickerTimeType == WalletHistoryTimePickerType.selEndTime
              ? model.startTime.value
              : DateTime(2020, 1, 1),
          maxValue: pickerTimeType == WalletHistoryTimePickerType.selStartTime
              ? model.endTime.value
              : DateTime.now(),
        ),
        itemExtent: 40.h,
        height: 240.h,
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
            color: AppColor.bgColorLight,
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
                      if (dataTime != null) {
                        time?.value = dataTime!;
                      }
                      Get.back(result: true);
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
          DateTime selectedDate =
              DateFormat('yyyy-MM-dd').parse(picker.adapter.toString());
          // 如果是选择结束时间，将时间设置为当天的末尾
          if (pickerTimeType == WalletHistoryTimePickerType.selEndTime) {
            dataTime = DateTime(selectedDate.year, selectedDate.month,
                selectedDate.day, 23, 59, 59);
          } else {
            dataTime = selectedDate;
          }
        }).makePicker();
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: widget);
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
                  itemExtent: 32.0,
                  // 高度，每个选项的高度
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

  Widget getCoinPairView(BuildContext context, WalletHistoryFilterModel model) {
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
                  itemExtent: 32.0,
                  // 高度，每个选项的高度
                  backgroundColor: CupertinoColors.white,
                  scrollController: FixedExtentScrollController(
                    initialItem: model.coinPairIndex.value,
                  ),
                  onSelectedItemChanged: (int index) {
                    model.coinPair.value = AssetsGetx.to.coinPairList[index];
                    model.coinPairIndex.value = index;
                  },
                  children: List<Widget>.generate(
                      AssetsGetx.to.coinPairList.length, (index) {
                    var item = AssetsGetx.to.coinPairList[index];
                    return Center(
                        child: Text(
                      item.showName,
                      style: AppTextStyle.f_18_500,
                    ));
                  })))
        ],
      ),
    );
  }

  // 划转账户选择
  Widget getFromToTransferView(
      BuildContext context, WalletHistoryFilterModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 19.h, bottom: 16.h),
          child: Text(LocaleKeys.assets77.tr, //从
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColor.color999999,
                fontWeight: FontWeight.w400,
              )),
        ),
        InkWell(
            onTap: () {
              showTransferTypeSheetView(
                  context, model, AssetsTransferAccountEnum.from);
            },
            child: Container(
              height: 40.h,
              margin: EdgeInsets.only(bottom: 28.h),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColor.colorF5F5F5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                        list
                            .firstWhere(
                              (item) =>
                                  item.request == model.transferTypeFrom.value,
                              orElse: () => list[4], // 如果未找到匹配项，返回 现货
                            )
                            .name,
                        style: AppTextStyle.f_14_500.color111111),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 14.w,
                    color: AppColor.color666666,
                  ),
                ],
              ),
            )),
        Padding(
          padding: EdgeInsets.only(top: 14.h),
          child: Text(LocaleKeys.assets78.tr,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColor.color999999,
                fontWeight: FontWeight.w400,
              )),
        ),
        InkWell(
            onTap: () {
              showTransferTypeSheetView(
                  context, model, AssetsTransferAccountEnum.to);
            },
            child: Container(
              height: 40.h,
              margin: EdgeInsets.only(bottom: 28.h),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColor.colorF5F5F5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                        list
                            .firstWhere(
                              (item) =>
                                  item.request == model.transferTypeTo.value,
                              orElse: () => list[0], // 如果未找到匹配项，返回 跟单
                            )
                            .name,
                        style: AppTextStyle.f_14_500.color111111),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 14.w,
                    color: AppColor.color666666,
                  ),
                ],
              ),
            )),
      ],
    );
  }

  // 弹出选划转择账户类型
  showTransferTypeSheetView(BuildContext context,
      WalletHistoryFilterModel model, AssetsTransferAccountEnum type) {
    showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(LocaleKeys.assets83.tr,
                        style: AppTextStyle.f_20_600.color111111),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              GetBuilder<AssetsGetx>(builder: (assetsGetx) {
                var list = getSelFilteredList(type, model);
                return Container(
                    constraints: BoxConstraints(maxHeight: 300.h),
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: getSelFilteredList(type, model).length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (type == AssetsTransferAccountEnum.from) {
                              model.transferTypeFrom.value =
                                  list[index].request;
                            } else {
                              model.transferTypeTo.value = list[index].request;
                            }
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: (list[index].request ==
                                        (type == AssetsTransferAccountEnum.from
                                            ? model.transferTypeFrom.value
                                            : model.transferTypeTo.value))
                                    ? AppColor.colorF5F5F5
                                    : Colors.transparent),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${list[index].name}',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: AppColor.color111111,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  (list[index].request ==
                                          (type ==
                                                  AssetsTransferAccountEnum.from
                                              ? model.transferTypeFrom.value
                                              : model.transferTypeTo.value))
                                      ? const Icon(Icons.check)
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ));
              }),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        );
      },
    );
    // MediaQuery.of(context).padding.bottom
  }

  // List<AssetsTransferItemModel> getFilteredList(
  //     AssetsTransferAccountEnum type, WalletHistoryFilterModel model) {
  //   List<AssetsTransferItemModel> filteredList = List.from(list);
  //
  //   if (type == AssetsTransferAccountEnum.from) {
  //     filteredList
  //         .removeWhere((item) => item.request == model.transferTypeTo.value);
  //   } else {
  //     filteredList
  //         .removeWhere((item) => item.request == model.transferTypeFrom.value);
  //   }
  //
  //   return filteredList;
  // }

  List<AssetsTransferItemModel> getSelFilteredList(
      AssetsTransferAccountEnum type, WalletHistoryFilterModel model) {
    List<AssetsTransferItemModel> filteredList = [];

    switch (type) {
      case AssetsTransferAccountEnum.from:
        var toItem = list.firstWhere(
            (item) => item.request == model.transferTypeTo.value,
            orElse: () => list[4]);
        filteredList = list
            .where((item) => toItem.supportIdList.contains(item.id))
            .toList();

        break;
      case AssetsTransferAccountEnum.to:
        var fromItem = list.firstWhere(
            (item) => item.request == model.transferTypeFrom.value,
            orElse: () => list[4]);
        filteredList = list
            .where((item) => fromItem.supportIdList.contains(item.id))
            .toList();

        break;
    }

    return filteredList;
  }
}
