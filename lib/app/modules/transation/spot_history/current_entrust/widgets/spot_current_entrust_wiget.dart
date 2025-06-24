import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/spot_goods/spot_goods_api.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/chart/circle_progress_chart.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../models/spot_goods/spot_order_res.dart';

class SpotCurrentEntrustItem extends StatelessWidget {
  const SpotCurrentEntrustItem({super.key, required this.orderInfo});

  final SpotOrderInfo orderInfo;

  @override
  Widget build(BuildContext context) {
    bool isSell = orderInfo.side == 'SELL';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: AppColor.colorEEEEEE,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${orderInfo.baseCoin}/${orderInfo.countCoin}',
                style: AppTextStyle.f_14_600.copyWith(
                  color: AppColor.color111111,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                margin: EdgeInsets.only(left: 4.w),
                decoration: ShapeDecoration(
                  color: AppColor.colorF3F3F3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                child: Text(
                  LocaleKeys.trade3.tr,
                  style: AppTextStyle.f_10_500.copyWith(
                    color: AppColor.color4D4D4D,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                DateUtil.formatDate(orderInfo.createdAt),
                style: AppTextStyle.f_11_500.copyWith(
                  color: AppColor.color999999,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          _buildTags(
            [
              orderInfo.getOrderType(orderInfo.type),
              orderInfo.side == 'SELL'
                  ? LocaleKeys.trade48.tr
                  : LocaleKeys.trade47.tr
            ],
            isSell ? AppColor.colorDanger : AppColor.colorSuccess,
          ),
          SizedBox(height: 18.h),
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CircleProgressChart(
                    percent: orderInfo.percent,
                    progressColor: orderInfo.percent == 0
                        ? AppColor.color999999
                        : orderInfo.side == 'SELL'
                            ? AppColor.downColor
                            : AppColor.upColor,
                    backgroundColor: AppColor.colorF5F5F5,
                    size: 40.w,
                    strokeWidth: 4.w,
                  ),
                  13.horizontalSpace,
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.trade96.tr,
                          style: AppTextStyle.f_11_400.copyWith(
                            color: AppColor.color999999,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              orderInfo.dealVolume.toString(),
                              style: AppTextStyle.f_13_500.copyWith(
                                color: AppColor.color4D4D4D,
                              ),
                            ),
                            Text(
                              '/${orderInfo.volume}',
                              style: AppTextStyle.f_13_500.copyWith(
                                color: AppColor.colorABABAB,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildItem(
                          LocaleKeys.trade34.tr,
                          orderInfo.price.toNum() > 0
                              ? orderInfo.price
                              : LocaleKeys.trade28.tr,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 5.h,
                child: InkWell(
                  onTap: () async {
                    try {
                      final res = await SpotGoodsApi.instance()
                          .orderCancel(orderInfo.id, orderInfo.symbol);
                      UIUtil.showSuccess(LocaleKeys.trade58.tr);
                    } catch (e) {
                      UIUtil.showToast(LocaleKeys.trade59.tr);
                    }
                  },
                  child: Container(
                    width: 50.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        width: 1.w,
                        color: AppColor.colorEEEEEE,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.trade102.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.color111111,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.f_11_400.copyWith(color: AppColor.colorABABAB),
        ),
        SizedBox(height: 4.w),
        Text(
          value,
          style: AppTextStyle.f_13_500.copyWith(
            color: AppColor.color4D4D4D,
          ),
        ),
      ],
    );
  }

  Widget _buildTags(List<String> tags, Color color) {
    return Row(
      children: tags
          .map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              height: 16.h,
              margin: EdgeInsets.only(right: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: color.withOpacity(0.1),
              ),
              alignment: Alignment.center,
              child:
                  Text(e, style: AppTextStyle.f_10_500.copyWith(color: color)),
            ),
          )
          .toList(),
    );
  }
}
