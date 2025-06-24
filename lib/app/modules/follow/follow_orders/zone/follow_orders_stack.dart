import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_search_textField.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

// ignore: must_be_immutable
class ImageStackPage extends StatelessWidget {
  ImageStackPage({super.key, this.symbolList});
  final List? symbolList;

  double sizeW = 12.w;
  double offsetW = 8.w;

  double _getImageStackWidth(int imageNumber) {
    return offsetW * (imageNumber - 1) + (imageNumber == 4 ? 20.w : 12.w);
  }

  List<Widget> _getStackItems(List? symbolList) {
    if (symbolList != null && symbolList.isNotEmpty) {
      List<Widget> list = [];
      int count = symbolList.length > 3 ? 3 : symbolList.length;
      for (var i = 0; i < count; i++) {
        double off = symbolList.length > 3 ? (offsetW + offsetW * (count - i)) : (offsetW * (count - i - 1));
        // if (i == count - 1) {
        // list.add(
        //   Container(
        //       height: sizeW,
        //       width: 27.w,
        //       padding: EdgeInsets.symmetric(horizontal: 5.w),
        //       decoration: BoxDecoration(
        //           border: Border.all(width: 1, color: AppColor.colorWhite),
        //           borderRadius: BorderRadius.circular(9.r),
        //           color: AppColor.colorF2F2F2),
        //       alignment: Alignment.center,
        //       child: Text(symbolList.length.toString(), style: AppTextStyle.small3_500.color999999)),
        // );
        // } else {
        list.add(Positioned(
            right: off,
            child: Container(
              width: sizeW,
              height: sizeW,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColor.colorWhite),
                  borderRadius: BorderRadius.circular(99),
                  color: AppColor.colorF2F2F2),
              alignment: Alignment.center,
              child: MarketIcon(
                  iconName: (symbolList[i] as String).split('-').length > 1 ? (symbolList[i] as String).split('-')[1] : '',
                  width: sizeW),
            )));
        // }
      }
      if (symbolList.length > 3) {
        list.add(
          Container(
              height: sizeW,
              width: 23.w,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColor.colorWhite),
                  borderRadius: BorderRadius.circular(9),
                  color: AppColor.colorF2F2F2),
              alignment: Alignment.center,
              child: Text(symbolList.length.toString(), style: AppTextStyle.f_10_500.color999999)),
        );
      }
      return list;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var array = _getStackItems(symbolList);
    return Container(
      // color: Colors.amber,
      height: sizeW,
      width: _getImageStackWidth(array.length),
      alignment: Alignment.topRight,
      child: Stack(
        clipBehavior: Clip.none,
        children: array,
      ),
    );
  }
}

class StockChart extends StatelessWidget {
  const StockChart({super.key, this.profitRateList});
  final List? profitRateList;

