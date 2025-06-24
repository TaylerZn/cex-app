import 'dart:math';

import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_explore.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_data_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_questionnaire/models/follow_risk_query_model.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class FollowOrdersController extends GetxController with GetTickerProviderStateMixin {
  bool isTrader = false;
  late FollowOrdersTabModel model;
  bool? showNoti;
  var gridModel = FollowExploreGridModel();
  @override
  void onInit() {
    super.onInit();
    model = FollowOrdersTabModel(this, callBack: () => getData());
    FollowDataManager.instance.onchangeuser = (p) => getInfoData(p);
  }

  @override
  void onReady() {
    super.onReady();
    FollowDataManager.instance.onCmsAdvertList = () => getCmsAdvertList();

    FollowDataManager.instance.onFollowAnswer = () => getFollowRisk();

    FollowDataManager.instance.callbackData(callback: (p) => getInfoData(p));
  }

  Future getData({bool isPullDown = false, bool isInit = false}) async {
    if (model.mainCurrentIndex == 0) {
      return await getExploreData(isPullDown: isPullDown, isInit: isInit);
    } else {
      return await getFutureData(isPullDown: isPullDown);
    }
  }

  getInfoData(bool isKol) {
    isTrader = isKol;
    model.showAnswerView = false;
    if (isTrader) {
      Future.wait([getKolInfo(), getData(isPullDown: true)]).then((results) {
        model.complete = true;
        update();
      });
    } else {
      if (UserGetx.to.isLogin) {
        model.showAnswerView = true;
        Future.wait([getFollowGeneralInfo(), getData(isPullDown: true, isInit: true), getFollowRisk()]).then((results) {
          model.complete = true;
          update();
        });
      } else {
        getData(isPullDown: true).then((value) {
          FollowExploreGridModel? grid = value;
          if (grid?.isError == true) {
            model.complete = false;
          } else {
            model.complete = true;
          }
          update();
        });
      }
    }
  }

  Future getCmsAdvertList() async {
    var type = isTrader ? ActivityEnumn.followMainTrader : ActivityEnumn.followMain;
    // type = ActivityEnumn.homeInvite;
    var value = await CommunityApi.instance().getCmsAdvertList(type.position, '0');

    if (value != null) {
      model.topModel.cmsModel.value = value;
    }
    return value;
  }

  Future<FollowKolTraderInfoModel?> getKolInfo() {
    return AFFollow.getTraderInfo().then((value) {
      if (value != null) {
        model.topModel.kol = value;
        model.topModel.kol.uid = UserGetx.to.user?.info?.id ?? 0;
      }
      return value;
    });
  }

  Future<FollowGeneralInfoModel?> getFollowGeneralInfo() {
    return AFFollow.getFollowGeneralInfo().then((value) {
      if (value != null) {
        model.topModel.follow = value;
      }
      return value;
    });
  }

  Future<FollowRiskQueryModel?> getFollowRisk() {
    return AFFollow.queryFollowRisk().then((value) {
      if (value != null) {
        model.queryModel = value;
        model.isSetDone.value = true;
      } else {
        model.isSetDone.value = false;
        showAnswerView();
      }
      return value;
    });
  }

  Future getNoticeList() {
    return AFFollow.getNoticeList().then((value) {
      model.noticeModel.value = value;
    });
  }

  showAnswerView() {
    var isSetQuery = BoolKV.isSetQuery.get();
    if (isSetQuery == null && showNoti == true) {
      BoolKV.isSetQuery.set(true);

      if (MainTabController.to.tabIndex.value == 3) {
        Get.toNamed(Routes.FOLLOW_QUESTIONNAIRE);
      }
    }
  }

  Future getExploreData({bool isPullDown = false, bool isInit = false}) async {
    getNoticeList();
    if (!isTrader) {
      getCmsAdvertList();
    }
    Future.wait([getExploreTraderData(isPullDown: isPullDown), getleaderboardData(isPullDown: isPullDown)]).then((results) {
      showNoti = !showGuide;
      update();
      startGuide();
    });

    return getExploreFocusedData(isPullDown: isPullDown);
  }

  Future<FollowExploreGridModel> getExploreTraderData({bool isPullDown = false}) async {
    if (gridModel.popularTrader == null) {
      return AFFollow.getExploreTraderList().then((value) {
        gridModel.popularTrader = value.popularTrader;
        gridModel.steadyTrader = value.steadyTrader;
        gridModel.timesTrader = value.timesTrader;
        return gridModel;
      });
    } else {
      return gridModel;
    }
  }

  Future getleaderboardData({bool isPullDown = false}) async {
    if (gridModel.follow == null) {
      return AFFollow.getleaderboardTop().then((value) {
        gridModel.follow = value.follow?.sublist(0, min(3, value.follow?.length ?? 0));
        gridModel.comprehensiveRating = value.comprehensiveRating?.sublist(0, min(3, value.comprehensiveRating?.length ?? 0));
        gridModel.orderNumber = value.orderNumber?.sublist(0, min(3, value.orderNumber?.length ?? 0));
        return gridModel;
      });
    } else {
      return gridModel;
    }
  }

  Future getExploreFocusedData({bool isPullDown = false}) async {
    int orderByType = model.exploreTabs[model.focusCurrentIndex.value].orderType;
    var currentModel = model.exploreTabsModelArr[model.focusCurrentIndex.value];
    bool haveMore = model.explorehaveMoreArr[model.focusCurrentIndex.value];
    if (haveMore) {
      model.mainTabsRefreshController.first.resetNoData();
    } else {
      model.mainTabsRefreshController.first.loadNoData();
    }

    int page = currentModel.value.page;

    if (isPullDown) {
      page = 1;
    } else {
      if (currentModel.value.list != null && page == 1) return currentModel;
    }

    return AFFollow.getTraderOpenPreference(type: orderByType, page: page, pageSize: currentModel.value.pageSize).then((value) {
      var pageSize = value!.list?.length;
      if (page != 1) {
        currentModel.value.list?.addAll(value.list!);
        value.list = currentModel.value.list;
      }
      currentModel.value = value;
      currentModel.value.page = page;
      currentModel.value.haveMore = pageSize == currentModel.value.pageSize;
      model.explorehaveMoreArr[model.focusCurrentIndex.value] = currentModel.value.haveMore;
      return value;
    });
  }

  Future getFutureData({bool isPullDown = false}) async {
    var filterIndex = model.futureFilteIndexArray[model.futureCurrentIndex];
    int orderByType = model.futureTabs[model.futureCurrentIndex].orderType;
    var currentModel = model.futureTabsModelArr[model.futureCurrentIndex][filterIndex.value];
    int page = currentModel.value.page;
    if (isPullDown) {
      page = 1;
    } else {
      if (currentModel.value.list != null && page == 1) return currentModel;
    }

    return AFFollow.getTraderOpenPreference(
            type: orderByType, collation: filterIndex.value, page: page, pageSize: currentModel.value.pageSize)
        .then((value) {
      var pageSize = value!.list?.length;
      if (page != 1) {
        currentModel.value.list?.addAll(value.list!);
        value.list = currentModel.value.list;
      }
      currentModel.value = value;
      currentModel.value.page = page;
      currentModel.value.haveMore = pageSize == currentModel.value.pageSize;
    });
  }

  setTraceUserRelation(num userId, RxBool isFollow) {
    var status = !isFollow.value;

    AFFollow.setTraceUserRelation(userId: userId.toInt(), status: status ? 1 : 0, types: 0).then((value) {
      isFollow.value = status;

      UIUtil.showSuccess(status ? LocaleKeys.follow117.tr : LocaleKeys.follow118.tr);
    });
  }

  jumpWithType({TraderType? type, int filter = 0}) {
// 综合评分最高（原综合评分)默认   3
// 最多关注者(粉丝数量）         4
// 最大交易次数（交易员最大交易次数字段） 5
    if (type != null) {
      if (type == TraderType.investor) {
        model.mainTabController.index = 1;
        model.futureTabController.index = 1;
      } else if (type == TraderType.highest) {
        var filterIndex = model.futureFilteIndexArray[0];
        filterIndex.value = filter + 3;

        model.mainTabController.index = 1;
        model.futureTabController.index = 0;
      } else if (type == TraderType.diamond) {
        model.mainTabController.index = 1;
        model.futureTabController.index = 2;
      }
    } else {
      model.mainTabController.index = 1;
      model.futureTabController.index = model.focusCurrentIndex.value + 3;
    }
  }

  bool get showGuide {
    if (isTrader) {
      return false;
    } else {
      return AppGuideView.canShowButtonGuide(AppGuideType.follow);
    }
  }

  startGuide() {
    if (MainTabController.to.tabIndex.value == 3 && showNoti == false) {}
    Future.delayed(const Duration(milliseconds: 200), () {
      Intro.of(Get.context!).start(group: '${AppGuideType.follow.name}1');
    });
  }
}
