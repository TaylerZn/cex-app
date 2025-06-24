import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

import 'package:nt_app_flutter/app/modules/transation/spot_detail/price/controllers/spot_price_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/views/swap_spot_bottom_sheet.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../widgets/components/transaction/share_kchart_detail_view.dart';

class SpotDetailController extends GetxController {
  Rxn<MarketInfoModel> marketInfo = Rxn<MarketInfoModel>();
  ScreenshotController shotController = ScreenshotController();
  @override
  void onInit() {
    super.onInit();
    marketInfo.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    if (marketInfo.value != null) {
      SpotPriceController.to.changeMarket(marketInfo.value!);
    }
  }

  swapSpot() async {
    final res = await SwapSpotBottomSheet.show();
    if (res != null) {
      marketInfo.value = res;
      SpotPriceController.to.changeMarket(marketInfo.value!);
    }
  }

  onShare() {
    shotController.capture(pixelRatio: Get.pixelRatio).then((value) {
      if (value != null) {
        ShareKChartDetailView.show(image: value);
      }
    });
  }
}
