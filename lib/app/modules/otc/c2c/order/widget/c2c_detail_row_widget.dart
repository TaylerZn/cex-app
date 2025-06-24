import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_record.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/controllers/customer_order_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/utilities/copy_util.dart';
import '../../../../../utils/utilities/date_time_util.dart';

class C2CDetailRowWidget extends StatelessWidget {
  final Record? record;
  final Function onTap;
  const C2CDetailRowWidget(
      {super.key, required this.record, required this.onTap});

  @override
  Widget build(BuildContext context) {
    int? uid = UserGetx.to.uid;
    bool seller = record?.merchantId == uid.toString();
    bool isBuy = false;
    if (seller) {
      isBuy = record?.side == 'BUY';
    } else {
      isBuy = record?.side == 'SELL';
    }

    return InkWell(
        onTap: () async {
          // int? uid = UserGetx.to.uid;
          // bool seller = record?.merchantId == uid.toString();
          // bool isBuy = false;
          // if (seller) {
          //   isBuy = record?.side == 'BUY';
          // } else {
          //   isBuy = record?.side == 'SELL';
          // }

          await OtcConfigUtils.goOrderDetail(
              status: record!.status!, orderId: record!.id!, isBuy: isBuy);
          Get.find<CustomerOrderController>().reloadList();
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          // padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 209.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
              border: Border.all(color: AppColor.colorEEEEEE)),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 37.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                    isBuy
                                        ? LocaleKeys.b2c8.tr
                                        : LocaleKeys.c2c13.tr,
                                    style: isBuy
                                        ? AppTextStyle.f_14_500.upColor
                                        : AppTextStyle.f_14_500.downColor),
                                4.horizontalSpace,
                                Text(record?.coin ?? '',
                                    style: AppTextStyle.f_14_500)
                              ],
                            ),
                            Row(
                              children: [
                                Text(record?.statusName ?? '-',
                                    style: AppTextStyle.f_12_500.color999999),
                                4.horizontalSpace,
                                MyImage(
                                  'community/right'.svgAssets(),
                                  width: 7.w,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          height: 1,
                          color: AppColor.colorEEEEEE),
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.b2c13.tr,
                              style: AppTextStyle.f_11_400.color666666),
                          Text('${record?.totalPrice?.removeInvalidZero()} USD',
                              style: AppTextStyle.f_13_600.color333333),
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.b2c14.tr,
                              style: AppTextStyle.f_11_400.color666666),
                          Text('${record?.price?.removeInvalidZero()} USD',
                              style: AppTextStyle.f_11_400.color333333),
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.b2c15.tr,
                              style: AppTextStyle.f_11_400.color666666),
                          Text('${record?.volume?.removeInvalidZero()} USDT',
                              style: AppTextStyle.f_11_400.color333333),
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.b2c16.tr,
                              style: AppTextStyle.f_11_400.color666666),
                          Row(
                            children: [
                              Text('${record?.sequence}',
                                  style: AppTextStyle.f_11_400.color333333),
                              4.horizontalSpace,
                              InkWell(
                                  onTap: () {
                                    CopyUtil.copyText(record?.sequence ?? '');
                                  },
                                  child: Text(LocaleKeys.public6.tr,
                                      style:
                                          AppTextStyle.f_11_400.color0075FF)),
                            ],
                          )
                        ],
                      ),
                      15.verticalSpace,
                    ],
                  )),
              Container(
                height: 29.h,
                padding: EdgeInsets.only(left: 16.w, right: 9.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        7.h.verticalSpace,
                        Text(
                            '${MyTimeUtil.timestampToDate(record?.ctime ?? 0).toString()}',
                            style: AppTextStyle.f_11_400.color999999)
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        onTap.call();
                      },
                      child: SizedBox(
                          height: 29.h,
                          width: 91.w,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 7.h,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    width: 84.w,
                                    height: 22.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.r)),
                                        border: Border.all(
                                            color: AppColor.color111111)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MyImage(
                                            'otc/c2c/chat_icon'.svgAssets()),
                                        4.horizontalSpace,
                                        Expanded(
                                          child: Text(
                                            record?.fromUserName ?? '-',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  right: 0,
                                  child: Visibility(
                                    visible: (record?.unreadCount ?? 0) > 0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColor.downColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.r))),
                                      width: 14.w,
                                      height: 14.w,
                                      child: Text('${record?.unreadCount}',
                                          style:
                                              AppTextStyle.f_10_500.colorWhite),
                                    ),
                                  ))
                            ],
                          )),
                    )
                  ],
                ),
              ),
              15.verticalSpace,
            ],
          ),
        ));
  }
}
