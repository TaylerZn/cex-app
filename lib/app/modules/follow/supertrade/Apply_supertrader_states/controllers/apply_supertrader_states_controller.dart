import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/model/apply_supertrade_person.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ApplySupertraderStatesController extends GetxController {
  final List<ApplySupertradeStatesModel> messageArray = [
    ApplySupertradeStatesModel(icon: '1', title: LocaleKeys.follow271.tr, des: LocaleKeys.follow272.tr),
    ApplySupertradeStatesModel(icon: '2', title: LocaleKeys.follow273.tr, des: LocaleKeys.follow274.tr),
    ApplySupertradeStatesModel(icon: '3', title: LocaleKeys.follow275.tr, des: LocaleKeys.follow276.tr),
    ApplySupertradeStatesModel(icon: '4', title: LocaleKeys.follow277.tr, des: LocaleKeys.follow278.tr)
  ];
  final List<ApplySupertradeStatesModel> statesArray = [];
  bool isSuccess = false;
  int? states;
  var btnStr = '';

  @override
  void onInit() {
    super.onInit();

    Future.wait([checkApplyTrader(), getData()]).then((value) => update());
  }

  //-1未申请，0审核中，1已通过，2已拒绝等等。
  Future getData() async {
    var value = await AFFollow.applyStatus();
    states = value['status'];
    if (states == 0) {
      btnStr = LocaleKeys.follow289.tr;
    } else if (states == 1) {
      btnStr = LocaleKeys.follow290.tr;
    } else {
      btnStr = LocaleKeys.follow288.tr;
      states = -1;
    }
    return value;
  }

  Future checkApplyTrader() async {
    var value = await AFFollow.checkApplyTrader(traderId: UserGetx.to.uid ?? -1);

    statesArray.clear();
    statesArray.add(ApplySupertradeStatesModel(
        icon: '1', title: LocaleKeys.follow280.tr, des: LocaleKeys.follow281.tr, isSuccess: value.isKyc == 1));
    statesArray.add(ApplySupertradeStatesModel(
        icon: '2', title: LocaleKeys.follow307.tr, des: LocaleKeys.follow283.tr, isSuccess: value.overAmount == 1));
    statesArray.add(ApplySupertradeStatesModel(
        icon: '3', title: LocaleKeys.follow308.tr, des: LocaleKeys.follow328.tr, isSuccess: value.winRate == 1));
    statesArray.add(ApplySupertradeStatesModel(
        icon: '4', title: LocaleKeys.follow309.tr, des: LocaleKeys.follow328.tr, isSuccess: value.profitability == 1));
    statesArray.add(ApplySupertradeStatesModel(
        icon: '5', title: LocaleKeys.follow329.tr, des: LocaleKeys.follow328.tr, isSuccess: value.monthlyCountAmount == 1));

    statesArray.add(ApplySupertradeStatesModel(
        icon: '6', title: LocaleKeys.follow284.tr, des: LocaleKeys.follow285.tr, isSuccess: value.inviteCondition == 1));
    statesArray.add(ApplySupertradeStatesModel(
        icon: '7', title: LocaleKeys.follow286.tr, des: LocaleKeys.follow287.tr, isSuccess: value.positionCondition == 1));
    isSuccess = value.isKyc == 1 &&
        value.overAmount == 1 &&
        value.inviteCondition == 1 &&
        value.positionCondition == 1 &&
        value.winRate == 1 &&
        value.profitability == 1 &&
        value.monthlyCountAmount == 1;
    return value;
    // AFFollow.checkApplyTrader(traderId: UserGetx.to.uid ?? -1).then((value) {
    //   statesArray.clear();
    //   statesArray.add(ApplySupertradeStatesModel(
    //       icon: '1', title: LocaleKeys.follow280.tr, des: LocaleKeys.follow281.tr, isSuccess: value.isKyc == 1));
    //   statesArray.add(ApplySupertradeStatesModel(
    //       icon: '2', title: LocaleKeys.follow282.tr, des: LocaleKeys.follow283.tr, isSuccess: value.overAmount == 1));
    //   statesArray.add(ApplySupertradeStatesModel(
    //       icon: '3', title: LocaleKeys.follow284.tr, des: LocaleKeys.follow285.tr, isSuccess: value.inviteCondition == 1));
    //   statesArray.add(ApplySupertradeStatesModel(
    //       icon: '4', title: LocaleKeys.follow286.tr, des: LocaleKeys.follow287.tr, isSuccess: value.positionCondition == 1));
    //   isSuccess = value.isKyc == 1 && value.overAmount == 1 && value.inviteCondition == 1 && value.positionCondition == 1;
    //   update();
    // });
  }

  tradeApply() {
    AFFollow.traderApply().then((value) {
      if (value == null) {
        states = -2;
        update();
        Get.toNamed(Routes.APPLY_SUPERTRADER_SUCCESS);
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
