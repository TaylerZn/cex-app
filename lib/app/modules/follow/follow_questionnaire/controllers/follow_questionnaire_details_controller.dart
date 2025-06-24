import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/follow/follow.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/utilities/ui_util.dart';
import '../../follow_orders/data/follow_data.dart';
List<Map<String, dynamic>> investorTypeModels = [
  {
    "name": LocaleKeys.follow346, //'保守投资者',
    'characteristic': LocaleKeys.follow347
        , //"您的评估结果显⽰，您偏向于保守型投资者。您注重资⾦的安全性，规避⾼⻛险投资，通常对市场波动较为敏感，偏好稳定的收益。您的投资决策往往谨慎，且倾向于⻓期持有低⻛险资产。",
    'tactics': LocaleKeys.follow348
        .tr, //"建议您选择低⻛险、稳定收益的交易员。这些交易员通常采⽤较保守的策略，投资于低波动率的市场和资产，以确保资⾦的安全性和持续的回报。",
    "suggest":
    LocaleKeys.follow349, //'建议您将资⾦放在稳健且低⻛险的投资中，以防⽌市场波动对您产⽣过⼤的影响。',
    "type": 10,
    "tag":LocaleKeys.follow518// "低风险稳定回报"
  },
  {
    "name": LocaleKeys.follow350, //'稳健投资者',
    'characteristic': LocaleKeys.follow351
        , //"在投资中表现出⼀定的⻛险承受能⼒，愿意承担适度⻛险以获取较⾼回报。您通常会在安全与增⻓之间保持平衡，注重多元化投资，规避过度集中的投资⻛险。",
    'tactics': LocaleKeys.follow352
        , // "我们建议您关注稳健型投资⻛格的交易员。这些交易员通常会采⽤较为均衡的策略，投资于股票、指数基⾦和中等⻛险的⼤宗商品，以实现⻓期稳健的收益。",
    "suggest": LocaleKeys.follow353
        , //  '建议您通过资产分散化来进⼀步降低⻛险，投资组合可以包括股票、指数基⾦、ETF等中等⻛险的资产。同时，您可以定期评估市场趋势和经济状况，以调整您的投资策略，确保在⻛险与收益之间保持平衡。',
    "type": 9,
    "tag":LocaleKeys.follow517//"中风险中回报"
  },
  {
    "name": LocaleKeys.follow354, //'激进型投资者',
    'characteristic': LocaleKeys.follow355
        , // "您在追求⾼回报的同时，愿意承担较⾼的市场⻛险。您通常对市场波动有较⾼的承受能⼒，喜欢短期内实现显著收益的机会，乐于参与⾼⻛险、⾼波动性的投资品种，如加密货币和⼤宗商品。",
    'tactics': LocaleKeys.follow356
        , // "根据您的投资⻛格，建议选择⾼⻛险⾼回报型交易员。这些交易员往往在加密货币、外汇和⾼波动性股票市场进⾏投资，追求短期内的⾼额回报",
    "suggest": LocaleKeys.follow357, //'建议您保持⼀定的流动性，随时调整投资策略，以应对市场突发变化。',
    "type": 8,
    "tag":LocaleKeys.follow435//"高风险高回报"
  },
];
class FollowQuestionnaireDetailsController extends GetxController {
  final count = 0.obs;
  num score = 0;
  RxBool isGetResulting = false.obs;




