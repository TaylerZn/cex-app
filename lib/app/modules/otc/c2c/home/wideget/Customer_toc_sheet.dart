import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/b2c/order_currency_fiat.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_search_textField.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

showB2CSheetView(B2CChannelModel model, num textFieldNum, String? symbol, Function(int) back) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: CustomB2CBottomSheet(model: model, textFieldNum: textFieldNum, symbol: symbol ?? '', callback: back),
        ),
      );
    },
  );
}

showCustomerTocSheetView(CustomerTocRequestModel model, {CustomerSheetType bottomType = CustomerSheetType.coinType}) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: CustomBottomSheet(
            model: model,
            type: bottomType,
          ),
        ),
      );
    },
  ).then((result) {
    if (bottomType == CustomerSheetType.filterType) {
      if (result == null) {
        model.filter.paymentsList.value = List.from(model.paymentsList);
      }
    }
  });
}

class CustomB2CBottomSheet extends StatelessWidget {
  const CustomB2CBottomSheet({super.key, required this.model, required this.textFieldNum, required this.symbol, this.callback});
  final B2CChannelModel model;

  final num textFieldNum;
  final String symbol;
  final Function(int)? callback;

  @override
  Widget build(BuildContext context) {
    return getDefaultView(context);
  }

  Widget getDefaultView(BuildContext context) {
    var height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 74;
    var containH = 134.w + model.payTypeList!.length * 78.w;
    return Container(
      height: containH < height ? containH : height,
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 19.h, 16.w, 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(LocaleKeys.c2c50.tr, style: AppTextStyle.f_20_600.color111111).marginOnly(bottom: 12.w),
          Expanded(
            child: ListView.builder(
              itemCount: model.payTypeList!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      model.selectIndex = index;
                      callback?.call(index);
                      Get.back();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Color(0xFFECECEC)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              MyImage((index == model.selectIndex ? 'my/apply_supertrade_succse' : 'my/apply_supertrade_unsel')
                                  .svgAssets()),
                              MyImage(
                                model.payTypeList![index].iconUrl,
                              ).paddingOnly(left: 14.w, right: 8.w),
                              Text(
                                model.payTypeList![index].payWayName ?? '',
                                style: AppTextStyle.f_15_600.color111111,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('$symbol$textFieldNum', style: AppTextStyle.f_12_500.color111111).marginOnly(bottom: 2.w),
                              Text('≈ ${textFieldNum * model.payTypeList![index].rate} USDT',
                                  style: AppTextStyle.f_12_500.color999999)
                            ],
                          )
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.model, required this.type});
  final CustomerTocRequestModel model;
  final CustomerSheetType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      // case CustomerSheetType.coinType:
      //   return getCoinView(context);
      case CustomerSheetType.amountType:
        return getAmountView(context);
      case CustomerSheetType.filterType:
        return getFilterView(context);
      default:
        return getDefaultView(context);
    }
  }

  // Widget getCoinView(BuildContext context) {
  //   var height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 74;
  //   var containH = 196.w + model.actionArray.length * 56.w;
  //   return Container(
  //     height: containH < height ? containH : height,
  //     decoration: const BoxDecoration(
  //       color: AppColor.colorWhite,
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(15),
  //         topRight: Radius.circular(15),
  //       ),
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         Padding(
  //           padding: EdgeInsets.only(left: 16, right: 16, top: 20.w, bottom: 24.w),
  //           child: Text(model.title, style: AppTextStyle.h5_600.color111111),
  //         ),
  //         Container(
  //             height: 32.h,
  //             margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
  //             decoration: BoxDecoration(
  //               color: AppColor.colorF5F5F5,
  //               borderRadius: BorderRadius.circular(6.0),
  //             ),
  //             child: SearchTextField(
  //               height: 32,
  //               haveTopPadding: false,
  //               hintText: '搜索币种'.tr,
  //             )),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: model.actionArray.length,
  //             itemBuilder: (context, index) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   model.filterIndex = index;
  //                   Navigator.pop(context);
  //                 },
  //                 behavior: HitTestBehavior.translucent,
  //                 child: Container(
  //                   margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
  //                   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(6),
  //                       color: index == model.currentIndex ? AppColor.colorF5F5F5 : Colors.transparent),
  //                   child: Row(
  //                     children: [
  //                       MarketIcon(
  //                         iconName: model.actionArray[index],
  //                         width: 24.w,
  //                       ),
  //                       SizedBox(width: 10.w),
  //                       Text(model.actionArray[index], style: AppTextStyle.body2_600.color111111),
  //                       const Spacer(),
  //                       index == model.currentIndex ? const Icon(Icons.check) : const SizedBox()
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget getAmountView(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(top: 20.w,),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                children: <Widget>[
                  Text(model.filterAmount.title, style: AppTextStyle.f_20_600.color111111),
                  Container(
                      height: 50.h,
                      margin: EdgeInsets.only(top: 20.h, bottom: 16.h),
                      padding: EdgeInsets.only(top: 4.h),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: AppColor.colorF5F5F5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Expanded(
                              child: Obx(() => SearchTextField(
                                    controller: model.filterAmount.textVC.value,
                                    height: 44,
                                    havePrefixIcon: false,
                                    haveSuffixIcon: false,
                                    hintText: '10',
                                    onChanged: (p) {
                                      model.filterAmount.currentIndex.value = 0;
                                      model.filterAmount.baseAmount = p;
                                    },
                                  ))),
                          Text(model.otcDefaultPaycoin, style: AppTextStyle.f_13_500.color666666),
                          SizedBox(width: 16.w),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 30.w),
                      child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: model.filterAmount.actionArray
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      model.filterAmount.currentIndex.value = model.filterAmount.actionArray.indexOf(e);
                                      var textNum = model.filterAmount.baseAmount.isNotEmpty == true
                                          ? model.filterAmount.baseAmount.toDouble()
                                          : 10;
                                      model.filterAmount.textVC.value.text = (e.toInt() * textNum).toString();
                                    },
                                    child: Container(
                                      height: 32.h,
                                      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                          // color: Colors.red,
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                              width: 1,
                                              color: model.filterAmount.currentIndex.value ==
                                                      model.filterAmount.actionArray.indexOf(e)
                                                  ? AppColor.color111111
                                                  : AppColor.colorECECEC)),
                                      child: Text('${e}x',
                                          style: AppTextStyle.f_13_500.copyWith(
                                              color: model.filterAmount.currentIndex.value ==
                                                      model.filterAmount.actionArray.indexOf(e)
                                                  ? AppColor.color111111
                                                  : AppColor.color666666)),
                                    ),
                                  ))
                              .toList()))),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton.borderWhiteBg(
                      height: 48.w,
                      text: LocaleKeys.c2c157.tr,
                      border: Border.all(width: 1, color: AppColor.color111111),
                      onTap: () {
                        model.filterAmount.topTitle.value = LocaleKeys.c2c187.tr;
                        model.amount = '';
                        model.filterAmount.baseAmount = '10';
                        model.filterAmount.textVC.value.text = '';
                        model.filterAmount.currentIndex.value = 0;
                        model.callbackFilter();
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Expanded(
                    child: MyButton(
                      height: 48.w,
                      text: LocaleKeys.public1.tr,
                      onTap: () {
                        model.filterAmount.topTitle.value = model.filterAmount.textVC.value.text.isEmpty
                            ? LocaleKeys.c2c187.tr
                            : model.filterAmount.textVC.value.text;
                        model.amount = model.filterAmount.textVC.value.text;
        
                        model.filterAmount.baseAmount = '10';
                        model.filterAmount.textVC.value.text = '';
                        model.filterAmount.currentIndex.value = 0;
                        model.callbackFilter();
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFilterView(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(top: 20.w, ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.filter.title, style: AppTextStyle.f_20_600.color111111),
                  Padding(
                    padding: EdgeInsets.only(top: 18.h, bottom: 12.h),
                    child: Text(LocaleKeys.c2c197.tr, style: AppTextStyle.f_12_400.color666666),
                  ),
                  Obx(() => Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                model.filter.currentIndex.value = 0;
                              },
                              child: Container(
                                height: 32.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        width: 1,
                                        color:
                                            model.filter.currentIndex.value == 0 ? AppColor.color111111 : AppColor.colorF5F5F5)),
                                child: Text(LocaleKeys.c2c198.tr, style: AppTextStyle.f_14_400.color111111),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                model.filter.currentIndex.value = 1;
                              },
                              child: Container(
                                height: 32.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        width: 1,
                                        color:
                                            model.filter.currentIndex.value == 1 ? AppColor.color111111 : AppColor.colorF5F5F5)),
                                child: Text(LocaleKeys.c2c199.tr, style: AppTextStyle.f_14_400.color111111),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.h, top: 30.h, bottom: 12.h),
              child: Text(LocaleKeys.b2c17.tr, style: AppTextStyle.f_12_400.color666666),
            ),
            model.filter.payments?.isNotEmpty == true
                ? Obx(() => Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Wrap(
                        children: <Widget>[
                          ...model.filter.payments!.map((e) => GestureDetector(
                                onTap: () {
                                  var key = e.key ?? '';
                                  if (model.filter.paymentsList.contains(key)) {
                                    model.filter.paymentsList.remove(key);
                                  } else {
                                    model.filter.paymentsList.add(key);
                                  }
                                },
                                child: Container(
                                  height: 32.h,
                                  width: 167.h,
                                  margin: EdgeInsets.only(right: 10.w, bottom: 10.h),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          width: 1,
                                          color: model.filter.paymentsList.contains(e.key ?? '')
                                              ? AppColor.color111111
                                              : AppColor.colorF5F5F5)),
                                  child: Text(e.title ?? '',
                                      style: AppTextStyle.f_14_400.copyWith(
                                          color: model.filter.paymentsList.contains(e.key ?? '')
                                              ? AppColor.color111111
                                              : AppColor.colorABABAB)),
                                ),
                              ))
                        ],
                      ),
                    ))
                : const SizedBox(),
            const Divider().marginOnly(top: 23.h),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton.borderWhiteBg(
                      border: Border.all(width: 1, color: AppColor.color111111),
                      height: 48.w,
                      text: LocaleKeys.c2c157.tr,
                      onTap: () {
                        model.filter.currentIndex.value = 0;
                        model.tradeType = 0;
                        model.paymentsList = [];
                        model.callbackFilter();
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Expanded(
                    child: MyButton(
                      height: 48.w,
                      text: LocaleKeys.public1.tr,
                      onTap: () {
                        model.tradeType = model.filter.currentIndex.value;
                        model.paymentsList = List.from(model.filter.paymentsList);
                        model.callbackFilter();
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDefaultView(BuildContext context) {
    var height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 74;
    var containH = 134.w + model.filterRate.actionArray.length * 44.w;
    return Container(
      height: containH < height ? containH : height,
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.fromLTRB(0, 16.h, 0, 0.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: model.filterRate.actionArray.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    model.filterRate.currentIndex.value = index;
                    model.otcDefaultPaycoin = model.filterRate.actionArray[index];
                    model.filterRate.topTitle.value = model.otcDefaultPaycoin;
                    model.callbackFilter();
                    Get.back();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: index == model.filterRate.currentIndex.value ? AppColor.colorF5F5F5 : Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(model.filterRate.actionArray[index],
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColor.color111111,
                              fontWeight: FontWeight.w600,
                            )),
                        index == model.filterRate.currentIndex.value
                            ? const Icon(Icons.check, color: AppColor.color111111)
                            : const SizedBox()
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: MyButton.borderWhiteBg(
              text: LocaleKeys.public2.tr,
              height: 48.w,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Get.mediaQuery.viewPadding.bottom.verticalSpaceFromWidth,
        ],
      ),
    );
  }
}
