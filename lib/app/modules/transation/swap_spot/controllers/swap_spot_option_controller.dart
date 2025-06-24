import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/spot_favorite_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';

import '../../../../models/contract/res/public_info_market.dart';

class SwapSpotOptionController extends GetxController {
  static SwapSpotOptionController get to => Get.find();

  List<MarketInfoModel> marketList = [];

  @override
  void onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.refreshSpotOption, (data) {
      _getAllOptionMaket();
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    if (SpotDataStoreController.to.spotList.isEmpty) {
      await Future.wait([
        SpotDataStoreController.to.getPublicInfoMarket(),
        SpotOptionController.to.fetchOptionSpotSymbolList(),
      ]);
    }
    _getAllOptionMaket();
  }

  _getAllOptionMaket() {
    marketList = SpotDataStoreController.to.spotList
        .where((element) => SpotOptionController.to.optionSpotSymbolList
            .contains(element.symbol))
        .toList();
    update();
  }

  search(String keyword) {
    if (keyword.isEmpty) {
      _getAllOptionMaket();
      return;
    }
    List<MarketInfoModel> temp = List.from(marketList);
    marketList = temp
        .where((element) =>
            element.symbol.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
