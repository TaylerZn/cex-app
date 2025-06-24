import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';

import '../../commodity/controllers/commodity_controller.dart';

class CurrentTradeWidget extends StatelessWidget {
  const CurrentTradeWidget(
      {super.key,
      required this.title,
      required this.change,
      required this.onChangeTrade,
      required this.onKchartTap,
      required this.onMoreTap,
      this.subTitle,
      required this.guideType});

  final String title;
  final String? subTitle;

  /// 涨跌幅
  final num change;
  final VoidCallback onChangeTrade;
  final VoidCallback onKchartTap;
  final VoidCallback onMoreTap;
  final AppGuideType guideType;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      color: themeData.scaffoldBackgroundColor,
      height: 44.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppGuideView(
            order: 1,
            guideType: guideType,
            finishCallback: () {
              if (guideType == AppGuideType.standardContract) {
                CommodityController.to.isGuiding.value = false;
              }
            },
            child: Row(
              children: [
                InkWell(
                  onTap: onChangeTrade,
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.f_16_600.copyWith(
                          color: AppColor.color111111,
                        ),
                      ),
                      4.horizontalSpace,
                      // if (subTitle != null)
                      //   Container(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 4.w, vertical: 2.h),
                      //     margin: EdgeInsets.only(right: 4.w),
                      //     decoration: ShapeDecoration(
                      //       color: AppColor.colorF3F3F3,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(4.r),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       subTitle!,
                      //       style: AppTextStyle.f_10_500.copyWith(
                      //         color: AppColor.color4D4D4D,
                      //       ),
                      //     ),
                      //   ),
                      Container(
                        width: 28.h,
                        height: 28.h,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 18.sp,
                          color: AppColor.color111111,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(change * 100).toPrecision(2)}%',
                  style: AppTextStyle.f_11_500.copyWith(
                    color: AppColor.upDownColor(change),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              RouteUtil.goTo('/follow-orders');
            },
            child: MyImage(
              'assets/images/contract/contract_copy.svg',
              width: 20.w,
              height: 20.w,
            ),
          ),
          16.horizontalSpace,
          InkWell(
            onTap: onKchartTap,
            child: MyImage(
              'assets/images/contract/stock-market.svg',
              width: 20.w,
              height: 20.w,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          InkWell(
            onTap: onMoreTap,
            child: MyImage(
              'assets/images/contract/more-one.svg',
              width: 20.w,
              height: 20.w,
            ),
          ),
        ],
      ),
    );
  }
}
