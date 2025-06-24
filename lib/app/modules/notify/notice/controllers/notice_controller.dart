import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/models/notice/notice.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NoticeController extends GetxController with StateMixin<List<NoticeInfo>> {
  late RefreshController refreshController;

  int pageIndex = 1;
  int pageSize = 10;
  int messageType = 0;
  List<NoticeInfo> dataList = [];

  @override
  void onInit() {
    super.onInit();
    messageType = Get.arguments['messageType'] ?? 0;
    refreshController = RefreshController(initialRefresh: false);
    dataList = [];
  }

  @override
  void onReady() {
    super.onReady();
    onRefresh(false);
  }

  void onTypeChange(int? type) {
    if (messageType == type) return;
    messageType = type!;
    update();
    // onRefresh(false);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }
}

extension MessageControllerX on NoticeController {
  onRefresh(bool isPull) async {
    pageIndex = 1;
    if (!isPull) {
      change(null, status: RxStatus.loading());
    }

    try {
      final res = await PublicApi.instance().getNoticeInfoList(page: pageIndex++, pageSize: pageSize, type: messageType, position: null);
      dataList.clear();
      dataList.addAll(res.noticeInfoList);

      change(dataList, status: dataList.isNotEmpty ? RxStatus.success() : RxStatus.empty());
      if (isPull) {
        refreshController.refreshCompleted(resetFooterState: true);
      }
    } catch (e) {
      Get.log('refreshData error: $e');
    }
  }

  onLoadMore() async {
    try {
      final res = await PublicApi.instance().getNoticeInfoList(page: pageIndex++, pageSize: pageSize, type: messageType, position: null);
      if (res.noticeInfoList.isNotEmpty) {
        dataList.addAll(res.noticeInfoList);
        change(dataList, status: RxStatus.success());
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
    } catch (e) {
      refreshController.refreshFailed();
    }
  }
}
