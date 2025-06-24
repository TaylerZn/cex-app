import 'package:get/get.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/enums/search.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';

class SearchHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SearchHistoryEnumn type;
  Function(String)? onHistoryItemClicked;
  // 接收参数的构造函数
  SearchHistoryController({
    required this.type,
    this.onHistoryItemClicked,
  });
  List historyList = <String>[];
  bool isFold = true;

  @override
  void onInit() {
    Bus.getInstance().on(EventType.searchHistory, getHistoryList);
    getHistoryList(type);
    super.onInit();
  }

  getHistoryList(type) {
    switch (type) {
      case SearchHistoryEnumn.main:
        historyList = ListKV.mainSearchHistory.get() ?? [];

        break;
      case SearchHistoryEnumn.market:
        historyList = ListKV.marketSearchHistory.get() ?? [];

        break;
      default:
    }
    update();
  }

  void clearHistory() {
    ListKV.mainSearchHistory.clear();
    historyList.clear();
    update();
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.searchHistory, getHistoryList);
    super.onClose();
  }
}
