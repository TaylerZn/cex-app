
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/symbol_rate_info.dart';

import '../api/contract/contract_api.dart';

class AppRemoteConfigController extends GetxController {
  static AppRemoteConfigController get to => Get.find();

  List<SymbolRateInfo> symbolRateList = [];

  @override
  void onInit() {
    super.onInit();
    fetchRate();
  }

  Future fetchRate() async {
    try {
      final res = await ContractApi.instance().getSymbolRateList();
      symbolRateList = res.symbolRateList;
    } catch (e) {
      print(e);
    }
  }

  num getRate(String quoteSymbol) {
    int index = symbolRateList.indexWhere((element) => element.quoteSymbol == quoteSymbol);
    if(index == -1) return 1;
    return symbolRateList[index].rate;
  }
}
