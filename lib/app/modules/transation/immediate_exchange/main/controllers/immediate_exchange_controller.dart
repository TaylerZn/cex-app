import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/models/trade/convert_currencies_model.dart';
import 'package:nt_app_flutter/app/modules/transation/immediate_exchange/main/widgets/select_currency_dialog.dart';

import '../../../../../getX/assets_Getx.dart';
import '../../../../../models/assets/assets_spots.dart';
import '../../../../../models/trade/convert_quick_quote_rate.dart';
import '../../../../../utils/utilities/number_util.dart';
import '../widgets/confirm_conversion_dialog.dart';

class ImmediateExchangeController extends GetxController {
  //TODO: Implement ImmediateExchangeController

  RxList<CoinModel> baseList = RxList();
  RxList<CoinModel> quoteList = RxList();

  Rxn<CoinModel> fromCoinModel = Rxn();
  Rxn<CoinModel> toCoinModel = Rxn();

  /// 用来是否超出了自己可用的
  Rx<String> fromValue = Rx('');

  /// 转换的
  TextEditingController fromEditingController = TextEditingController();

  /// 转换后的
  TextEditingController toEditingController = TextEditingController();

  Rxn<ConvertQuickQuoteRate> convertQuickQuoteRate = Rxn();

  RxBool isChange = false.obs;

  FocusNode formFocusNode = FocusNode();
  FocusNode toFocusNode = FocusNode();

  RxBool fromError = false.obs;
  RxBool toError = false.obs;
  RxBool isShowRetry = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrenciesData();

    fromEditingController.addListener(() {
      if (!isChange.value) {
        fromValue.value =
            fromEditingController.text.replaceAll(RegExp('[^0-9.]'), '');
      }

      if (formFocusNode.hasFocus) {
        if (fromEditingController.text.isNotEmpty) {
          startTimer();
        } else {
          toEditingController.clear();
          timer?.cancel();
        }
      }
    });

