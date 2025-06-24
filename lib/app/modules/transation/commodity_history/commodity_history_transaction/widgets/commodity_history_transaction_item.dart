import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_flow_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';

class CommodityHistoryTransactionItem extends StatelessWidget {
  const CommodityHistoryTransactionItem({super.key, required this.model});
  final TransactionFlowFundsModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(model.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w500,
                  )),
              Text(model.time,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColor.color999999,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade53.tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.color666666,
                      fontWeight: FontWeight.w400,
                    )),
                Text(model.typeStr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.color111111,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade2.tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.color666666,
                      fontWeight: FontWeight.w400,
                    )),
                Text(
                  model.contractNameStr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(LocaleKeys.trade54.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.color666666,
                    fontWeight: FontWeight.w400,
                  )),
              Text(
                model.amount?.toPrecision(8) ?? '--',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColor.color111111,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
