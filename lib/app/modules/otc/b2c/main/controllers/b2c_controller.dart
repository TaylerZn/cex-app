import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/b2c/order_currency_fiat.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_log_event_name.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_manager.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:url_launcher/url_launcher.dart';

class B2cController extends GetxController with GetTickerProviderStateMixin {
  static B2cController get to => Get.find();
  List<C2cType> navTabs = [C2cType.buy, C2cType.sell];
  final index = 0.obs;

  TextEditingController buyPayTextController = TextEditingController();
  FocusNode buyPayFocusNode = FocusNode();
  TextEditingController buyReceiveTextController = TextEditingController();
  FocusNode buyReceiveFocusNode = FocusNode();
  TextEditingController sellPayTextController = TextEditingController();
  FocusNode sellPayFocusNode = FocusNode();
  TextEditingController sellReceiveTextController = TextEditingController();
  FocusNode sellReceiveFocusNode = FocusNode();

  //法币列表
  RxList<B2CCurrencyModel> fiatList = <B2CCurrencyModel>[].obs;
  // 当前法币
  Rx<B2CCurrencyModel> fiat = B2CCurrencyModel().obs;

  //法币列表
  RxList<B2CCurrencyModel> fiatSellList = <B2CCurrencyModel>[].obs;
  // 当前法币
  Rx<B2CCurrencyModel> fiatSell = B2CCurrencyModel().obs;

  //加密币列表
  RxList<B2CCryptoModel> cryptoList = <B2CCryptoModel>[].obs;
  // 当前加密币
  Rx<B2CCryptoModel> crypto = B2CCryptoModel().obs;

  B2CChannelModel channelModel = B2CChannelModel();

  //当前加密货币实时报价
  RxNum cryptoRate = RxNum(1);

  RxNum cryptoSellRate = RxNum(1);

  // 买限额错误提示
  RxnString buyLimitError = RxnString();
  // 卖限额错误提示
  RxnString sellLimitError = RxnString();
  // 买加密货币错误提示
  RxnString sellCryptoError = RxnString();
  RxBool canBuy = false.obs;
  RxBool canSell = false.obs;

  //资产
  String currency = '';

  late TabController tabController;
  var channelIndex = (-1).obs;
  Timer? buyTimer;
  Timer? sellTimer;

