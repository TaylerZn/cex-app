import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

class SwapSpotAllController extends GetxController {
  static SwapSpotAllController get to => Get.find();
  List<MarketInfoModel> marketInfoList = [];

  @override
  Future<void> onReady() async {
    super.onReady();
    if (SpotDataStoreController.to.spotList.isEmpty) {
      await SpotDataStoreController.to.getPublicInfoMarket();
    }
    _getAllMarketInfoList();
  }

  _getAllMarketInfoList() {
    marketInfoList = SpotDataStoreController.to.spotList;
    update();
  }

  search(String keyword) {
    if (keyword.isEmpty) {
      _getAllMarketInfoList();
      return;
    }
    List<MarketInfoModel> temp = List.from(marketInfoList);
    marketInfoList = temp
        .where((element) =>
            element.symbol.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    update();
  }
}
