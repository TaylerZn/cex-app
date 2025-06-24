import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';

import '../../widgets/depth_map_widget.dart';
import '../controllers/spot_depth_controller.dart';

class SpotDeptMapWidget extends StatelessWidget {
  const SpotDeptMapWidget({
    super.key,
    required this.onValueChanged,
    required this.height,
  });

  final ValueChanged<DepthEntity?> onValueChanged;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpotDepthController>(
      global: true,
      builder: (controller) {
        return GetBuilder<SpotDataStoreController>(
            id: controller.marketInfoModel?.symbol ?? '',
            builder: (logic) {
              MarketInfoModel? marketInfo = logic.getMarketInfoBySymbol(
                  controller.marketInfoModel?.symbol ?? '') ?? controller.marketInfoModel;
              return DepthMapWidget(
                onValueChanged: onValueChanged,
                price: controller.marketInfoModel?.secondName
                        .replaceAll('/', '') ??
                    '--',
                amount: controller.marketInfoModel?.firstName ?? '--',
                height: height,
                onChangePrecision: (value) {
                  controller.changePrecision(value);
                },
                precisionList: controller.precisionList,
                precision: controller.precision,
                amountPrecision: controller.marketInfoModel?.limitVolumeMin?.numDecimalPlaces() ?? 3,
                buyAskType: controller.buyAskType,
                onChangeBuyAskType: (value) {
                  controller.buyAskType = value;
                  controller.update();
                },
                asks: controller.asks,
                buys: controller.buys,
                askMaxVol: controller.askMaxVol,
                buyMaxVol: controller.buyMaxVol,
                fundingRate: controller.fundingRate,
                closePrice: marketInfo?.close ?? '--',
                color: marketInfo?.priceColor ??
                    AppColor.colorBlack,
              );
            });
      },
    );
  }
}