  RxInt tic = 0.obs;
  void getResult() async {
    score= 0;
    isGetResulting.value = true;
    num basicSupport = 0; // 基础支持分
    num liquidity = 0; // 流动性分
    num riskTolerance = 0; // 风险承受能力分
    num investmentKnowledge = 0; // 投资经验分
    num investmentPreference = 0; // 投资偏好

    int q1Score = q1[selectIndexByQ1.value!]['value'];
    score = score + q1Score;
    basicSupport = basicSupport + q1Score;

    double q2Score = 0;
    selectIndexListByQ2.forEach((element) {
      num i = q2[element]['value'];
      q2Score += i;
    });
    q2Score = ((q2Score / selectIndexListByQ2.length * 5 / 1.5) * 100)
            .ceilToDouble() /
        100;
    score = score + q2Score;
    basicSupport = basicSupport + q2Score;

    int q3Score = 0;
    q3.forEach((element) {
      if (element['answer'] == element['select']) {
        q3Score = q3Score + 1;
      }
    });
    score = score + q3Score;
    investmentKnowledge = investmentKnowledge + q3Score;

    int q4Score = q4[selectIndexByQ4.value!]['value'];
    score = score + q4Score;
    liquidity = liquidity + q4Score;

    int q5Score = q5[selectIndexByQ5.value!]['value'];
    score = score + q5Score;
    liquidity = liquidity + q5Score;

    int q6Score = q6[selectIndexByQ6.value!]['value'];
    score = score + q6Score;
    riskTolerance = riskTolerance + q6Score;

    int q7Score = q7[selectIndexByQ7.value!]['value'];
    score = score + q7Score;
    riskTolerance = riskTolerance + q7Score;

    int q8Score = q8[selectIndexByQ8.value!]['value'];
    score = score + q8Score;
    investmentKnowledge + investmentKnowledge + q8Score;

    double q9Score = 0;
    selectIndexListByQ9.forEach((element) {
      num i = q9[element]['value'];
      q9Score += i;
    });
    q9Score = ((q9Score / selectIndexListByQ9.length * 5 / 1.5) * 100)
            .ceilToDouble() /
        100;
    score = score + q9Score;
    investmentPreference = investmentPreference + q9Score;

    int q10Score = q10[selectIndexByQ10.value!]['value'];
    score = score + q10Score;
    investmentPreference = investmentPreference + q10Score;

    String investorType = "Conservative";

    Map typeModel;
    if (score <= 25) {
      investorType = "Conservative";
      typeModel = investorTypeModels[0];
    } else if (26 <= score && score <= 35) {
      investorType = "Moderate";
      typeModel = investorTypeModels[1];
    } else {
      investorType = "Aggressive";
      typeModel = investorTypeModels[2];
    }
    try {
      dynamic value = await FollowApi.instance().sumbmitRiskAssessment(
          basicSupport,
          liquidity,
          riskTolerance,
          investmentKnowledge,
          investmentPreference,
          score,
          investorType);

      Bus.getInstance().emit(EventType.followAnswerDone, null);
      Timer.periodic(Duration(milliseconds: 30), (timer) {
        tic.value++;
        if(tic.value>=100){
          timer.cancel();
          Get.offAndToNamed(
            Routes.FOLLOW_QUESTIONNAIRE_RESULT,
            arguments: {
              "model": typeModel,
              "basicSupport": basicSupport,
              "liquidity": liquidity,
              "riskTolerance": riskTolerance,
              "investmentKnowledge": investmentKnowledge,
              "investmentPreference": investmentPreference
            },
          );
        }
      });
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
      Get.back();
    }

    // isGetResulting.value = true;
    // await Future.delayed(Duration(seconds: 3));
    // Get.offAndToNamed(Routes.FOLLOW_QUESTIONNAIRE_RESULT);
    /// todo:  跳转
  }

  bool canNext() {
    if (count.value == 0 && selectIndexByQ1.value == null) {
      return false;
    }
    if (count.value == 1 && selectIndexListByQ2.isEmpty) {
      return false;
    }
    if (count.value == 2 && q3.where((p0) => p0['select'] == null).isNotEmpty) {
      return false;
    }
    if (count.value == 3 && selectIndexByQ4.value == null) {
      return false;
    }
    if (count.value == 4 && selectIndexByQ5.value == null) {
      return false;
    }
    if (count.value == 5 && selectIndexByQ6.value == null) {
      return false;
    }
    if (count.value == 6 && selectIndexByQ7.value == null) {
      return false;
    }
    if (count.value == 7 && selectIndexByQ8.value == null) {
      return false;
    }
    if (count.value == 8 && selectIndexListByQ9.isEmpty) {
      return false;
    }
    if (count.value == 9 && selectIndexByQ10.value == null) {
      return false;
    }
    return true;
  }

  void increment() {
    if (count.value == 0 && selectIndexByQ1.value == null) {
      return;
    }
    if (count.value == 1 && selectIndexListByQ2.isEmpty) {
      return;
    }
    if (count.value == 2 && q3.where((p0) => p0['select'] == null).isNotEmpty) {
      return;
    }
    if (count.value == 3 && selectIndexByQ4.value == null) {
      return;
    }
    if (count.value == 4 && selectIndexByQ5.value == null) {
      return;
    }
    if (count.value == 5 && selectIndexByQ6.value == null) {
      return;
    }
    if (count.value == 6 && selectIndexByQ7.value == null) {
      return;
    }
    if (count.value == 7 && selectIndexByQ8.value == null) {
      return;
    }
    if (count.value == 8 && selectIndexListByQ9.isEmpty) {
      return;
    }
    if (count.value == 9 && selectIndexByQ10.value == null) {
      return;
    }
    if (count.value >= 9) {
      getResult();
    } else {
      count.value++;
    }
  }