    toEditingController.addListener(() {
      if (isChange.value) {
        fromValue.value =
            toEditingController.text.replaceAll(RegExp('[^0-9.]'), '');
      }
      if (toFocusNode.hasFocus) {
        if (toEditingController.text.isNotEmpty) {
          startTimer();
        } else {
          fromEditingController.clear();
          timer?.cancel();
        }
      }
    });
  }

  fetchCurrenciesData() async {
    try {
      var res = await AssetsApi.instance().getQuickCurrencies();
      /*
    ConvertCurrenciesModel res = ConvertCurrenciesModel.fromJson({
      "baseList": [
        {
          "id": 1,
          "symbol": "BTC",
          "min": "0.01",
          "max": "2",
          "precision": 6,
          "type": 1,
          "threshold": 0.0001,
          "icon":
              "https://BITCOCO-prod.s3.ap-northeast-1.amazonaws.com/icon/coin/BTC.png"
        }
      ],
      "quoteList": [
        {
          "id": 2,
          "symbol": "USDT",
          "min": "1",
          "max": "10000",
          "precision": 2,
          "type": 2,
          "threshold": 0.02,
          "icon":
              "https://BITCOCO-prod.s3.ap-northeast-1.amazonaws.com/icon/coin/USDT.png"
        }
      ]
    });
    */
      if (res != null) {
        baseList.value = res.baseList ?? RxList();
        quoteList.value = res.quoteList ?? RxList();
        fromCoinModel.value = quoteList.first;
        toCoinModel.value = baseList.first;
        isShowRetry.value = false;
      } else {
        isShowRetry.value = true;
      }
    } catch (e) {}
  }

  void onSelectFromCurrency({bool isGet = false}) {
    // Get.bottomSheet(
    //     SelectCurrencyDialog(
    //       baseList: baseList,
    //       quoteList: quoteList,
    //       isGet: isChange.value ? !isGet : isGet,
    //       fromCoinModel: fromCoinModel.value!,
    //       toCoinModel: toCoinModel.value!,
    //       isChange: isChange.value,
    //       callBack: (from, to) {
    //         fromCoinModel.value = from;
    //         toCoinModel.value = to;
    //         startTimer();
    //       },
    //     ),
    //     isScrollControlled: true);
    //使用 BottomSheet 方案，因为这种方式更自然，键盘弹出时不会影响页面布局。
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true, // 允许弹出键盘时调整高度
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SelectCurrencyDialog(
          baseList: baseList,
          quoteList: quoteList,
          isGet: isChange.value ? !isGet : isGet,
          fromCoinModel: fromCoinModel.value!,
          toCoinModel: toCoinModel.value!,
          isChange: isChange.value,
          callBack: (from, to) {
            fromCoinModel.value = from;
            toCoinModel.value = to;
            startTimer();
          },
        );
      },
    );
  }

  void confirm() {
    //fetchCurrenciesData();
    num from =
        num.parse(fromEditingController.text.replaceAll(RegExp('[^0-9.]'), ''));
    num to =
        num.parse(toEditingController.text.replaceAll(RegExp('[^0-9.]'), ''));
    Get.bottomSheet(
        ConfirmConversionDialog(
          fromCoinModel: fromCoinModel.value!,
          toCoinModel: toCoinModel.value!,
          from: from,
          to: to,
          convertQuickQuoteRate: convertQuickQuoteRate.value!,
          isChange: isChange.value,
        ),
        isScrollControlled: true);
  }

  String getUsable(CoinModel model) {
    List<AssetSpotsAllCoinMapModel> array = AssetsGetx.to.assetSpotsList;
    try {
      AssetSpotsAllCoinMapModel? t =
          array.firstWhere((element) => element.coinName == model.symbol);
      return t.allBalance ?? '0.00';
    } catch (e) {
      return '0.00';
    }
  }

  AssetSpotsAllCoinMapModel? getAssetSpotsAllCoinMapModel(CoinModel model) {
    List<AssetSpotsAllCoinMapModel> array = AssetsGetx.to.assetSpotsList;
    try {
      AssetSpotsAllCoinMapModel? t =
          array.firstWhere((element) => element.coinName == model.symbol);
      return t;
    } catch (e) {
      return null;
    }
  }

  Timer? timer;

  void startTimer() {
    timer?.cancel();
    quickQuote().then((value) {
      handleData();
    });
    timer = Timer.periodic(Duration(seconds: 8), (timer) {
      quickQuote();
    });
  }

  /// 获取汇率
  Future quickQuote() async {
    var res = await AssetsApi.instance().getQuickQuote(
        '${toCoinModel.value?.symbol}', '${fromCoinModel.value?.symbol}');
    convertQuickQuoteRate.value = res;
    handleData();
  }

  // if (controller.isChange.value == false)
  // Text(
  // '1 ${controller.fromCoinModel.value?.symbol} = ${NumberUtil.mConvert('${1 / num.parse(controller.convertQuickQuoteRate.value!.sellPrice!)}', count: controller.toCoinModel.value!.precision, isTruncate: true)} ${controller.toCoinModel.value?.symbol}',
  // style: AppTextStyle.small_400.color999999,
  // ),
  // if (controller.isChange.value)
  // Text(
  // '1 ${controller.toCoinModel.value?.symbol} = ${controller.convertQuickQuoteRate.value?.buyPrice} ${controller.fromCoinModel.value?.symbol}',
  // style: AppTextStyle.small_400.color999999,
  // ),
  void handleData() {
    String sellPrice =
        '${NumberUtil.mConvert('${1 / num.parse(convertQuickQuoteRate.value!.sellPrice!)}', count: toCoinModel.value!.precision, isTruncate: true)}'
            .replaceAll(RegExp('[^0-9.]'), '');
    String buyPrice = '${convertQuickQuoteRate.value?.buyPrice}';
    if (formFocusNode.hasFocus) {
      if (fromEditingController.text.isEmpty) {
        toEditingController.clear();
        toError.value = false;
        fromError.value = false;
        balanceError.value = false;
        return;
      }
      num from = 0;
      try {
        var t = fromEditingController.text.replaceAll(RegExp('[^0-9.]'), '');
        from = num.parse(t);
      } catch (e) {
        toEditingController.clear();
        toError.value = false;
        fromError.value = false;
        balanceError.value = false;
        return;
      }
      if (from < num.parse(fromCoinModel.value!.min!) ||
          from > num.parse(fromCoinModel.value!.max!)) {
        fromError.value = true;
      } else {
        fromError.value = false;
      }

      if (isChange.value) {
        var text = NumberUtil.mConvert(
                '${from / num.parse(convertQuickQuoteRate.value!.buyPrice!)}',
                count: toCoinModel.value!.precision,
                isTruncate: true)
            .replaceAll(',', '')
            .replaceAll(RegExp('[^0-9.]'), '');
        toEditingController.text = Decimal.parse(text).toString();
      } else {
        var text = NumberUtil.mConvert('${from * num.parse(sellPrice)}',
                count: toCoinModel.value!.precision, isTruncate: true)
            .replaceAll(',', '')
            .replaceAll(RegExp('[^0-9.]'), '');
        toEditingController.text = Decimal.parse(text).toString();
      }
    } else if (toFocusNode.hasFocus) {
      if (toEditingController.text.isEmpty) {
        fromEditingController.clear();
        toError.value = false;
        fromError.value = false;
        balanceError.value = false;
        return;
      }
      num to = 0;
      try {
        var t = toEditingController.text.replaceAll(RegExp('[^0-9.]'), '');
        to = num.parse(t);
      } catch (e) {
        fromEditingController.clear();
        toError.value = false;
        fromError.value = false;
        balanceError.value = false;
        return;
      }
      if (to < num.parse(toCoinModel.value!.min!) ||
          to > num.parse(toCoinModel.value!.max!)) {
        toError.value = true;
      } else {
        toError.value = false;
      }

      if (isChange.value) {
        var text = NumberUtil.mConvert(
                '${to * num.parse(convertQuickQuoteRate.value!.buyPrice!)}',
                count: fromCoinModel.value!.precision,
                isTruncate: true)
            .replaceAll(',', '')
            .replaceAll(RegExp('[^0-9.]'), '');
        fromEditingController.text = Decimal.parse(text).toString();
      } else {
        var text = NumberUtil.mConvert(
                '${to * num.parse(convertQuickQuoteRate.value!.sellPrice!)}',
                count: fromCoinModel.value!.precision,
                isTruncate: true)
            .replaceAll(',', '')
            .replaceAll(RegExp('[^0-9.]'), '');
        fromEditingController.text = Decimal.parse(text).toString();
      }
    } else {
      num from = 0;
      try {
        var t = fromEditingController.text.replaceAll(RegExp('[^0-9.]'), '');
        from = num.parse(t);
      } catch (e) {
        toEditingController.clear();
        toError.value = false;
        fromError.value = false;
        balanceError.value = false;
        return;
      }
      num to = 0;
      try {
        var t = toEditingController.text.replaceAll(RegExp('[^0-9.]'), '');
        to = num.parse(t);
      } catch (e) {
        fromEditingController.clear();
        toError.value = false;
        fromError.value = false;
        balanceError.value = false;
        return;
      }
      if (isChange.value) {
        var text = NumberUtil.mConvert(
                '${to * num.parse(convertQuickQuoteRate.value!.buyPrice!)}',
                count: fromCoinModel.value!.precision,
                isTruncate: true)
            .replaceAll(',', '')
            .replaceAll(RegExp('[^0-9.]'), '');
        fromEditingController.text = Decimal.parse(text).toString();
      } else {
        var text = NumberUtil.mConvert(
                '${from / num.parse(convertQuickQuoteRate.value!.sellPrice!)}',
                count: toCoinModel.value!.precision,
                isTruncate: true)
            .replaceAll(',', '')
            .replaceAll(RegExp('[^0-9.]'), '');
        toEditingController.text = Decimal.parse(text).toString();
      }
    }
    balanceDetection();
  }

  RxBool balanceError = false.obs;

  ///余额检测
  void balanceDetection() {
    var model = isChange.value ? toCoinModel.value : fromCoinModel.value;
    num fromValue = 0;
    num maxValue = 0;
    try {
      maxValue = num.parse(getUsable(model!));
    } catch (e) {
      maxValue = 0;
    }
    try {
      if (isChange.value) {
        fromValue = num.parse(
            toEditingController.text.replaceAll(RegExp('[^0-9.]'), ''));
      } else {
        fromValue = num.parse(
            fromEditingController.text.replaceAll(RegExp('[^0-9.]'), ''));
      }
    } catch (e) {
      fromValue = 0;
    }
    Get.log('-------fromValue:$fromValue----maxValue:$maxValue');
    if (fromValue > maxValue) {
      balanceError.value = true;
    } else {
      balanceError.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
