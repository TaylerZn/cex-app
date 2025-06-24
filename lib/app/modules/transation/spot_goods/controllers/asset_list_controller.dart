import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_goods_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_goods_operate_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

class AssetListController extends GetxController {
  static AssetListController get to => Get.find();

  Map<String, AssetSpotsAllCoinMapModel> allCoinMap = {};
  RxMap<String, AssetSpotsAllCoinMapModel> currentCoinMap = RxMap();
  RxMap<String, AssetSpotsAllCoinMapModel> otherCoinMap = RxMap();

  @override
  void onInit() {
    super.onInit();
    refreshSpotAccountBalance();
  }

  void refreshSpotAccountBalance() {
    AssetsApi.instance().getSpotsAccountBalance().then((value) {
      if (value != null) {
        allCoinMap = value.allCoinMap;
        getCurrentCoinMap();
      }
    });
  }

  getCurrentCoinMap() {
    currentCoinMap.clear();
    otherCoinMap.clear();
    SpotGoodsOperateController.to.canSellAmount.value = '0';
    SpotGoodsOperateController.to.canSellBalance.value = '0';
    allCoinMap.forEach((key, value) {
      if (value.totalBalance == null ||
          value.totalBalance!.toDecimal() == Decimal.zero) {
        return;
      }

      /// 获取当前币对
      if (key == SpotGoodsController.to.marketInfo.value?.firstName ||
          key ==
              SpotGoodsController.to.marketInfo.value?.secondName
                  .replaceAll('/', '')) {
        currentCoinMap[key] = value;
      } else {
        if (value.totalBalance != '0') {
          otherCoinMap[key] = value;
        }
      }

      /// 获取当前币对的余额
      if (key == SpotGoodsController.to.marketInfo.value?.firstName) {
        SpotGoodsOperateController.to.canSellBalance.value =
            (((value.totalBalance ?? '0').toDecimal() -
                    (value.lockBalance ?? '0').toDecimal()))
                .toString();

        SpotGoodsOperateController.to.canSellAmount
            .value = (SpotGoodsOperateController.to.canSellBalance.value
                    .toDecimal() *
                (SpotGoodsController.to.marketInfo.value?.close ?? '0')
                    .toDecimal())
            .toPrecision(
                SpotGoodsController.to.marketInfo.value?.price.toInt() ?? 2);
      }
    });
  }
}
