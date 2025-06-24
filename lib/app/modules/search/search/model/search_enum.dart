import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum SearchResultsType {
  all,
  contract,
  spot,
  community,
  trader,
  functiontype;

  String get value => [
        LocaleKeys.public35.tr,
        LocaleKeys.public36.tr,
        LocaleKeys.public37.tr,
        LocaleKeys.public38.tr,
        LocaleKeys.public39.tr,
        LocaleKeys.public40.tr
      ][index];

  SearchResultsModel get model => SearchResultsModel(this);
}

//
class SearchResultsModel {
  int page = 1;
  int pageSize = 10;
  bool haveMore = false;

  SearchResultsType type;
  MyPageLoadingController loadingController = MyPageLoadingController();
  RefreshController refreshVc = RefreshController();

  // 方法用于将模型状态重置为初始状态
  void reset() {
    page = 1;
    pageSize = 10;
    haveMore = false;
    loadingController = MyPageLoadingController();
    refreshVc = RefreshController();
  }

  SearchResultsModel(this.type) {
    switch (type) {
      case SearchResultsType.all:
        break;
      case SearchResultsType.spot:
        break;
      case SearchResultsType.contract:
        break;
      case SearchResultsType.community:
        pageSize = 3;
        break;
      default:
    }
  }
}
