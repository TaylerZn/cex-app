import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_questionnaire/models/follow_risk_query_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/utilities/ui_util.dart';
import 'follow_questionnaire_details_controller.dart';

class FollowQuestionnaireResultController extends GetxController {
  //TODO: Implement FollowQuestionnaireController
  num basicSupport = 0; // 基础支持分
  num liquidity = 0; // 流动性分
  num riskTolerance = 0; // 风险承受能力分
  num investmentKnowledge = 0; // 投资经验分
  num investmentPreference = 0; // 投资偏好
  Map model = {};
  FollowRiskQueryModel? resModel;

  @override
  void onInit() {
    super.onInit();
    try{
      if (Get.arguments['model'] != null && Get.arguments['model'] is FollowRiskQueryModel) {
        resModel = Get.arguments['model'];
        basicSupport = resModel!.basicSupport ?? 0;
        liquidity = resModel!.liquidity ?? 0;
        riskTolerance = resModel!.riskTolerance ?? 0;
        investmentKnowledge = resModel!.investmentKnowledge ?? 0;
        investmentPreference = resModel!.investmentPreference ?? 0;
        matchTypeModel();
        if(model.isEmpty){
          UIUtil.showToast(LocaleKeys.public51.tr);
          Get.back();
        }
      } else {
        model = Get.arguments['model'] ?? {};
        basicSupport = Get.arguments['basicSupport'] ?? 0;
        liquidity = Get.arguments['liquidity'] ?? 0;
        riskTolerance = Get.arguments['riskTolerance'] ?? 0;
        investmentKnowledge = Get.arguments['investmentKnowledge'] ?? 0;
        investmentPreference = Get.arguments['investmentPreference'] ?? 0;

      }
    }catch(e){
      UIUtil.showToast(LocaleKeys.public51.tr);
      Get.back();
    }

    // {
    //         "model": typeModel,
    //         "basicSupport": basicSupport,
    //         "liquidity": liquidity,
    //         "riskTolerance": riskTolerance,
    //         "investmentKnowledge": investmentKnowledge,
    //         "investmentPreference": investmentPreference
    //       }
  }

  void toPage() {
    Get.toNamed(Routes.TRADER_REFERRAL_VIEW, arguments: {
      "model": model,
      "basicSupport": basicSupport,
      "liquidity": liquidity,
      "riskTolerance": riskTolerance,
      "investmentKnowledge": investmentKnowledge,
      "investmentPreference": investmentPreference
    });
  }

  void matchTypeModel() {
    int investorTypeInt = resModel!.investorTypeInt;
    for (var typeModel in investorTypeModels) {
      if (typeModel['type'] == investorTypeInt) {
        model = typeModel;
        break;
      }
    }
  }
}