  RxnInt selectIndexByQ1 = RxnInt();
  List<Map<String, dynamic>> q1 = [
    {
      'title': LocaleKeys.follow342
          .tr, //I have received formal education and obtained relevant academic qualifications or professional certifications in the field of finance, economics or investments.
      'value': 5
    },
    {
      'title': LocaleKeys.follow343
          .tr, //Although I don't have relevant academic qualifications, I have a certain understanding of finance and investment through self-study or work practice.
      'value': 3
    },
    {
      'title': LocaleKeys.follow344
          .tr, //I have no professional education or training in the field of finance or economics.
      'value': 1
    },
  ];

  RxList selectIndexListByQ2 = RxList();
  List<Map<String, dynamic>> q2 = [
    {
      'title': LocaleKeys.follow358.tr,
      'value': 1,
      'icon': 'flow/flow_ques_gz'
    }, //工资
    {
      'title': LocaleKeys.follow359.tr,
      'value': 1.5,
      'icon': 'flow/flow_ques_tz'
    }, //投资
    {
      'title': LocaleKeys.follow360.tr,
      'value': 1,
      'icon': 'flow/flow_ques_cx'
    }, //储蓄
    {
      'title': LocaleKeys.follow361.tr,
      'value': 1.5,
      'icon': 'flow/flow_ques_ylj'
    }, //养老金
    {
      'title': LocaleKeys.follow362.tr,
      'value': 1.5,
      'icon': 'flow/flow_ques_jcyc'
    }, //继承遗产
    {
      'title': LocaleKeys.follow363.tr,
      'value': 0.5,
      'icon': 'flow/flow_ques_shebao'
    }, //社保
    {
      'title': LocaleKeys.follow364.tr,
      'value': 0.5,
      'icon': 'flow/flow_ques_jtzc'
    }, //家庭支持
    {
      'title': LocaleKeys.follow365.tr,
      'value': 1,
      'icon': 'flow/flow_ques_qsf'
    }, //遣散费
    {
      'title': LocaleKeys.follow366.tr,
      'value': 0.5,
      'icon': 'flow/flow_ques_qt'
    }, //其他
  ];

  RxList<Map<String, dynamic>> q3 = [
    {
      'title': LocaleKeys.follow367
          .tr, // "我以20:1的杠杆率投资了1,000美元,建立了20,000美元的头寸。如果市场波动导致我的头寸下跌5%,即我将损失1,000美元。",
      'value': 1,
      'answer': true,
      'select': null
    },
    {
      'title': LocaleKeys.follow368.tr, //"如果某股票价格上涨,则我关联的差价合约(CFD)的价格将下跌。",
      'value': 1,
      'answer': false,
      'select': null
    },
    {
      'title': LocaleKeys.follow369
          .tr, // '我必须维持足够的保证金,以满足我未平仓杠杆头寸的保证金要求。否则,BITCOCO可能会对我的头寸进行强制平仓。',
      'value': 1,
      'answer': true,
      'select': null
    },
    {
      'title': LocaleKeys.follow370.tr, // '即使市场波动触发了我设置的止损价格,我的未平仓头寸仍不会被平仓',
      'value': 1,
      'answer': false,
      'select': null
    },
    {
      'title': LocaleKeys.follow371.tr, //'如果市场迅速下跌,我的差价合约将在确切止损位平仓。',
      'value': 1,
      'icon': '',
      'answer': false,
      'select': null
    },
  ].obs;

  RxnInt selectIndexByQ4 = RxnInt();
  List<Map<String, dynamic>> q4 = [
    {'title': LocaleKeys.follow372.tr, 'value': 1}, //几秒，最多24小时
    {'title': LocaleKeys.follow373.tr, 'value': 3}, //几周，最多数月
    {'title': LocaleKeys.follow374.tr, 'value': 5}, //超过几个月/几年
  ];

  RxnInt selectIndexByQ5 = RxnInt();
  List<Map<String, dynamic>> q5 = [
    {'title': LocaleKeys.follow375.tr, 'value': 5, 'money': 1000000}, //100万美元以上
    {
      'title': LocaleKeys.follow376.tr,
      'value': 4,
      'money': 500000
    }, // 50-100万美元
    {'title': LocaleKeys.follow377.tr, 'value': 4, 'money': 200000}, //20-50万美元
    {'title': LocaleKeys.follow378.tr, 'value': 3, 'money': 50000}, //5-20万美元
    {'title': LocaleKeys.follow379.tr, 'value': 2, 'money': 10000}, //1-5万美元
    {'title': LocaleKeys.follow380.tr, 'value': 1, 'money': 10000}, //1万美元或以下
  ];

