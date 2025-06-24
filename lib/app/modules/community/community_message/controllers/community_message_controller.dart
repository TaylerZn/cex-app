import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/community/community_message/models/communit_message_item_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/community/community.dart';
import '../../../../models/community/community_station_message.dart';

class CommunityMessageController extends GetListController<CommunityMessageItemModel> {
  var messages = <CommunityMessageItemModel>[].obs;
//1-系统消息 2-钱包消息 10-交易信息 100-社区消息 7-otc 115-公告 116-活动  //117-价格预警 118-交易 ???这里需要后台确定
  static  iconMapping(int? tid) {
   Map<int,dynamic> icon = {
     115: 'community/community_message/announcement_info'.svgAssets(), //公告
     116: 'community/community_message/activity_info'.svgAssets(), //活动
     1: 'community/community_message/system_msg_info'.svgAssets(), //系统消息
     100: 'community/community_message/community_msg_info'.svgAssets(), //社区
     117: // 这个是价格预警
     'community/community_message/price_warning_info'.svgAssets(), //价格预警
     2: 'community/community_message/wallet_info'.svgAssets(), //钱包
     7: 'community/community_message/otc_trading_info'.svgAssets(), //OTC交易
     118: //交易
     'community/community_message/trade'.svgAssets(), //交易
   };
   return icon[tid] ?? 'community/community_message/system_msg_info'.svgAssets();
  }

  @override
  void onInit() {
    super.onInit();
    refreshData(false);
  }

  String relativeDateFormat(dynamic timeData) {
    return RelativeDateFormat.relativeDateFormat(timeData,shortFormat: 'MM/dd',longFormat: 'yyyy/MM/dd');
  }

  @override
  Future<List<CommunityMessageItemModel>> fetchData() async {
    // TODO: implement fetchData
    try {
      CommunityStationMessage? msgs =
          await CommunityApi.instance().fetchCommunityStationMessage();

      if (msgs != null) {
      return  messages.value = msgs.records!
            .map((e) => CommunityMessageItemModel(
          iconSrc: iconMapping(e.tid),
          title: e.title,
          subtitle: e.news,
          time: relativeDateFormat(e.ctime),
          notificationCount: e.unreadCount,
          msgId: e.tid,
        ))
            .toList();
      }
    } catch (e) {
      Get.log('error when getCmsAdvertList: $e');
    }
    return [];
  }
}
