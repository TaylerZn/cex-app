import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import '../models/notice/notice.dart';

class NoticeGetx extends GetxController {
  static NoticeGetx get to => Get.find();
  late int messageUnreadCount;

  //公告
  List<NoticeInfo> noticeList = [];
  // 交易公告
  List<NoticeInfo> tradeNoticeList = [];

  //未读消息数量
  int get unreadCount {
    return messageUnreadCount;
  }

  /// 初始化
  @override
  void onInit() {
    getRefresh();
    _fetchTradeNoticeList();
    super.onInit();
  }

  Future<void> getRefresh({bool notify = true}) async {
    await Future.wait([
      getNoticeList(notify: notify),
    ]);
  }

  Future getNoticeList({bool notify = true}) async {
    try {
      var res = await PublicApi.instance().getNoticeInfoList(page: 1, pageSize: 4,type:1,position: 1);
      noticeList = res.noticeInfoList;
      if (notify) {
        update();
      }
    } catch (e) {
      Get.log('getNoticeList error: $e');
    }
  }

  _fetchTradeNoticeList() async {
    try {
      var res = await PublicApi.instance().getNoticeInfoList(page: 1, pageSize: 4,type:1,position: 3);
      tradeNoticeList = res.noticeInfoList;
      update(['tradeNotice']);
    } catch (e) {
      Get.log('getNoticeList error: $e');
    }
  }

  void clean() async {
    noticeList = [];
    update();
  }

  /// 加载完成
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// 控制器被释放
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
