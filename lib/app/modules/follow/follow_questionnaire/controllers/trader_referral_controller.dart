import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_questionnaire/models/follow_risk_query_model.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/follow/follow.dart';
import '../../follow_orders/data/follow_data.dart';
import '../../follow_orders/model/follow_kol_model.dart';

class TraderReferralController extends GetxController {
  //TODO: Implement FollowQuestionnaireController

  num basicSupport = 0; // 基础支持分
  num liquidity = 0; // 流动性分
  num riskTolerance = 0; // 风险承受能力分
  num investmentKnowledge = 0; // 投资经验分
  num investmentPreference = 0; // 投资偏好
  Map model = {};
  FollowRiskQueryModel? resModel;
  RxList<FollowKolInfo> list = RxList();
  @override
  void onInit() {
    super.onInit();
    model = Get.arguments['model'];
    basicSupport = Get.arguments['basicSupport'];
    liquidity = Get.arguments['liquidity'];
    riskTolerance = Get.arguments['riskTolerance'];
    investmentKnowledge = Get.arguments['investmentKnowledge'];
    investmentPreference = Get.arguments['investmentPreference'];
    // {
    //         "model": typeModel,
    //         "basicSupport": basicSupport,
    //         "liquidity": liquidity,
    //         "riskTolerance": riskTolerance,
    //         "investmentKnowledge": investmentKnowledge,
    //         "investmentPreference": investmentPreference
    //       }
    fetchData();
  }

  RxBool isError = false.obs;

  Future<void> fetchData() async {
    EasyLoading.show();
    try {
      var res = await FollowApi.instance().getTraderOpenPreferenceNoPage(type: model['type']);
      list.addAll(res);
      if (list.isEmpty) {
        isError.value = true;
      } else {
        Get.log("list.length:${list.length} -> ${res[0].recordVoList}");
      }
    } on DioException catch (e) {
      isError.value = true;
      EasyLoading.dismiss();
      UIUtil.showError("${e.error}");
    } catch (e) {
      //后台不按约定返回异常
      isError.value = true;
      UIUtil.showError(LocaleKeys.trade42.tr);
    } finally {
      EasyLoading.dismiss();
    }
    // await  FollowApi.instance()
    //     .getTraderOpenPreferenceNoPage(type: model['type'])
    //     .then((value) => list.addAll(value));
    // EasyLoading.dismiss();
  }

  // getData() {
  //   // dynamic value = await FollowApi.instance().flowTradePreference(
  //   //     basicSupport,
  //   //     liquidity,
  //   //     riskTolerance,
  //   //     investmentKnowledge,
  //   //     investmentPreference,
  //   //     score,
  //   //     investorType);
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
