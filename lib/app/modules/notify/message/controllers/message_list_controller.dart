import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/message/user_message.dart';
import 'package:nt_app_flutter/app/models/notice/notice.dart';
import 'package:nt_app_flutter/app/modules/notify/message/models/message_list_models.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../widgets/basic/list_view/get_list_controller.dart';
import '../../../community/community_message/controllers/community_message_controller.dart';

class MessageListController extends GetListController<UserMessage>{

  final List<MessageListModel> array = [
    MessageListModel(id: 0, name: LocaleKeys.user223.tr), //全部消息
    MessageListModel(id: 1, name: LocaleKeys.user224.tr), //系统消息
    MessageListModel(id: 2, name: LocaleKeys.user225.tr), //充值提现
    MessageListModel(id: 3, name: LocaleKeys.user226.tr), //安全消息
    MessageListModel(id: 4, name: LocaleKeys.user227.tr), //认证消息
    MessageListModel(id: 5, name: LocaleKeys.user228.tr), //爆仓消息
    MessageListModel(id: 6, name: LocaleKeys.user229.tr), //减仓消息
    MessageListModel(id: 7, name: LocaleKeys.user230.tr), //场外消息
    MessageListModel(id: 8, name: LocaleKeys.user231.tr), //全部消息
    MessageListModel(id: 9, name: LocaleKeys.user232.tr), //结算消息
    MessageListModel(id: 10, name: LocaleKeys.community80.tr), //社区消息
  ];



  int pageIndex = 1;
  int pageSize = 10;
  int messageType = 0;
  List<UserMessage> dataList = [];

  @override
  void onInit() {
    super.onInit();

    messageType = Get.arguments['messageType'] ?? 0;
  }

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  String getMessageIcon(int messageType) {
    return CommunityMessageController.iconMapping(messageType);
  }

  void onTypeChange(int index) {
    var type = array[index].id;
    if (messageType == type) return;
    update();
  }

  @override
  Future<List<UserMessage>> fetchData() async {
    //需要给后台打补丁
    if (messageType == 115 || messageType ==116) { //公告活动
      final addTpyeInt = messageType == 115 ? 1 : 2;
      NoticeModel res = await PublicApi.instance().getNoticeInfoListNew(pageIndex, pageSize, addTpyeInt);
      List<UserMessage> temp = [];
      res.noticeInfoList.forEach((notice) {
        temp.add(UserMessage(
            messageType: messageType,
            messageContent: notice.contentText,
            messageTypeName: null,
            extInfo: null,
            httpUrl: notice.httpUrl,
            contentText: notice.contentText,
            title: notice.title,
            lang: null,
            noticeType: null,
            source: null,
            id: notice.id as int?,
            ctime: notice.timeLong as int?,
            timeLong: notice.timeLong as int?));
      });

      return temp;
    }else{
      Map<String,dynamic> res = await PublicApi.instance().getV2UserMessageList(
        pageIndex,
        pageSize,
        messageType , //社区的传值是100
      );

      List<dynamic> list = res['records'];
      List<UserMessage> temp = [];
      list.forEach((element) {
        temp.add( UserMessage.fromJson(element));
      });
      return temp;
    }


  }
}
