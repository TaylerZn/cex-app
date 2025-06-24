import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/message/user_message.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_main/controllers/assets_main_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';

import '../../../../models/contract/res/public_info.dart';

enum MessageItemType {
  none(0),
  follow(1),
  followTrader(2),
  followManae(3),
  followTraderHome(4),
  followAccount(5),
  trade(6),
  community(10);

  const MessageItemType(this.key);
  final int key;
}

MessageItemType checkExtInfo(String? extInfo) {
  if (ObjectUtil.isEmpty(extInfo)) {
    return MessageItemType.none;
  }

  bool isValidJson(String str) {
    try {
      jsonDecode(str);
      return true;
    } on FormatException {
      return false;
    }
  }

  if (isValidJson(extInfo.toString())) {
    Map<String, dynamic>? param = jsonDecode(extInfo!);
    if (ObjectUtil.isNotEmpty(param?['code'])) {
      int? key = param?['code'];
      switch (key) {
        //消息类型
        case 1:
          return MessageItemType.follow;
        case 2:
          return MessageItemType.followTrader;
        case 3:
          return MessageItemType.followManae;
        case 4:
          return MessageItemType.followTraderHome;
        case 5:
          return MessageItemType.followAccount;
        case 6:
          return MessageItemType.trade;
        case 10:
          return MessageItemType.community;
      }
    }
  }
  return MessageItemType.none;
}

void handleItemMessage(UserMessage message) {
  if (message.messageType == 115 || message.messageType == 116) {
    if (message.httpUrl != null) {
      Get.toNamed(Routes.WEBVIEW, arguments: {'url': message.httpUrl});
    }
    return;
  }

  MessageItemType type = checkExtInfo(message.extInfo);
  var json = jsonDecode(message.extInfo ?? '{}');
  switch (type) {
    case MessageItemType.follow:
      {
        RouteUtil.goTo('/follow-orders');
      }
      break;
    case MessageItemType.followTrader:
      {
        Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': json['userId']});
      }
      break;
    case MessageItemType.followManae:
      {
        Get.toNamed(Routes.MY_TAKE_BLOCK, arguments: {'type': MyTakeShieldActionType.applyFor});
      }
      break;
    case MessageItemType.followTraderHome:
      {
        Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': json['userId']});
      }
      break;
    case MessageItemType.followAccount:
      {
        AssetsMainController.navigateToFlow();
      }
      break;
    case MessageItemType.trade:
      int contractId = json['contractId'] ?? 1; // 合约id，现货id
      // int contractType = json['type']; // 1标准 2永续
      if (json['typeInt'] == 'FUTURES') {
        //永续
        ContractInfo? contractInfo = ContractDataStoreController.to.getContractInfoByContractId(contractId);
        if (contractInfo != null) {
          goToContractKline(contractInfo: contractInfo);
        }
      } else {
        ContractInfo? contractInfo = CommodityDataStoreController.to.getContractInfoByContractId(contractId);
        if (contractInfo != null) {
          goToCommodityKline(contractInfo: contractInfo);
        }
      }
      break;
    case MessageItemType.community:
      {
        TopicdetailModel model = TopicdetailModel.fromJson(jsonDecode(message.extInfo ?? '{}'));
        MyCommunityUtil.jumpToTopicDetail(model);
      }
      break;

    // TODO: Handle this case.
    case MessageItemType.none:
      break;
    // TODO: Handle this case.
  }
}