  RxnInt selectIndexByQ6 = RxnInt();
  List<Map<String, dynamic>> q6 = [
    {
      'value': 5,
      'percent': '80%',
      'percentValue': '800,000',
      'width': 116.w,
      'moneyPercent': 0.8
    },
    {
      'value': 4,
      'percent': '40%',
      'percentValue': '400,000',
      'width': 60.w,
      'moneyPercent': 0.4
    },
    {
      'value': 3,
      'percent': '20%',
      'percentValue': '200,000',
      'width': 36.w,
      'moneyPercent': 0.2
    },
    {
      'value': 2,
      'percent': '10%',
      'percentValue': '100,000',
      'width': 22.w,
      'moneyPercent': 0.1
    },
    {
      'value': 1,
      'percent': '5%',
      'percentValue': '50,000',
      'width': 14.w,
      'moneyPercent': 0.05
    },
  ];

  RxnInt selectIndexByQ7 = RxnInt();
  List<Map<String, dynamic>> q7 = [
    {'title': LocaleKeys.follow381.tr, 'value': 1}, //规避,尽量选择低风险
    {'title': LocaleKeys.follow382.tr, 'value': 3}, //适度接受,愿意尝试部分高风险投资
    {'title': LocaleKeys.follow383.tr, 'value': 5}, //偏好风险,追求高收益
  ];
  RxnInt selectIndexByQ8 = RxnInt();
  List<Map<String, dynamic>> q8 = [
    {
      'title': LocaleKeys.follow384.tr,
      'value': 4
    }, //我对复制交易的机制、潜在的风险和收益有深刻认识,并能理解其中的策略。
    {
      'title': LocaleKeys.follow385.tr,
      'value': 3
    }, //我知道复制交易的基本原理和风险,但在某些细节上仍需进一步了解。
    {'title': LocaleKeys.follow386.tr, 'value': 2}, //我对复制交易了解不多,仅掌握基本概念,缺乏深入理解。
    {'title': LocaleKeys.follow387.tr, 'value': 1}, //我对复制交易几乎没有了解,不清楚其风险和收益的特征。
  ];

  RxList selectIndexListByQ9 = RxList();
  List<Map<String, dynamic>> q9 = [
    {
      'title': LocaleKeys.follow388.tr,
      'value': 1,
      'icon': 'flow/flow_ques_pre_gp'
    }, //股票
    {
      'title': LocaleKeys.follow389.tr,
      'value': 1.5,
      'icon': 'flow/flow_ques_pre_wh'
    }, //外汇
    {
      'title': LocaleKeys.follow390.tr,
      'value': 1.5,
      'icon': 'flow/flow_ques_pre_jmhb'
    }, //加密货币
    {
      'title': LocaleKeys.follow391.tr,
      'value': 1,
      'icon': 'flow/flow_ques_pre_zs'
    }, //指数
    {
      'title': LocaleKeys.follow392.tr,
      'value': 1,
      'icon': 'flow/flow_ques_pre_ETH'
    }, //ETF
    {
      'title': LocaleKeys.follow393.tr,
      'value': 1.5,
      'icon': 'flow/flow_ques_pre_dzsp'
    }, //大宗商品
    {
      'title': LocaleKeys.follow394.tr,
      'value': 0.5,
      'icon': 'flow/flow_ques_pre_qt'
    }, //其他
    {
      'title': LocaleKeys.follow395.tr,
      'value': 0.5,
      'icon': 'flow/flow_ques_pre_wph'
    }, //无偏好
  ];

  RxnInt selectIndexByQ10 = RxnInt();
  List<Map<String, dynamic>> q10 = [
    {'title': LocaleKeys.follow396.tr, 'value': 5}, //我偏好选择追求高收益的交易员,愿意承受较大的风险。
    {
      'title': LocaleKeys.follow397.tr,
      'value': 3
    }, //我希望选择兼顾风险和收益的交易员,追求稳健的投资策略。
    {'title': LocaleKeys.follow398.tr, 'value': 1}, //我更倾向选择低风险、稳定收益的交易员,注重本金安全。
  ];
}
