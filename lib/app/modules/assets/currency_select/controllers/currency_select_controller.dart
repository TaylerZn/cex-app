import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';

class CurrencySelectController extends GetxController {
  AssetsCurrencySelectEnumn type;

  CurrencySelectController({
    required this.type,
  });

  TextEditingController? textController;

  List hotList = ['USDT'];

  List<AssetSpotsAllCoinMapModel> dataList = [];
  List<AssetSpotsAllCoinMapModel> searchList = [];
  late bool isWithdraw;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    isWithdraw = type == AssetsCurrencySelectEnumn.withdraw;
    dataList = isWithdraw
        ? AssetsGetx.to.assetSpotsBalanceList
        : AssetsGetx.to.assetSpotsList;
    searchList = dataList;
    update();
  }

  void searchAction(String data) {
    var text = data.toUpperCase();
    if (text.isEmpty) {
      searchList = dataList;
    } else {
      var tempList = <AssetSpotsAllCoinMapModel>[];
      for (var model in searchList) {
        var name = model.coinName ?? '';
        var areaNum = model.exchangeSymbol ?? '';
        if (name.contains(text)) {
          tempList.add(model);
        } else if (areaNum.contains(text)) {
          tempList.add(model);
        }
      }
      print(tempList);
      searchList = tempList;
    }
    // _handleList(searchList);
    update();
  }

  @override
  void onReady() {
    AssetsGetx.to.getRefresh();
    super.onReady();
  }

  @override
  void onClose() {
    textController?.dispose();
    super.onClose();
  }

  void onSearch() {}

  void onSelect(String coinName) async {
    switch (type) {
      case AssetsCurrencySelectEnumn.depoit:
        Get.toNamed(Routes.ASSETS_DEPOSIT, arguments: coinName);
        break;
      case AssetsCurrencySelectEnumn.withdraw:
          Get.toNamed(Routes.ASSETS_WITHDRAWAL, arguments: coinName);
        break;
      default:
    }
  }
}
