import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/b2c/order_currency_fiat.dart';
import 'package:nt_app_flutter/app/modules/otc/b2c/main/controllers/b2c_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';

class B2cCurrencySelectController extends GetxController {
  TextEditingController? textController;

  RxList<B2CCurrencyModel> dataList = <B2CCurrencyModel>[].obs;
  RxList<B2CCurrencyModel> searchList = <B2CCurrencyModel>[].obs;
  late bool isWithdraw;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    dataList.value = B2cController.to.fiatArray;
    searchList.value = dataList;
  }

  void searchAction(String data) {
    var text = data.toUpperCase();
    if (text.isEmpty) {
      searchList.value = dataList;
    } else {
      var tempList = <B2CCurrencyModel>[];
      for (var model in searchList) {
        var code = model.code ?? '';
        var name = model.currency ?? '';
        if (code.contains(text)) {
          tempList.add(model);
        } else if (name.contains(text)) {
          tempList.add(model);
        }
      }
      searchList.value = tempList;
    }
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

  void onSelect(B2CCurrencyModel item) {
    Get.back(result: item);
  }
}