  @override
  Widget build(BuildContext context) {
    double maxNumber = double.negativeInfinity;
    double minNumber = double.infinity;
    List<FlSpot> array = [];
    bool haveData = profitRateList != null && profitRateList!.length > 1;
    if (haveData) {
      maxNumber = profitRateList!.reduce((value, element) => value > element ? value : element);

      minNumber = profitRateList!.reduce((value, element) => value < element ? value : element);

      for (var i = 0; i < profitRateList!.length; i++) {
        array.add(FlSpot(i * 1.0, profitRateList![i]));
      }
    }

    return profitRateList != null && profitRateList!.length > 1
        ? LineChart(
            LineChartData(
              // backgroundColor: Colors.amber,
              lineTouchData: const LineTouchData(enabled: false),
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(
                show: false,
              ),
              minX: 0,
              maxX: profitRateList!.length * 1.0 - 1,
              minY: minNumber - 10,
              maxY: maxNumber + 10,
              lineBarsData: [
                LineChartBarData(
                  spots: array,
                  isCurved: true,
                  curveSmoothness: 0.1,
                  color: AppColor.upColor,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColor.upColor.withOpacity(0.3),
                        AppColor.upColor.withOpacity(0.1),
                        AppColor.upColor.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

class FollowStockChart extends StatelessWidget {
  const FollowStockChart({super.key, this.profitRateList});
  final List? profitRateList;

  @override
  Widget build(BuildContext context) {
    double maxNumber = double.negativeInfinity;
    double minNumber = double.infinity;
    List<FlSpot> array = [];
    bool haveData = profitRateList != null && profitRateList!.length > 1;
    if (haveData) {
      maxNumber = profitRateList!.reduce((value, element) => value > element ? value : element);

      minNumber = profitRateList!.reduce((value, element) => value < element ? value : element);

      for (var i = 0; i < profitRateList!.length; i++) {
        array.add(FlSpot(i * 1.0, profitRateList![i]));
      }
    }

    return profitRateList != null && profitRateList!.length > 1
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 38.w,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AutoSizeText('${maxNumber.toStringAsFixed(2)}%',
                        maxLines: 1, minFontSize: 4, style: AppTextStyle.f_9_400.colorABABAB),
                    AutoSizeText('${minNumber.toStringAsFixed(2)}%',
                        maxLines: 1, minFontSize: 4, style: AppTextStyle.f_9_400.colorABABAB),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.w),
                      child: LineChart(
                        LineChartData(
                          // backgroundColor: Colors.amber,
                          lineTouchData: const LineTouchData(enabled: false),
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          minX: 0,
                          maxX: profitRateList!.length * 1.0 - 1,
                          minY: minNumber,
                          maxY: maxNumber,
                          lineBarsData: [
                            LineChartBarData(
                              spots: array,
                              isCurved: true,
                              curveSmoothness: 0.1,
                              color: AppColor.upColor,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.upColor.withOpacity(0.3),
                                    AppColor.upColor.withOpacity(0.1),
                                    AppColor.upColor.withOpacity(0.0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 3.w,
                        left: 0,
                        right: 0,
                        child: CustomPaint(
                            painter: DottedLinePainter(
                          width: 100,
                          height: 1,
                          startY: 0,
                          color: AppColor.colorECECEC,
                          dashWidth: 2,
                          dashSpace: 2,
                        ))),
                    Positioned(
                        bottom: 3.w,
                        left: 0,
                        right: 0,
                        child: CustomPaint(
                            painter: DottedLinePainter(
                          width: 100,
                          height: 1,
                          startY: 0,
                          color: AppColor.colorECECEC,
                          dashWidth: 2,
                          dashSpace: 2,
                        )))
                  ],
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}

class MyFollowDialog extends StatelessWidget {
  const MyFollowDialog(
      {super.key,
      this.isManage = false,
      this.isSingleManage = true,
      required this.textVC,
      this.callback,
      this.linkdesCallback,
      this.title,
      this.des,
      this.des2,
      this.linkdes,
      this.btnEnabled});
  final TextEditingController textVC;
  final Function()? callback;
  final bool isManage;
  final bool isSingleManage;
  final String? title;
  final String? des;
  final String? des2;
  final String? linkdes;
  final Function()? linkdesCallback;
  final RxBool? btnEnabled;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 255.w,
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isManage ? (isSingleManage ? LocaleKeys.follow25.tr : LocaleKeys.follow301.tr) : LocaleKeys.follow26.tr,
                style: AppTextStyle.f_16_600.color333333),
            Container(
              margin: EdgeInsets.only(top: 16.h, bottom: 10.h),
              padding: const EdgeInsets.only(left: 12, right: 10, top: 12, bottom: 8),
              decoration: BoxDecoration(
                color: AppColor.colorF4F4F4,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: SearchTextField(
                    height: 24,
                    controller: textVC,
                    autofocus: true,
                    hintText: title ??
                        (isManage
                            ? (isSingleManage ? LocaleKeys.follow27.tr : LocaleKeys.follow28.tr)
                            : LocaleKeys.follow28.tr),
                    havePrefixIcon: false,
                    haveSuffixIcon: false,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}')),
                    ],
                  )),
                  Text('%', textAlign: TextAlign.right, style: AppTextStyle.f_14_600.color111111)
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '*', style: AppTextStyle.f_12_400.downColor),
                      TextSpan(
                          text: des ?? (isManage ? LocaleKeys.follow29.tr : LocaleKeys.follow30.tr),
                          style: AppTextStyle.f_12_400_15.color999999),
                    ],
                  ),
                ),
                des2 != null
                    ? Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '*', style: AppTextStyle.f_12_400.downColor),
                            TextSpan(text: des2, style: AppTextStyle.f_12_400_15.color999999),
                          ],
                        ),
                      )
                    : const SizedBox(),
                linkdes != null
                    ? InkWell(
                        onTap: () => linkdesCallback?.call(),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: linkdes, style: AppTextStyle.f_12_400_15.color0075FF),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(height: 20.w)
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: btnEnabled == null
                        ? MyButton(
                            text: LocaleKeys.follow31.tr,
                            color: AppColor.colorWhite,
                            textStyle: AppTextStyle.f_14_500,
                            backgroundColor: AppColor.color111111,
                            height: 40.h,
                            onTap: () {
                              callback?.call();
                              Get.back();
                            },
                          )
                        : Obx(() => MyButton(
                              text: LocaleKeys.follow31.tr,
                              color: AppColor.colorWhite,
                              textStyle: AppTextStyle.f_14_500,
                              backgroundColor: btnEnabled!.value ? AppColor.color111111 : AppColor.colorCCCCCC,
                              height: 40.h,
                              onTap: () {
                                if (btnEnabled!.value) {
                                  callback?.call();
                                  Get.back();
                                }
                              },
                            ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

showshieldSheetView(FollowActionType type, {VoidCallback? callback, bool isDismissible = true}) {
  showModalBottomSheet(
    context: Get.context!,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
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
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: ShapeDecoration(
                  color: AppColor.color999999,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                MyImage(
                  type == FollowActionType.shield ? 'flow/follow_cry'.svgAssets() : 'flow/follow_prohibit'.svgAssets(),
                  width: 24.w,
                ),
                SizedBox(width: 8.w),
                Text(type == FollowActionType.shield ? LocaleKeys.follow32.tr : LocaleKeys.follow33.tr,
                    style: AppTextStyle.f_20_500.color111111),
              ],
            ),
            Text(type == FollowActionType.shield ? LocaleKeys.follow34.tr : LocaleKeys.follow35.tr,
                    style: AppTextStyle.f_12_400.color999999)
                .marginOnly(top: 12.h, bottom: 25.h),
            GestureDetector(
              onTap: () {
                // showFollowSureView(callback: callback);
                callback?.call();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 48,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12.h),
                margin: EdgeInsets.only(top: 16.h, bottom: 16.h + MediaQuery.of(context).padding.bottom),
                height: 48.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.color111111),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(type == FollowActionType.shield ? LocaleKeys.follow36.tr : LocaleKeys.public1.tr,
                        style: AppTextStyle.f_16_500.colorWhite),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColor.colorWhite,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
  // MediaQuery.of(context).padding.bottom
}
