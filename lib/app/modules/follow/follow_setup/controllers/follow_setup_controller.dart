import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_kol_cancel.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_detail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_kol_setting.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_trader_position.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_setup_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_setup_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_mark.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowSetupController extends GetxController with GetSingleTickerProviderStateMixin {
  var currentIndex = 0.obs;

  final fillterTabs = <FollowSetupModel>[
    FollowSetupModel(FollowSetupType.fixedAmount),
    FollowSetupModel(FollowSetupType.fixedProportion)
  ];
  late FollowKolInfo trader;
  late bool isSmart;
  late bool isEdit;
  late bool isMore;
  late bool isGuide;

  Rx<FollowTradePositionModel> currentOrder = FollowTradePositionModel().obs;
  var accountModel = FollowTraderAccountModel().obs;
  var cancelDetail = FollowCancelDetail().obs;
  List? symbolList;
  List? symbolIconList;
  num rate = 0;
  var smartVC = TextEditingController().obs;
  var isChecked = false.obs;
  late BuildContext context;
  var textVC = TextEditingController();
  final fillterTimeTabs = <FollowSetupTimeType>[FollowSetupTimeType.followFuture, FollowSetupTimeType.followPresent];
  var timeIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    trader = Get.arguments['model'];
    isSmart = Get.arguments['isSmart'] ?? false;
    isEdit = Get.arguments['isEdit'] ?? false;
    isMore = Get.arguments['isMore'] ?? false; //再次跟单
    isGuide = Get.arguments['isGuide'] ?? false;

    if (isGuide) {
      var grop = '${AppGuideType.follow.name}${isSmart ? 2 : 3}';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Intro.of(context).start(group: grop);
        });
      });
    } else {
      getData();
    }
  }

  getData() {
    getMyTraderAccount();
    getEditData();
    if (isSmart) {
      AFFollow.getRate(kolUid: trader.uid).then((value) {
        rate = value.rato ?? 0;
      });
    } else {
      AFFollow.getTradePosition(page: currentOrder.value.page, pageSize: currentOrder.value.pageSize, traderId: trader.uid)
          .then((value) {
        currentOrder.value = value;
      });
    }
  }

  getMyTraderAccount() {
    AFFollow.getMyCopyTraderAccount().then((value) {
      accountModel.value = value;
      // if (!isEdit && !isMore) {
      //   smartVC.value.text = value.amount != null ? value.amount.toString() : '';
      // }
    });
    AFFollow.getTraderProductCode(traderId: trader.uid).then((value) => symbolIconList = value);
    getKolInfo();
  }

  Future<FollowKolTraderInfoModel?> getKolInfo() {
    return AFFollow.getTraderInfo(traderId: trader.uid).then((value) {
      if (value != null) {
        trader.monthProfitRate = value.monthProfitRate;
        trader.winRate = value.winRate;
        trader.rate = value.rate;

        update();
      }
      return value;
    });
  }

  maxAmount() {
    if (accountModel.value.amount == null) {
      getMyTraderAccount();
    } else {
      smartVC.value.text = accountModel.value.amount.toString();
    }
  }

  getEditData() {
    // if (isEdit || isMore) {
    AFFollow.traceSettingInfo(uid: trader.uid).then((value) {
      var tempModelFirst = fillterTabs.first;
      var tempModelLast = fillterTabs.last;

      var max = value.info?.singleMaxAmount;
      var min = value.info?.singleMinAmount;
      tempModelFirst.min = min ?? 10;
      tempModelFirst.max = max ?? 10000;
      tempModelLast.min = min ?? 10;
      tempModelLast.max = max ?? 10000;
      tempModelFirst.hintText =
          '${tempModelFirst.getmConvert(min ?? 10, isDefault: false)}-${tempModelFirst.getmConvert(max ?? 10000, isDefault: false)}';
      tempModelLast.hintText = tempModelFirst.hintText;
      if (isEdit || isMore) {
        if (value.followRecord != null) {
          if (isSmart) {
            FollowKolRecord record = value.followRecord!;
            smartVC.value.text = record.total.toString();
          } else {
            FollowKolRecord record = value.followRecord!;
            var model = record.followType == 1 ? fillterTabs[0] : fillterTabs[1];
            currentIndex.value = record.followType == 1 ? 0 : 1;
            model.controllerArray[0].text = record.singleTotal.toString();
            model.controllerArray[1].text = record.total.toString();
            model.controllerArray[2].text = record.stopDeficit.toString();
            model.controllerArray[3].text = record.stopProfit.toString();
            model.hintText = '${model.getmConvert(min ?? 10)}-${model.getmConvert(max ?? 10000)}';
            timeIndex.value = record.copyMode == 0 ? 0 : 1;
          }
        }
      }
      update();
    });

    if (isEdit) {
      AFFollow.cancelDetail(uid: trader.uid).then((value) {
        cancelDetail.value = value;
      });
    }
  }

  cancelFollow() {
    AFFollow.cancelFollow(uid: trader.uid).then((value) {
      if (value == null) {
        Get.until((route) => Get.currentRoute == Routes.MAIN_TAB);

        var detailModel = FollowkolUserDetailModel(
            userName: trader.userName, imgUrl: trader.icon, flagIcon: trader.flagIcon, uid: trader.uid);
        textVC.text = '';
        showFollowMarkheetView(
            currentContext: context, bottomType: FollowMarkType.mark, detailModel: detailModel, textVC: textVC);

        UIUtil.showSuccess(LocaleKeys.follow49.tr);
      } else {
        Get.back();
        UIUtil.showToast(LocaleKeys.follow50.tr);
      }
    });
  }

  FollowInfoModel get followInfo {
    FollowSetupModel setupModel = fillterTabs[currentIndex.value];
    setupModel.model.followType = currentIndex.value + 1;
    setupModel.model.timeType = timeIndex.value;
    setupModel.model.icon = trader.icon;
    setupModel.model.name = trader.userName;
    setupModel.model.uid = trader.uid;
    setupModel.model.levelType = trader.levelType;

    setupModel.model.symbolIconList = symbolIconList;
    if (isSmart) {
      setupModel.model.smartAmount = smartVC.value.text;
      setupModel.model.rate = '$rate%';
    }
    return setupModel.infoModel;
  }

  getSymbolList() async {
    var value = await AFFollow.symbolInfo(uid: trader.uid);
    symbolList = value.symbolList;
  }

  bool verifyData({bool isSmart = false}) {
    if (isSmart) {
      if (smartVC.value.text.isEmpty) {
        UIUtil.showToast(LocaleKeys.follow51.tr);
        return false;
      }
      if (double.parse(smartVC.value.text) < 10) {
        UIUtil.showToast(LocaleKeys.follow52.tr);
        return false;
      }
      var amount = accountModel.value.amount;
      if (amount != null && double.parse(smartVC.value.text) > amount) {
        UIUtil.showToast(LocaleKeys.follow239.tr);
        return false;
      }
      return true;
    } else {
      var model = fillterTabs[currentIndex.value].infoModel;
      var tabModel = fillterTabs[currentIndex.value];
      if (model.singleAmount.isEmpty) {
        UIUtil.showToast(LocaleKeys.follow51.tr);
        return false;
      }
      if (currentIndex.value == 0) {
        if (double.parse(model.singleAmount) < 10) {
          UIUtil.showToast(LocaleKeys.follow52.tr);
          return false;
        }
      } else {
        if (double.parse(model.singleAmount) < 0.01) {
          UIUtil.showToast(LocaleKeys.follow53.tr);
          return false;
        }
      }

      var amount = accountModel.value.amount;
      if (amount != null && double.parse(model.amount) > amount) {
        UIUtil.showToast(LocaleKeys.follow239.tr);
        return false;
      }

      if (model.amount.isEmpty) {
        UIUtil.showToast(LocaleKeys.follow54.tr);
        return false;
      }
      if (double.parse(model.amount) < tabModel.min) {
        UIUtil.showToast(LocaleKeys.follow299.trArgs([tabModel.min.toString()]));
        return false;
      }

      if (double.parse(model.amount) > tabModel.max) {
        UIUtil.showToast(LocaleKeys.follow300.trArgs([tabModel.max.toString()]));
        return false;
      }

      if (model.isStopDeficitNum == 1) {
        if (num.parse(model.stopDeficit) > 90) {
          UIUtil.showToast(LocaleKeys.follow57.tr);
          return false;
        }
      }

      // if (model.isStopProfitNum == 1) {
      //   if (num.parse(model.stopProfit) > 100) {
      //     UIUtil.showToast(LocaleKeys.follow56.tr);
      //     return false;
      //   }
      // }

      return true;
    }
  }

  void postData() async {
    var model = fillterTabs[currentIndex.value].model;

    // print('hhhhhhhh--1--${model.singleAmount}');
    // print('hhhhhhhh--2--${model.amount}');

    // print('hhhhhhhh--3--${model.isStopDeficitNum}');
    // print('hhhhhhhh--4--${model.stopDeficit}');

    // print('hhhhhhhh--5--${model.isStopProfitNum}');
    // print('hhhhhhhh--6--${model.stopProfit}');

    // print('hhhhhhhh--7--${model.followType}');
    // print('hhhhhhhh--8--${model.timeType}');

    // if (symbolList == null) {
    //   await getSymbolList();
    // }

    var value = await AFFollow.postkolFollow(
      uid: model.uid,
      amount: model.amount,
      singleAmount: num.parse(model.singleAmount),
      isStopDeficit: model.isStopDeficitNum,
      stopDeficit: model.stopDeficit,
      isStopProfit: model.isStopProfitNum,
      stopProfit: model.stopProfit,
      followType: model.followType,
      timeType: model.timeType,
      // symbolRelationStr: jsonEncode(symbolList)
    );

    if (value == null) {
      Get.offNamedUntil(Routes.FOLLOW_SETUP_SUCCESS, (route) {
        return route.isFirst;
      });
    } else {}
  }

  void postSmartData() {
    ///智能跟单

    AFFollow.getSpecialFollow(traderId: trader.uid, amount: num.parse(smartVC.value.text)).then((value) {
      if (value == null) {
        Get.offNamedUntil(Routes.FOLLOW_SETUP_SUCCESS, (route) {
          return route.isFirst;
        });
      } else {
        Get.back();
        UIUtil.showError(value is String && value.isNotEmpty ? value : LocaleKeys.follow58.tr);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
