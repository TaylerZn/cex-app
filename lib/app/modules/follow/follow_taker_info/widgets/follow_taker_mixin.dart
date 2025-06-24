import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_detail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

mixin FollowShare {
  Widget getHistoryFollowShareView(
      {required String name,
      required String icon,
      required String earningsRateStr,
      required String contractType,
      required String tagStr,
      required String modelName,
      required String openPriceStr,
      bool isStandardContract = true,
      String? markPriceStr,
      String? subSymbol,
      Color? tagColor}) {
    return Container(
      width: 313.w,
      height: 447.w,
      padding: EdgeInsets.fromLTRB(24.w, 205.h, 24.w, 16.h),
      decoration: const BoxDecoration(
          // color: Colors.red,
          image: DecorationImage(image: AssetImage('assets/images/flow/follow_share_bg.png'), fit: BoxFit.fill)),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(LocaleKeys.follow115.tr, style: AppTextStyle.f_14_500.colorWhite),
              Text(earningsRateStr, style: AppTextStyle.f_30_60.upColor)
            ],
          ).marginOnly(bottom: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('$contractType${LocaleKeys.trade2.tr}', style: AppTextStyle.f_11_500.colorBBBBBB),
                            Container(
                              width: 1.w,
                              height: 10.h,
                              color: AppColor.colorD9D9D9,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                            ),
                            Text(tagStr, style: AppTextStyle.f_11_500.copyWith(color: tagColor))
                          ],
                        ),
                        Row(
                          children: <Widget>[Text(modelName, style: AppTextStyle.f_14_600.colorWhite)],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[Text(LocaleKeys.follow231.tr, style: AppTextStyle.f_11_500.colorBBBBBB)],
                        ),
                        markPriceStr != null
                            ? Row(
                                children: <Widget>[Text(markPriceStr, style: AppTextStyle.f_14_600.colorWhite)],
                              )
                            : getCurrentPriceWidget(isStandardContract, subSymbol!)
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[Text(LocaleKeys.follow230.tr, style: AppTextStyle.f_11_500.colorBBBBBB)],
                        ),
                        Row(
                          children: <Widget>[Text(openPriceStr, style: AppTextStyle.f_14_600.colorWhite)],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(LocaleKeys.follow232.tr, style: AppTextStyle.f_11_500.colorBBBBBB).marginOnly(bottom: 4.h),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 16.w,
                              height: 16.w,
                              decoration:
                                  BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(8.w)),
                              margin: EdgeInsets.only(right: 2.w),
                              child: ClipOval(
                                child: MyImage(icon),
                              ),
                            ),
                            Text(name, style: AppTextStyle.f_12_500.colorWhite)
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ).marginOnly(bottom: 16.h),
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 20.w),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             Row(
          //               children: <Widget>[Text(LocaleKeys.follow231.tr, style: AppTextStyle.small_500.colorABABAB)],
          //             ),
          //             Row(
          //               children: <Widget>[Text(markPriceStr, style: AppTextStyle.medium_600.colorWhite)],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             Text(LocaleKeys.follow232.tr, style: AppTextStyle.small2_400.color999999),
          //             Row(
          //               children: <Widget>[
          //                 Container(
          //                   width: 16.w,
          //                   height: 16.w,
          //                   decoration:
          //                       BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(8.w)),
          //                   margin: EdgeInsets.only(right: 2.w),
          //                   child: ClipOval(
          //                     child: MyImage(icon),
          //                   ),
          //                 ),
          //                 Text(name, style: AppTextStyle.small_500.colorWhite)
          //               ],
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ).marginOnly(bottom: 16.h),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[Text(LocaleKeys.follow233.tr, style: AppTextStyle.f_11_400.color666666)],
                  ),
                  Row(
                    children: <Widget>[Text('APP', style: AppTextStyle.f_11_400.color666666)],
                  ),
                ],
              ).marginOnly(right: 10.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r), // 指定圆角半径
                child: QrImageView(
                  backgroundColor: AppColor.colorWhite,
                  data: LinksGetx.to.followHistoryUrl,
                  version: QrVersions.auto,
                  size: 40.w,
                  padding: EdgeInsets.all(5.w),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  getCurrentPriceWidget(bool isStandardContract, String symbol) {
    return isStandardContract
        ? GetBuilder<CommodityDataStoreController>(
            id: symbol,
            builder: (contractVC) {
              var price = '--';
              var array = contractVC.contractSymbolHashMap.values;
              for (var element in array) {
                if (element.contractName == symbol) {
                  price = element.priceStr;
                  break;
                }
              }
              return Text(price, style: AppTextStyle.f_14_600.colorWhite);
            })
        : GetBuilder<ContractDataStoreController>(
            id: symbol,
            builder: (contractVC) {
              var price = '--';
              var array = contractVC.contractList;
              for (var element in array) {
                if (element.contractName == symbol) {
                  price = element.priceStr;
                  break;
                }
              }
              return Text(price, style: AppTextStyle.f_14_600.colorWhite);
            });
  }

  Widget getTakerBarShareView(num uid, FollowkolUserDetailModel model) {
    double maxIndex = 0;
    double minIndex = 0;

    double maxValue = double.negativeInfinity;
    double minValue = double.infinity;

    if (model.monthProfit != null && model.monthProfit!.isNotEmpty) {
      for (var i = 0; i < model.monthProfit!.length; i++) {
        if (model.monthProfit![i] > maxValue) {
          maxValue = model.monthProfit![i] * 1.0;
          maxIndex = i * 1.0;
        }
        if (model.monthProfit![i] < minValue) {
          minValue = model.monthProfit![i] * 1.0;
          minIndex = i * 1.0;
        }
      }
    }

    return Container(
      width: 313.w,
      height: 447.h,
      padding: EdgeInsets.fromLTRB(24.w, 27.h, 24.w, 14.h),
      decoration: const BoxDecoration(
          // color: Colors.red,
          image: DecorationImage(image: AssetImage('assets/images/flow/follow_shareuser_bg.png'), fit: BoxFit.fill)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyImage('flow/follow_shareuser_top'.svgAssets()),
              Text(model.sheareTime, style: AppTextStyle.f_10_400.color999999)
            ],
          ).marginOnly(bottom: 36.h),
          Row(
            children: <Widget>[
              Container(
                width: 40.w,
                height: 40.w,
                margin: EdgeInsets.only(right: 10.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Colors.white.withOpacity(0.20000000298023224),
                    ),
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                ),
                child: MyImage(model.icon),
              ),
              Expanded(child: Text(model.userName, style: AppTextStyle.f_16_500.colorWhite.ellipsis)),
              const SizedBox(width: 50)
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(LocaleKeys.follow8.tr, style: AppTextStyle.f_11_400.colorABABAB),
                  SizedBox(height: 4.h),
                  Text(model.monthProfitRateStr, style: AppTextStyle.f_28_600.copyWith(color: model.monthProfitRateColor)),
                ],
              ),
            ],
          ).marginSymmetric(vertical: 14.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${LocaleKeys.follow11.tr}(USDT)', style: AppTextStyle.f_11_400.colorABABAB),
                  SizedBox(height: 4.h),
                  Text(model.monthProfitAmountStr, style: AppTextStyle.f_28_600.copyWith(color: model.monthProfitRateColor)),
                ],
              ),
            ],
          ),
          Container(
              // color: Colors.red,
              width: 255.w,
              height: 64.h,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: SizedBox(
                      height: 32.h,
                      child: StockChart(
                        profitRateList: model.monthProfit,
                      ),
                    ),
                  ),
                  Positioned(
                      left: (maxIndex / model.monthProfit!.length) < 0.5
                          ? 6.w + (maxIndex / model.monthProfit!.length) * 255.w
                          : -20.w + (maxIndex / model.monthProfit!.length) * 255.w,
                      top: 0.h,
                      child: Text(
                        '${maxValue.toStringAsFixed(2)}%',
                        style: AppTextStyle.f_9_400.copyWith(color: maxValue > 0 ? AppColor.upColor : AppColor.downColor),
                      )),
                  Positioned(
                      left: (minIndex / model.monthProfit!.length) < 0.5
                          ? 6.w + (minIndex / model.monthProfit!.length) * 255.w
                          : -20.w + (minIndex / model.monthProfit!.length) * 255.w,
                      bottom: 0.h,
                      child: Text(
                        '${minValue.toStringAsFixed(2)}%',
                        style: AppTextStyle.f_9_400.copyWith(color: minValue > 0 ? AppColor.upColor : AppColor.downColor),
                      )),
                ],
              )),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[Text(LocaleKeys.follow251.tr, style: AppTextStyle.f_10_400.colorABABAB)],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: <Widget>[Text(LocaleKeys.follow252.tr, style: AppTextStyle.f_12_600.colorWhite)],
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r), // 指定圆角半径
                child: QrImageView(
                  backgroundColor: AppColor.colorWhite,
                  data: '${LinksGetx.to.followUrl}$uid',
                  version: QrVersions.auto,
                  size: 40.w,
                  padding: EdgeInsets.all(5.w),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
