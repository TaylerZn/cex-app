import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_history_order.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_detail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_traderdetail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_manage_list.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_taker_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_trader_position.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//

class FollowTakerInfoController extends GetxController
    with GetTickerProviderStateMixin {
  FollowTakerInfoController();

  bool showCollect = false;
  bool showBottom = false;
  bool showView = false;
  bool showHistoryView = false;
  bool showFollowView = false;

  var showBar = false.obs;
  var subFilterIndex = 0.obs;
  var textColorValue = Colors.black.obs;
  var currentIndex = 0;
  var navBarColor = Colors.white.obs;

  late TabController tabController;
  FollowViewType viewType = FollowViewType.other;
  List<FollowTakerType> tabArray = [];
  ScrollController? scrollVC;
  double offset = -100;
  double scrollVCOffset = 0;

  RefreshController overviwRefreshVc = RefreshController();
  bool overviwHaveMoreData = true;

  Rx<FollowkolUserDetailModel> detailModel = FollowkolUserDetailModel().obs;

  Rx<FollowkolTraderDetailModel> expression = FollowkolTraderDetailModel().obs;
  RefreshController expressionRefreshVc = RefreshController();

  Rx<FollowTradePositionModel> currentOrder = FollowTradePositionModel().obs;
  RefreshController currentOrderRefreshVc = RefreshController();

  Rx<FollowHistoryOrderModel> historyOrder = FollowHistoryOrderModel().obs;
  RefreshController historyOrderRefreshVc = RefreshController();

  Rx<FollowMyManageListModel> follower = FollowMyManageListModel().obs;
  RefreshController followerRefreshVc = RefreshController();

  Rx<FollowComment> overviewComment = FollowComment().obs;

  Rx<FollowComment> comment = FollowComment().obs;
  RefreshController commentRefreshVc = RefreshController();

  var topic = TopicdetailModel().obs;
  bool isCustomerVC = false;

  var isShowStartInfo =
      false.obs; //是否显示星标用户;这里写死,等待后台给,isShowStartInfo 给显示影藏的逻辑
  @override
  void onInit() {
    super.onInit();
    // scrollVC!.addListener(() {
    //   print('hhhhhhhhhhh-------------offset:${scrollVC!.offset}');
    //   showBar.value = scrollVC!.offset < 100.h ? false : true;

    //   if (detailModel.value.isKol == 1) {
    //     var appBarOpacity = (scrollVC!.offset / 100).clamp(0.0, 1.0);
    //     if (appBarOpacity < 0) {
    //       textColorValue.value = Colors.white;
    //       navBarColor.value = const Color(0xFF131516);
    //     } else if (appBarOpacity > 1) {
    //       textColorValue.value = Colors.black;
    //       navBarColor.value = Colors.white;
    //     } else {
    //       textColorValue.value = Color.lerp(Colors.white, Colors.black, appBarOpacity)!;
    //       navBarColor.value = Color.lerp(const Color(0xFF131516), Colors.white, appBarOpacity)!;
    //     }
    //   }
    // });

    getInfoModel();
  }

  scrollControllerOffsetY(double offsetY, bool up) {
    offset = offsetY - scrollVCOffset;
    if (scrollVCOffset > 0) {
      textColorValue.value = Colors.black;
      navBarColor.value = Colors.white;
    } else {
      if (offset >= 0) {
        showBar.value = offset < 100.h ? false : true;

        if (detailModel.value.isKol == 1) {
          var appBarOpacity = (offset / 100).clamp(0.0, 1.0);
          if (appBarOpacity < 0) {
            textColorValue.value = Colors.white;
            navBarColor.value = const Color(0xFF131516);
          } else if (appBarOpacity > 1) {
            textColorValue.value = Colors.black;
            navBarColor.value = Colors.white;
          } else {
            textColorValue.value =
                Color.lerp(Colors.white, Colors.black, appBarOpacity)!;
            navBarColor.value = Color.lerp(
                const Color(0xFF131516), Colors.white, appBarOpacity)!;
          }
        }
      }
    }
  }

  set scrollViewController(ScrollController vc) {
    if (scrollVC == null) {
      scrollVC = vc;
      scrollVC!.addListener(() {
        scrollVCOffset = scrollVC!.offset;
      });
    }
  }

  getInfoModel() {
    if (detailModel.value.uid == -1) {
      var uid = Get.arguments?['uid'] ?? UserGetx.to.uid;
      detailModel.value.uid = uid;
    }

    AFFollow.getUserDetailById(uid: detailModel.value.uid).then((value) {
      value.uid = detailModel.value.uid;
      if (value.isKol == 0) {
        showCollect = false;
        showBottom =
            detailModel.value.uid.toInt() == UserGetx.to.user?.info?.id;

        if (detailModel.value.uid.toInt() == UserGetx.to.user?.info?.id) {
          viewType = FollowViewType.mySelfToCustomer;
        } else {
          viewType = UserGetx.to.user?.info?.isKol == true
              ? FollowViewType.traderToCustomer
              : FollowViewType.customerToCustomer;
        }

        setTab = [
          FollowTakerType.performance,
          FollowTakerType.likeFavourite,
        ];
      } else {
        showCollect =
            detailModel.value.uid.toInt() != UserGetx.to.user?.info?.id;

        if (value.copySetting == 2) {
          showView = true;
        } else if (value.copySetting == 1) {
          showView = value.followStatus == 1 ? true : false;
        } else {
          showView = false;
        }

        if (value.hisSetting == 2) {
          showHistoryView = true;
        } else if (value.hisSetting == 1) {
          showHistoryView = value.followStatus == 1 ? true : false;
        } else {
          showHistoryView = false;
        }

        if (value.followSetting == 2) {
          showFollowView = true;
        } else if (value.followSetting == 1) {
          showFollowView = value.followStatus == 1 ? true : false;
        } else {
          showFollowView = false;
        }

        if (detailModel.value.uid.toInt() == UserGetx.to.user?.info?.id) {
          viewType = FollowViewType.mySelfToTrader;
          showBottom = false;
          showView = true;
          showHistoryView = true;
          showFollowView = true;
          setTab = [
            FollowTakerType.overview,
            FollowTakerType.performance,
            FollowTakerType.currentSingle,
            FollowTakerType.historySingle,
            FollowTakerType.userReview,
            FollowTakerType.follower,
            FollowTakerType.likeFavourite,
          ];
        } else {
          viewType = UserGetx.to.user?.info?.isKol == true
              ? FollowViewType.traderToTrader
              : FollowViewType.customerToTrader;
          showBottom = UserGetx.to.user?.info?.isKol == true ? false : true;

          setTab = [
            FollowTakerType.overview,
            FollowTakerType.performance,
            FollowTakerType.currentSingle,
            FollowTakerType.historySingle,
            FollowTakerType.userReview
          ];
        }
        navBarColor.value = const Color(0xFF131516);
        textColorValue = Colors.white.obs;
      }
      detailModel.value = value;

      update();
      showSheetView(value);
    });
  }

  set setTab(List<FollowTakerType> takerTab) {
    tabArray = takerTab;
    tabArray = tabArray.sublist(Get.arguments?['uid'] == null ? 1 : 0);
    tabController = TabController(length: tabArray.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
        getData();
      }
    });
    if (Get.arguments?['index'] == 4) {
      tabController.index = tabArray.length - 1;
    }
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future? getData({bool isPullDown = false}) async {
    var type =
        tabArray.isEmpty ? FollowTakerType.overview : tabArray[currentIndex];

    switch (type) {
      case FollowTakerType.overview:
        return getOverData(isPullDown: isPullDown);
      case FollowTakerType.performance:
        return getExpressData(isPullDown: isPullDown);
      case FollowTakerType.currentSingle:
        return getCurrentFollowData(isPullDown: isPullDown);
      case FollowTakerType.historySingle:
        return getHistoryFollowData(isPullDown: isPullDown);
      case FollowTakerType.follower:
        return getFollowData(isPullDown: isPullDown);
      case FollowTakerType.userReview:
        return getuUerReview(isPullDown: isPullDown);
      default:
    }
  }

  Future getOverData({bool isPullDown = false}) async {
    getCurrentFollowData(isPullDown: isPullDown);
    getOverviewuUerReview(isPullDown: isPullDown);
    getMyFocusPageList(isPullDown: isPullDown);
    return getExpressData(isPullDown: isPullDown);
  }

  Future getExpressData({bool isPullDown = false}) async {
    if (expression.value.monthProfit != null && !isPullDown) return null;
    return AFFollow.copyTraderDetail(traderId: detailModel.value.uid)
        .then((value) {
      expression.value = value;
    });
  }

  Future getOverviewuUerReview({bool isPullDown = false}) async {
    return AFFollow.getTop2Rating(traderUid: detailModel.value.uid)
        .then((value) {
      overviewComment.value = value;
    });
  }

  Future getuUerReview({bool isPullDown = false}) async {
    return AFFollow.getRatingPage(
            traderUid: detailModel.value.uid, page: 1, pageSize: 10)
        .then((value) {
      comment.value = value;
    });
  }

  Future getMyFocusPageList({bool isPullDown = false}) async {
    var res = await myFocusPageList('1', '1', '', '${detailModel.value.uid}');
    if (res.data != null) {
      for (var i = 0; i < res.data!.length; i++) {
        var item = TopicdetailModel.fromJson(res.data![i]);

        topic.value = item;
      }
    }
  }

  Future getCurrentFollowData({bool isPullDown = false}) async {
    if (isPullDown) {
      currentOrder.value.page = 1;
    } else {
      if (currentOrder.value.list != null && currentOrder.value.page == 1)
        return null;
    }
    return AFFollow.getTradePosition(
            page: currentOrder.value.page,
            pageSize: currentOrder.value.pageSize,
            traderId: detailModel.value.uid)
        .then((value) {
      int page = currentOrder.value.page;
      var pageSize = value.list?.length;

      if (page != 1) {
        currentOrder.value.list?.addAll(value.list ?? []);
        value.list = currentOrder.value.list;
      }
      currentOrder.value = value;
      currentOrder.value.page = page;
      currentOrder.value.haveMore = pageSize == currentOrder.value.pageSize;
    });
  }

  Future getHistoryFollowData({bool isPullDown = false}) async {
    if (isPullDown) {
      historyOrder.value.page = 1;
    } else {
      if (historyOrder.value.list != null && historyOrder.value.page == 1)
        return null;
    }
    return AFFollow.getHistoryCopyOrder(
            page: historyOrder.value.page,
            pageSize: historyOrder.value.pageSize,
            uid: detailModel.value.uid)
        .then((value) {
      int page = historyOrder.value.page;
      var pageSize = value.list?.length;

      if (page != 1) {
        historyOrder.value.list?.addAll(value.list ?? []);
        value.list = historyOrder.value.list;
      }
      historyOrder.value = value;
      historyOrder.value.page = page;
      historyOrder.value.haveMore = pageSize == historyOrder.value.pageSize;
    });
  }

  Future getFollowData({bool isPullDown = false}) async {
    if (isPullDown) {
      follower.value.page = 1;
    } else {
      if (follower.value.list != null && follower.value.page == 1) return null;
    }
    return AFFollow.getMyFollowManageList(
      listType: 1,
      traderId: detailModel.value.uid,
      page: follower.value.page,
      pageSize: follower.value.pageSize,
    ).then((value) {
      int page = follower.value.page;
      var pageSize = value.list?.length;

      if (page != 1) {
        follower.value.list?.addAll(value.list ?? []);
        value.list = follower.value.list;
      }
      follower.value = value;
      follower.value.page = page;
      follower.value.haveMore = pageSize == follower.value.pageSize;
    });
  }

  setTraceUserRelation() {
    var status = !detailModel.value.isFollow;
    AFFollow.setTraceUserRelation(
            userId: detailModel.value.uid.toInt(),
            status: status ? 1 : 0,
            types: 0)
        .then((value) {
      detailModel.update((val) {
        val?.isFollowStart = status ? 1 : 0;
      });
      // var model = FollowKolInfo.fromJson(infoModel.value.toJson());
      // model.isFollowStart = status ? 1 : 0;
      // infoModel.value = model;
      UIUtil.showSuccess(
          status ? LocaleKeys.follow117.tr : LocaleKeys.follow118.tr);
    });
  }

  setProhibitAction({required num userId, required int types}) {
    //status  0取消 1设置
    // type 0标星  1拉黑 2禁止跟单

    AFFollow.setTraceUserRelation(userId: userId, status: 1, types: types)
        .then((value) {
      if (value == null) {
        UIUtil.showSuccess(LocaleKeys.follow119.tr);
        currentOrder.update((val) {
          val?.list?.removeWhere((element) => element.uid == userId);
        });
      } else {
        UIUtil.showToast(LocaleKeys.follow120.tr);
      }
    });
  }

  showSheetView(FollowkolUserDetailModel model) {
    if (model.isBlacklistedUsers == 1) {
      showshieldSheetView(FollowActionType.shield, isDismissible: false,
          callback: () {
        Get.back();
        Get.back();
      });
    } else {
      // if (model.isDisableUsers == 1) {
      //   showshieldSheetView(FollowActionType.prohibit, callback: () => Get.back());
      // }
    }
  }

  goTabWithIndex(int index) {
    if (index < 0) {
      scrollVC!.animateTo(
        scrollVC!.position.maxScrollExtent - 20,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      tabController.index = index;
    }
  }
}
