import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/assets/assets_contract.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsContractHoldPosition extends StatelessWidget {
  const AssetsContractHoldPosition({super.key, required this.list});

  final List<PositionList> list;

  @override
  Widget build(BuildContext context) {
    return list.length > 0
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return getCell(list[index]);
            },
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 100.h),
            child: noDataWidget(context, wigetHeight: 600.h),
          );
  }

  Widget getCell(PositionList e) {
    final Color color =
        e.orderSide == 'BUY' ? AppColor.upColor : AppColor.downColor;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.contractName,
                        style: AppTextStyle.f_14_500.color111111
                        // TextStyle(
                        //   fontSize: 14.sp,
                        //   color: AppColor.color111111,
                        //   fontWeight: FontWeight.w500,
                        // )
                        ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.h, vertical: 3.h),
                          margin: EdgeInsets.only(right: 6.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: color.withOpacity(0.1)),
                          child: Text(
                              e.orderSide == 'BUY'
                                  ? LocaleKeys.assets22.tr
                                  : LocaleKeys.assets23.tr,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: color,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 3.5.h),
                          margin: EdgeInsets.only(left: 6.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: AppColor.colorF5F5F5),
                          child: Text(
                              '${e.positionType == 1 ? LocaleKeys.assets24.tr : LocaleKeys.assets24.tr}${e.leverageLevel}X',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColor.color333333,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
                const Icon(
                  Icons.share,
                  size: 16,
                  color: AppColor.color111111,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${LocaleKeys.assets19.tr} (USDT)',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.color666666,
                      fontWeight: FontWeight.w400,
                    )),
                Text(LocaleKeys.assets26.tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.color666666,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(e.openRealizedAmount.toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.upColor,
                      fontWeight: FontWeight.w600,
                    )),
                Text((e.returnRate * 100).toStringAsFixed(2) + '%',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.upColor,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getColumnWidget('${LocaleKeys.assets79.tr} (BTC)',
                    e.positionVolume.toStringAsFixed(2)),
                getColumnWidget('${LocaleKeys.assets28.tr} (USDT)',
                    e.positionBalance.toStringAsFixed(2)),
                getColumnWidget('${LocaleKeys.assets29.tr} (USDT) ',
                    e.holdAmount.toStringAsFixed(2),
                    alignment: CrossAxisAlignment.end),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 18.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getColumnWidget('${LocaleKeys.assets30.tr} (USDT)',
                    e.openAvgPrice.toStringAsFixed(2)),
                getColumnWidget('${LocaleKeys.assets31.tr} (USDT)',
                    e.indexPrice.toStringAsFixed(2)),
                getColumnWidget('${LocaleKeys.assets32.tr} (USDT)',
                    e.reducePrice.toStringAsFixed(2),
                    alignment: CrossAxisAlignment.end),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: MyButton(
                height: 34.h,
                text: LocaleKeys.assets33.tr,
                textStyle: AppTextStyle.f_14_600,
                color: AppColor.color111111,
                backgroundColor: AppColor.colorWhite,
                border: Border.all(width: 1, color: AppColor.colorDBDBDB),
              )),
              SizedBox(
                width: 7.w,
              ),
              Expanded(
                  child: MyButton(
                height: 34.h,
                text: LocaleKeys.assets34.tr,
                textStyle: AppTextStyle.f_14_600,
                color: AppColor.color111111,
                backgroundColor: AppColor.colorWhite,
                border: Border.all(width: 1, color: AppColor.colorDBDBDB),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget getColumnWidget(String titile, String des,
      {CrossAxisAlignment alignment = CrossAxisAlignment.start}) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(titile,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.colorA3A3A3,
              fontWeight: FontWeight.w400,
            )),
        SizedBox(height: 9.h),
        Text(des,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.color4c4c4c,
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}
