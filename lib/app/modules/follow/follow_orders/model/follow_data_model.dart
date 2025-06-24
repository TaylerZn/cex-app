import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/notice/notice.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_explore.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_questionnaire/models/follow_risk_query_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//
class FollowOrdersTabModel {
  bool? complete;
  final FollowTopModel topModel = FollowTopModel();
  FollowOrdersTabModel(TickerProvider vsync, {Function()? callBack}) {
    mainTabController = TabController(length: mainTabs.length, vsync: vsync);
    mainTabController.addListener(() {
      if (!mainTabController.indexIsChanging) {
        mainCurrentIndex = mainTabController.index;
        callBack?.call();
      }
    });
    mainTabsRefreshController.addAll(List.generate(mainTabs.length, (index) => RefreshController()));

    futureTabsModelArr =
        futureTabs.map((e) => List.generate(futureFilter.length, (index) => FollowExploreGridModel().obs)).toList();
    futureFilteIndexArray = futureTabs.map((e) => 3.obs).toList();
    futureTabsRefreshArray = futureTabs.map((e) => RefreshController()).toList();

    exploreTabsModelArr = exploreTabs.map((e) => FollowExploreGridModel().obs).toList();
    explorehaveMoreArr = exploreTabs.map((e) => true).toList();

    futureTabController = TabController(length: futureTabsModelArr.length, vsync: vsync);
    futureTabController.addListener(() {
      if (!futureTabController.indexIsChanging) {
        futureCurrentIndex = futureTabController.index;
        callBack?.call();
      }
    });
  }

  //v2

  late TabController mainTabController;
  int mainCurrentIndex = 0;
  final mainTabs = <FollowOrdersNavType>[FollowOrdersNavType.explore, FollowOrdersNavType.futures];
  final mainTabsRefreshController = <RefreshController>[];
  var traderType = [TraderType.daily, TraderType.investor, TraderType.highest, TraderType.diamond, TraderType.focused];
  List<List<Rx<FollowExploreGridModel>>> futureTabsModelArr = [];
  List<RxInt> futureFilteIndexArray = [];
  List<RefreshController> futureTabsRefreshArray = [];

  late TabController futureTabController;
  int futureCurrentIndex = 0;

  final futureTabs = <FollowFutureType>[
    FollowFutureType.all,
    FollowFutureType.market,
    FollowFutureType.diamond,
    ...TraderType.focused.focusedType
  ];

  final exploreTabs = <FollowFutureType>[...TraderType.focused.focusedType];
  List<Rx<FollowExploreGridModel>> exploreTabsModelArr = [];
  List<bool> explorehaveMoreArr = [];

  final futureFilter = <FollowFutureFilterType>[
    FollowFutureFilterType.earnRate,
    FollowFutureFilterType.success,
    FollowFutureFilterType.followDay,
    FollowFutureFilterType.score,
    FollowFutureFilterType.maxCustomer,
    FollowFutureFilterType.trader
  ];

  var showCurrentIndex = 0.obs;
  var focusCurrentIndex = 0.obs;

  bool showAnswerView = false;
  var isSetDone = false.obs;
  var showTip = true.obs;
  Rx<NoticeModel?> noticeModel = Rx<NoticeModel?>(null);
  var shownotice = true.obs;
  FollowRiskQueryModel? queryModel;

  int stackpreviousIndex = 0;
}

enum TraderType {
  daily,
  investor,
  highest,
  diamond,
  focused;

  TraderTopCellModel get model {
    switch (this) {
      case TraderType.daily:
        return TraderTopCellModel(
            title: LocaleKeys.follow503.tr, haveRight: false, icon: 'flow/follow_order_diamond', isStack: true);
      case TraderType.investor:
        return TraderTopCellModel(title: LocaleKeys.follow445.tr, des: LocaleKeys.follow446.tr);

      case TraderType.highest:
        return TraderTopCellModel(
            title: LocaleKeys.follow447.tr,
            selectStr: LocaleKeys.follow510.tr,
            selectStrStyle: AppTextStyle.f_16_600.upColor,
            dataArr: [LocaleKeys.follow510.tr, LocaleKeys.follow449.tr, LocaleKeys.follow450.tr]);

      case TraderType.diamond:
        return TraderTopCellModel(title: LocaleKeys.follow452.tr, des: LocaleKeys.follow453.tr);
      case TraderType.focused:
        return TraderTopCellModel(
            title: LocaleKeys.follow454.tr,
            selectStr: LocaleKeys.markets10.tr,
            selectStrStyle: AppTextStyle.f_16_600.copyWith(color: const Color(0xFFFF9315)),
            dataArr: focusedType.map((e) => e.value).toList());

      default:
        return TraderTopCellModel(title: '');
    }
  }

  List<FollowFutureType> get focusedType {
    return [
      FollowFutureType.crypto,
      FollowFutureType.stocks,
      FollowFutureType.marketIndex,
      FollowFutureType.forex,
      FollowFutureType.bulk,
      FollowFutureType.eTFs
    ];
  }
}

class TraderTopCellModel {
  String title = '';
  String? icon;
  String? des;
  bool haveRight = true;
  bool isStack = false;

  String? selectStr;
  TextStyle? selectStrStyle;
  List<String>? dataArr;
  var currentIndex = 0.obs;
  TraderTopCellModel({
    required this.title,
    this.haveRight = true,
    this.isStack = false,
    this.icon,
    this.des,
    this.dataArr,
    this.selectStr,
    this.selectStrStyle,
  });
}
