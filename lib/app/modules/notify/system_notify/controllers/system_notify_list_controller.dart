import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/config/config_api.dart';
import 'package:nt_app_flutter/app/models/config/system_message_res.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SystemNotifyListController extends GetxController {
  late RefreshController refreshController;
  List<SystemMessageInfo> dataList = [];
  int _currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }
}

extension SystemNotifyControllerX on SystemNotifyListController {
  onRefresh() async {
    try {
      _currentPage = 1;
      final res =
          await ConfigApi.instance().systemMessageList(_currentPage++, 20);
      if (res.data.isEmpty) {
        refreshController.loadNoData();
      } else {
        dataList = res.data;
        refreshController.refreshCompleted();
      }
      update();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  onLoadMore() async {
    try {
      final res =
          await ConfigApi.instance().systemMessageList(_currentPage++, 20);
      if (res.data.isEmpty) {
        refreshController.loadNoData();
      } else {
        dataList.addAll(res.data);
        refreshController.refreshCompleted();
      }
      update();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }
}
