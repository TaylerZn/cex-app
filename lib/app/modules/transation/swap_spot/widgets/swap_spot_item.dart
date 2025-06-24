import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

import '../../../../config/theme/app_text_style.dart';
import '../../../markets/market/widgets/market_list_icon.dart';

class SwapSpotItem extends StatelessWidget {
  const SwapSpotItem({super.key, required this.marketInfoModel});

  final MarketInfoModel marketInfoModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpotDataStoreController>(
      init: SpotDataStoreController.to,
      id: marketInfoModel.symbol,
      builder: (logic) {
        MarketInfoModel model =
            logic.getMarketInfoBySymbol(marketInfoModel.symbol) ??
                marketInfoModel;
        return InkWell(
          onTap: () {
            Get.back(result: marketInfoModel);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 24.h, left: 16, right: 16),
            child: Row(
              children: <Widget>[
                MarketIcon(iconName: marketInfoModel.firstName.toUpperCase())
                    .marginOnly(right: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: model.showName,
                            style: AppTextStyle.f_14_500.color4c4c4c,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        model.volStr,
                        style: AppTextStyle.f_11_400.color666666,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      model.priceStr,
                      textAlign: TextAlign.right,
                      style: AppTextStyle.f_14_500.color111111,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        model.desPriceStr,
                        textAlign: TextAlign.right,
                        style: AppTextStyle.f_11_400.color999999,
                      ),
                    )
                  ],
                ),
                12.horizontalSpace,
                Container(
                  width: 70.w,
                  height: 28.h,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: model.backColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r)),
                  ),
                  child: Text(
                    model.roseStr,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.f_14_500.colorWhite,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
