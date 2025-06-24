import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/price/controllers/contract_price_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/price_detail_view.dart';

import '../controllers/spot_price_controller.dart';

class SpotPriceView extends GetView<SpotPriceController> {
  const SpotPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return PriceDetailView(
      detailState: controller.detailState,
      onTabChanged: controller.onTabChanged,
      onSubTimeChanged: controller.onSubTimeChanged,
      onMainStateChanged: controller.onMainStateChanged,
      onSecondaryStateChanged: controller.onSecondaryStateChanged,
      onLoadMore: controller.onLoadMore,
    );
  }
}
