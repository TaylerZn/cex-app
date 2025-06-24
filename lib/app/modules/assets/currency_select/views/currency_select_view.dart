import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_search_text_field.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/currency_select_controller.dart';

class CurrencySelectView extends GetView<CurrencySelectController> {
  const CurrencySelectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(), // 这将去除上拉时的黑边特性
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: [
                                SizedBox(height: 24.h),
                                _buildHot(context),
                                SizedBox(height: 32.h),
                              ],
                            )),
                        _buildList(context),
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
            ),
            decoration: BoxDecoration(
                color: AppColor.colorBackgroundInput,
                borderRadius: BorderRadius.circular(50.r)),
            child: Row(
              children: [
                MyImage(
                  'assets/images/trade/search_icon.svg',
                  width: 16.w,
                  height: 16.w,
                  fit: BoxFit.contain,
                ),
                8.horizontalSpace,

                Expanded(
                    child: TextField(
                  controller: controller.textController,
                  style: TextStyle(fontSize: 12.sp),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: LocaleKeys.public10.tr,
                    hintStyle: AppTextStyle.f_13_400.colorTextDisabled,
                  ),
                  onChanged: (val) {
                    controller.searchAction(val);
                  },
                  textAlignVertical: TextAlignVertical.center,
                )),
                8.horizontalSpace,
                InkWell(
                  onTap: () {
                    controller.textController?.clear();
                  },
                  child: MyImage(
                    'assets/clear'.svgAssets(),
                    color: AppColor.colorTextTips,
                    width: 16.w,
                  ),
                )
              ],
            ),
          )),
          SizedBox(width: 12.w),
          InkWell(
            child: Text(LocaleKeys.public2.tr,
                style: AppTextStyle.f_13_400.color333333),
            onTap: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }

  Widget _buildHot(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.assets104.tr,
              style: AppTextStyle.f_12_400.colorTextDescription,
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 12.h),
          child: Wrap(
              spacing: 10.w,
              runSpacing: 5.h,
              children: controller.hotList
                  .map(
                    (item) => InkWell(
                        onTap: () {
                          controller.onSelect(item);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 7.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: AppColor.colorBackgroundTertiary,
                              borderRadius: BorderRadius.circular(50.r)),
                          child: Text(
                            item,
                            style: AppTextStyle.f_12_500.color111111,
                          ),
                        )),
                  )
                  .toList()),
        )
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return GetBuilder<AssetsGetx>(builder: (assetsGetx) {
      return GetBuilder<CurrencySelectController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                16.horizontalSpace,
                Text(
                  LocaleKeys.assets105.tr, //币种列表
                  style: AppTextStyle.f_12_400.colorTextDescription,
                ),
              ],
            ),
            controller.searchList.isNotEmpty
                ? Wrap(
                    children: controller.searchList
                        .map(
                          (item) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.w),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: AppColor.colorBorderGutter),
                            )),
                            child: InkWell(
                              child: Row(
                                children: [
                                  MyImage(
                                    item.icon ?? '',
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.coinName ?? '',
                                            style: AppTextStyle
                                                .f_14_500.color111111,
                                          ),
                                          Expanded(
                                            child: Text(
                                              NumberUtil.mConvert(
                                                item.allBalance,
                                                isEyeHide: true,
                                              ),
                                              style: AppTextStyle
                                                  .f_14_500.color111111,
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Visibility(visible:ObjectUtil.isNotEmpty(item.showName) , child:     Row(
                                        children: [
                                          Text(
                                            item.showName != null
                                                ? item.showName!
                                                : (item.exchangeSymbol ?? ''),
                                            style: AppTextStyle
                                                .f_12_400.colorTextDescription,
                                          ),
                                          controller.isWithdraw == true
                                              ? Expanded(
                                            child: Text(
                                              '≈${ NumberUtil.mConvert(
                                                  item.usdtValuatin,
                                                  isEyeHide: true,
                                                  isRate:
                                                  IsRateEnum.usdt)}',
                                              style: AppTextStyle.f_11_400
                                                  .colorTextDescription,
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                              : SizedBox()
                                        ],
                                      ))
                                    ],
                                  )),
                                ],
                              ),
                              onTap: () {
                                controller.onSelect(item.coinName ?? '');
                              },
                            ),
                          ),
                        )
                        .toList())
                : noDataWidget(context,
                    wigetHeight: 500.h,
                    noDateIcon: NoDataClass.noComment,
                    text: LocaleKeys.assets106.tr)
          ],
        );
      });
    });
  }
}
