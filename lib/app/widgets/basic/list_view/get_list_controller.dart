import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/locales.g.dart';

abstract class GetListController<T> extends GetxController
    with StateMixin<List<T>> {
  /// 初始化页码
  int pageIndex = 1;

  /// 每页数量
  int pageSize = 10;

  /// 刷新控制器
  late RefreshController refreshController;

  /// 数据列表
  List<T> dataList = [];

  /// 是否在正在刷新
  bool _isRefreshing = false;
  bool _isLoadingMore = false;

  @override
  void onInit() {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  /// 刷新
  /// [pull] 是否是下拉刷新
  refreshData(bool pull) async {
    try {
      if (_isRefreshing) return;
      _isRefreshing = true;

      pageIndex = 1;
      dataList.clear();
      if (!pull) {
        change(dataList, status: RxStatus.loading());
      }
      final res = await fetchData();
      dataList.addAll(res);
      change(dataList,
          status: res.isEmpty ? RxStatus.empty() : RxStatus.success());
      if (pull) {
        refreshController.refreshCompleted(resetFooterState: true);
      } else {
        refreshController.resetNoData();
      }
    } catch (e) {
      if (pull) {
        refreshController.refreshFailed();
      } else {
        change(null, status: RxStatus.error(LocaleKeys.trade42.tr));
        refreshController.resetNoData();
      }
    } finally {
      _isRefreshing = false;
    }
  }

  /// 上拉加载更多
  loadMoreData() async {
    try {
      if (_isLoadingMore) return;
      _isLoadingMore = true;

      pageIndex++;
      final res = await fetchData();
      dataList.addAll(res);
      change(dataList, status: RxStatus.success());
      if (res.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
    } finally {
      _isLoadingMore = false;
    }
  }

  /// 获取数据
  Future<List<T>> fetchData();
}