  @override
  void onInit() {
    tabController = TabController(length: navTabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        index.value = tabController.index;
        checkPayList();
      }
    });
    buyPayTextController.addListener(() {
      if (buyTimer?.isActive ?? false) {
        buyTimer?.cancel();
      }
      buyTimer = Timer(const Duration(seconds: 2), () {
        num buyAmount = buyPayTextController.text.toNum();
        if (buyAmount < channelModel.maxBuyAmount && buyAmount > channelModel.minBuyAmount) {
          getB2cCurrencyCryptoBuyQuote(amount: buyPayTextController.text);
        }
        ();
      });

      if (buyPayFocusNode.hasFocus) {
        if (buyPayTextController.text.isEmpty) {
          buyLimitError.value = null;
          buyReceiveTextController.clear();
          canBuy.value = false;
          return;
        }
        num buyAmount = buyPayTextController.text.toNum();
        if (buyAmount > channelModel.maxBuyAmount || buyAmount < channelModel.minBuyAmount) {
          buyLimitError.value = '${LocaleKeys.b2c30.tr}${channelModel.minBuyAmount} ~ ${channelModel.maxBuyAmount}';
          canBuy.value = false;
        } else {
          buyLimitError.value = null;
          canBuy.value = true;
        }
        if (buyPayTextController.text.isNotEmpty) {
          buyReceiveTextController.text = (buyAmount / fiat.value.rate).toStringAsFixed(crypto.value.precisionInt);
        } else {
          buyReceiveTextController.text = '';
        }
      }
    });
    buyReceiveTextController.addListener(() {
      if (buyReceiveFocusNode.hasFocus) {
        if (buyReceiveTextController.text.isEmpty) {
          buyLimitError.value = null;
          buyPayTextController.clear();
          canBuy.value = false;
          return;
        }
        num receiveAmount = buyReceiveTextController.text.toNum();
        num buyAmount = receiveAmount * cryptoRate.value;

        if (buyAmount > channelModel.maxBuyAmount || buyAmount < channelModel.minBuyAmount) {
          buyLimitError.value = '${LocaleKeys.b2c30.tr}${channelModel.minBuyAmount} ~ ${channelModel.maxBuyAmount}';
          canBuy.value = false;
        } else {
          buyLimitError.value = null;
          canBuy.value = true;
        }
        buyPayTextController.text = buyAmount.toStringAsFixed(fiat.value.precisionInt);
      }
    });

    sellPayTextController.addListener(() {
      if (sellTimer?.isActive ?? false) {
        sellTimer?.cancel();
      }
      sellTimer = Timer(const Duration(seconds: 2), () {
        num sellAmount = sellPayTextController.text.toNum();
        if (sellAmount < AssetsGetx.to.c2cBalance.toNum() &&
            (sellAmount < (crypto.value.maxBuyAmount) && sellAmount > (crypto.value.minBuyAmount))) {
          getB2cSellCurrencyCryptoBuyQuote(amount: sellPayTextController.text);
        }
      });
      if (sellPayFocusNode.hasFocus) {
        if (sellPayTextController.text.isEmpty) {
          sellLimitError.value = null;
          sellCryptoError.value = null;
          sellReceiveTextController.clear();
          canSell.value = false;
          return;
        }
        num sellAmount = sellPayTextController.text.toNum();
        if (sellAmount > AssetsGetx.to.c2cBalance.toNum()) {
          sellLimitError.value = LocaleKeys.b2c31.tr;
          canSell.value = false;
        } else if (sellAmount > (crypto.value.maxBuyAmount) || sellAmount < (crypto.value.minBuyAmount)) {
          sellLimitError.value = '${LocaleKeys.b2c30.tr}${crypto.value.minBuyAmount} ~ ${crypto.value.maxBuyAmount}';
          canSell.value = false;
        } else {
          sellCryptoError.value = null;
          sellLimitError.value = null;
          canSell.value = true;
        }
        if (sellPayTextController.text.isNotEmpty) {
          sellReceiveTextController.text =
              (sellPayTextController.text.toNum() * fiatSell.value.rate).toStringAsFixed(crypto.value.precisionInt);
        } else {
          sellReceiveTextController.text = '';
        }
      }
    });
    sellReceiveTextController.addListener(() {
      if (sellReceiveFocusNode.hasFocus) {
        if (sellReceiveTextController.text.isEmpty) {
          sellLimitError.value = null;
          sellCryptoError.value = null;
          sellPayTextController.clear();
          canSell.value = false;
          return;
        }
        num receiveAmount = sellReceiveTextController.text.toNum();
        num sellAmount = receiveAmount / cryptoRate.value;
        if (sellAmount > AssetsGetx.to.c2cBalance.toNum()) {
          sellLimitError.value = LocaleKeys.b2c31.tr;
          canSell.value = false;
        } else if (sellAmount > (crypto.value.maxBuyAmount) || sellAmount < (crypto.value.minBuyAmount)) {
          sellLimitError.value = '${LocaleKeys.b2c30.tr}${crypto.value.minBuyAmount} ~ ${crypto.value.maxBuyAmount}';
          canSell.value = false;
        } else {
          sellCryptoError.value = null;
          sellLimitError.value = null;
          canSell.value = true;
        }
        sellPayTextController.text = sellAmount.toStringAsFixed(fiatSell.value.precisionInt);
      }
    });

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    EasyLoading.show();
    await Future.wait([getB2cCurrencyFiat(), getB2cCurrencyCrypto()]);
    await b2cChannelList(); //支付渠道
    await getB2cCurrencyCryptoBuyQuote(); //实时报价
    EasyLoading.dismiss();
    //preload
    getB2cSellCurrencyFiat();
  }

  Future b2cChannelList() async {
    try {
      List<B2CChannelModel>? res = await OtcApi.instance().b2cChannelList(fiat.value.currency, 'TRX', 'USDT');
      if (res?.isNotEmpty == true) {
        channelModel = res![0];
        if (channelModel.payTypeList?.isNotEmpty == true) {
          channelIndex.value = 0;
        }
      }
    } catch (e) {
      Get.log('b2cChannelList error: $e');
    }
  }

  Future getB2cCurrencyFiat() async {
    try {
      List<B2CCurrencyModel>? res = await OtcApi.instance().b2cCurrencyFiat('BUY');
      fiatList.value = res ?? [];
      if (fiatList.isNotEmpty) {
        if (currency.isNotEmpty) {
          var c = fiatList.firstWhere((element) => element.currency == currency);
          fiat.value = c;
        } else {
          fiat.value = fiatList[0];
        }
      }
    } catch (e) {
      Get.log('getB2cCurrencyFiat error: $e');
    }
  }

  Future getB2cSellCurrencyFiat() async {
    try {
      List<B2CCurrencyModel>? res = await OtcApi.instance().b2cCurrencyFiat('SELL');
      fiatSellList.value = res ?? [];
      if (fiatSellList.isNotEmpty) {
        fiatSell.value = fiatSellList[0];
        getB2cSellCurrencyCryptoBuyQuote();
      }
    } catch (e) {
      Get.log('getB2cCurrencyFiat error: $e');
    }
  }

  Future getB2cCurrencyCrypto() async {
    try {
      List<B2CCryptoModel>? res = await OtcApi.instance().b2cCurrencyCrypto();
      cryptoList.value = res ?? [];
      if (cryptoList.isNotEmpty) {
        crypto.value = cryptoList[0];
      }
    } catch (e) {
      Get.log('getB2cCurrencyCrypto error: $e');
    }
  }

  Future getB2cCurrencyCryptoBuyQuote({String? amount}) async {
    var symbol = fiat.value.currency;
    if (symbol == null) return;
    try {
      var res = await OtcApi.instance()
          .b2cCurrencyCryptoBuyQuote('BUY', amount ?? channelModel.minBuyAmount.toString(), symbol, 'USDT', null, 'TRX');
      cryptoRate.value = num.parse(res.cryptoPrice ?? '1');
      fiat.value.rate = res.rate;
      if (buyPayTextController.text.isNotEmpty) {
        num buyAmount = buyPayTextController.text.toNum();
        buyReceiveTextController.text = (buyAmount / fiat.value.rate).toStringAsFixed(crypto.value.precisionInt);
      }
    } catch (e) {
      Get.log('getB2cCurrencyCryptoBuyQuote error: $e');
    }
    // timerRefreshQuote();
  }

  Future getB2cSellCurrencyCryptoBuyQuote({String? amount}) async {
    var symbol = fiatSell.value.currency;
    if (symbol == null) return;
    try {
      var res = await OtcApi.instance().b2cCurrencyCryptoBuyQuote('SELL', null, symbol, 'USDT', amount ?? '100', 'TRX');
      cryptoSellRate.value = num.parse(res.cryptoPrice ?? '1');
      fiatSell.value.rate = res.rate;

      if (sellPayTextController.text.isNotEmpty) {
        sellReceiveTextController.text =
            (sellPayTextController.text.toNum() * fiatSell.value.rate).toStringAsFixed(fiatSell.value.precisionInt);
      }
    } catch (e) {
      Get.log('getB2cCurrencyCryptoBuyQuote error: $e');
    }
    // timerRefreshQuote();
  }

  /// 定时刷新报价
  Timer? _timerRefreshQuote;
  void timerRefreshQuote() {
    _timerRefreshQuote?.cancel();
    _timerRefreshQuote = null;
    _timerRefreshQuote = Timer.periodic(const Duration(seconds: 10), (timer) {
      getB2cCurrencyCryptoBuyQuote();
    });
  }

  selectOntap() async {
    final value = await Get.toNamed(Routes.B2C_CURRENCY_SELECT);
    if (value != null) {
      if (index.value == 0) {
        fiat.value = value;

        await b2cChannelList();
        await getB2cCurrencyCryptoBuyQuote();
      } else {
        fiatSell.value = value;
        getB2cSellCurrencyCryptoBuyQuote();
      }
    }
  }

  @override
  void onClose() {
    buyPayTextController.dispose();
    buyReceiveTextController.dispose();
    sellPayTextController.dispose();
    sellReceiveTextController.dispose();
    buyTimer?.cancel();
    sellTimer?.cancel();

    super.onClose();
  }

  Future<void> onBuy({bool isBuy = true}) async {
    AppsFlyerManager().logEvent(AFLogEventName.recharge_b2c_buy);

    try {
      EasyLoading.show();
      var amount = isBuy ? buyPayTextController.text : sellPayTextController.text;
      var cryptoQuantity = isBuy ? buyReceiveTextController.text : sellReceiveTextController.text;
      var payWayCode = isBuy ? channelModel.payTypeList![channelIndex.value].payWayCode : null;

      if (isBuy) {
        await getB2cCurrencyCryptoBuyQuote(amount: amount);
        cryptoQuantity = (amount.toNum() / fiat.value.rate).toStringAsFixed(crypto.value.precisionInt);
      } else {
        await getB2cSellCurrencyCryptoBuyQuote(amount: amount);
        cryptoQuantity = (amount.toNum() * fiatSell.value.rate).toStringAsFixed(crypto.value.precisionInt);
      }

      final res = await OtcApi.instance().b2cOrderTransaction(
          isBuy ? 'BUY' : 'SELL', amount, fiat.value.currency, 'USDT', 'TRX', payWayCode.toString(), cryptoQuantity);
      String? url = res['payUrl'];
      if (url != null) {
        launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
      }
    } catch (error) {
      Get.log('error ===== ${error.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }

  RxList<B2CCurrencyModel> get fiatArray {
    if (index.value == 0) {
      return fiatList;
    } else {
      return fiatSellList;
    }
  }

  checkPayList() {
    if (index.value == 0) {
      if (fiatList.isEmpty || fiat.value.code == null) {
        getB2cCurrencyFiat();
      }
    } else {
      if (fiatSellList.isEmpty || fiatSell.value.code == null) {
        getB2cSellCurrencyFiat();
      }
    }
  }

  void onMax() {
    sellPayTextController.text = AssetsGetx.to.c2cBalance.toNum().toPrecision(crypto.value.precision?.toInt() ?? 2);
  }

  void onRecharge() {}
}
