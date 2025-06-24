import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/api/assets/assets_contract_api.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_contract/controllers/assets_contract_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_transfer/enums/account_enums.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_transfer/models/account_enums.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_transfer/widgets/assets_transfer_search.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsTransferController extends GetxController {
  /*  // 仅仅跟单账户支持现货账户划转 恢复的时候需要修改
  final List<AssetsTransferItemModel> list = [
    //跟单账户
    AssetsTransferItemModel(id: 0, name: LocaleKeys.assets56.tr, request: 'follow', supportIdList: [1, 2, 3]),
    //标准合约账户
    AssetsTransferItemModel(id: 1, name: LocaleKeys.assets75.tr, request: 'standard', supportIdList: [0, 2, 3]),
    //永续合约账户
    AssetsTransferItemModel(id: 2, name: LocaleKeys.assets76.tr, request: 'contract', supportIdList: [0, 1, 3]),
    //现货账户
    AssetsTransferItemModel(
        id: 3, name: LocaleKeys.assets94.tr, request: 'wallet', c2cRequest: '1', supportIdList: [0, 1, 2, 4]),
    //资金账户
    AssetsTransferItemModel(id: 4, name: LocaleKeys.assets143.tr, c2cRequest: '2', supportIdList: [3]),
  ];
  */
  final List<AssetsTransferItemModel> list = [
    //跟单账户
    AssetsTransferItemModel(
        id: 0,
        name: LocaleKeys.assets56.tr,
        request: 'follow',
        supportIdList: [3]), // 仅仅跟单账户支持现货账户划转
    //标准合约账户
    AssetsTransferItemModel(
        id: 1,
        name: LocaleKeys.assets75.tr,
        request: 'standard',
        supportIdList: [2, 3]),
    //永续合约账户
    AssetsTransferItemModel(
        id: 2,
        name: LocaleKeys.assets76.tr,
        request: 'contract',
        supportIdList: [1, 3]),
    //现货账户
    AssetsTransferItemModel(
        id: 3,
        name: LocaleKeys.assets94.tr,
        request: 'wallet',
        c2cRequest: '1',
        supportIdList: [0, 1, 2, 4]),
    //资金账户
    AssetsTransferItemModel(
        id: 4,
        name: LocaleKeys.assets143.tr,
        c2cRequest: '2',
        supportIdList: [3]),
  ];

  // {'id': 'follow', 'name': LocaleKeys.assets56.tr},
  // {'id': 'standard', 'name': LocaleKeys.assets75.tr}, //标准合约账户
  // {'id': 'contract', 'name': LocaleKeys.assets76.tr}, //永续合约账户
  // {'id': 'wallet', 'name': LocaleKeys.assets94.tr}, //现货账户，此账户的id为前端自定义，实际传值为2
  // {
  //   'id': 'funding',
  //   'name': LocaleKeys.assets143.tr,
  //   'accountId': '2'
  // }, //资金账户，此账户的id为前端自定义，实际传值为2

  final List<AssetSpotsAllCoinMapModel> assetList = [];
  MyPageLoadingController loadingController = MyPageLoadingController();
  RxInt from = 1.obs;
  RxInt to = 2.obs;

  //当前选中的from信息
  AssetsTransferItemModel get fromCurrency {
    return list[from.value];
  }

  //当前选中的to信息
  AssetsTransferItemModel get toCurrency {
    return list[to.value];
  }

  RxString currency = "USDT".obs;
  RxString currencyBalance = "--".obs;

  RxString amount = "".obs;

  TextEditingController? textController;

  AssetsTransferController({required this.from, required this.to});

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    textController?.addListener(() {
      amount.value = textController!.text;
    });
    AssetsGetx.to.getRefresh();
    updateTransferBalance();
  }

  void currencySelect(context) async {
    try {
      final Map? res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AssetsTransferSearch(
            list: assetList,
          ),
        ),
      );
      if (res != null) {
        currency.value = res['coinName'];
        currencyBalance.value = res['total_balance'];
      }
    } catch (e) {}
  }

  void exchange() {
    final temp = from.value;
    from.value = to.value;
    to.value = temp;
    updateTransferBalance();
  }

  void transfer() async {
    try {
      if (isDisabled()) {
        return;
      }
      // loadingController.setLoading();

      if ((from.value == 3 && to.value == 4) ||
          (from.value == 4 && to.value == 3)) {
        await AssetsApi.instance().financeOtcTransfer(
          fromCurrency.c2cRequest!,
          toCurrency.c2cRequest!,
          textController!.text,
          currency.value,
        );

        loadingController.setEmpty();
      } else if (from.value == 3 || to.value == 3) {
        // await AssetsApi.instance().transfer('100', 'USDT', 'contract_to_wallet');
        await AssetsApi.instance().spotsTransfer(
            textController!.text,
            currency.value,
            '${list[from.value].request}_to_${list[to.value].request}');

        loadingController.setEmpty();
      } else {
        await AssetsContractApi.instance().contractTransfer(
            textController!.text,
            currency.value,
            '${list[from.value].request}_to_${list[to.value].request}');
        loadingController.setEmpty();
      }
      AssetsGetx.to.getRefresh();
      bool isRegistered = Get.isRegistered<AssetsContractController>();
      if (isRegistered) {
        AssetsContractController.to
            .changeContractIndex(AssetsContractController.to.contractIndex);
      }
      Get.back<bool>(result: true);
    } on DioException catch (e) {
      loadingController.setError();
      UIUtil.showError(e.error);
    } catch (e) {
      Get.log(e.toString());
    }
  }

  bool isDisabled() {
    var amountNum = num.tryParse(amount.value);
    var currencyBalanceNum = num.tryParse(currencyBalance.value);

    if (amountNum != null && currencyBalanceNum != null) {
      return amountNum > currencyBalanceNum; //输入金额 不能大于可用余额
    }

    return amount.value == '' ||
        num.parse(amount.value) == 0 ||
        list[from.value].id == list[to.value].id;
  }

  @override
  void onReady() {
    super.onReady();
  }

  // 更新选择账户后，原本的列表是否支持
  void updateTransferAccount(AssetsTransferAccountEnum type) {
    List<int> ids = [];
    if (type == AssetsTransferAccountEnum.from) {
      ids = fromCurrency.supportIdList;
      if (!ids.contains(toCurrency.id)) {
        var tList = list.where((item) {
          if (ids.contains(item.id)) {
            return true;
          }
          return false;
        }).toList();
        to.value = list.indexOf(tList[0]);
      }
    } else {
      ids = toCurrency.supportIdList;
      if (!ids.contains(fromCurrency.id)) {
        var tList = list.where((item) {
          if (ids.contains(item.id)) {
            return true;
          }
          return false;
        }).toList();
        from.value = list.indexOf(tList[0]);
      }
    }
  }

  void updateTransferBalance() {
    switch (from.value) {
      case 0:
        if (UserGetx.to.isKol) {
          currencyBalance.value = AssetsGetx.to.traderInfoBalance;
        } else {
          currencyBalance.value = AssetsGetx.to.followInfoBalance;
        }
        break;
      case 1:
        currencyBalance.value = AssetsGetx.to.getContractCanUseBalance(0).toDecimal().toString();
        break;
      case 2:
        currencyBalance.value = AssetsGetx.to.getContractCanUseBalance(1).toDecimal().toString();
        break;
      case 3:
        currencyBalance.value =
            AssetsGetx.to.getSpotCanUseBalance().toDecimal().toString();
        break;
      case 4:
        currencyBalance.value =
            AssetsGetx.to.c2cBalance == '0.00000000000000000000000000'
                ? double.parse(AssetsGetx.to.c2cBalance).toStringAsFixed(8)
                : AssetsGetx.to.c2cBalance;
        break;
    }
  }

  @override
  void onClose() {
    textController?.dispose();
    super.onClose();
  }
}
