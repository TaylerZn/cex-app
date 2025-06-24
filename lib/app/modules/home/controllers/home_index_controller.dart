import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/notify_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/activity.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/interest.dart';
import 'package:nt_app_flutter/app/models/home/home.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_home_traker/controllers/follow_home_traker_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/splash/controllers/splash_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';
import 'package:nt_app_flutter/app/widgets/dialog/app_update_dialog.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeIndexController extends GetxController
    with GetTickerProviderStateMixin {
  List<TopicdetailModelWrapper> recommendList = <TopicdetailModelWrapper>[];
  int recommendPages = 1;
  int recommendTotalPages = 1;

  EasyRefreshController refreshController = EasyRefreshController();
  RefreshController tabViewRefreshController = RefreshController();
  ScrollController scrollController = new ScrollController();

  MyPageLoadingController loadingController = MyPageLoadingController();

  bool isGetInterestPeople = false;
  bool isGetCmsAdvertList = false;

  late TabController tabController;

  @override
  void onInit() {
    addCommunityListen();
    CheckAppUpdate.autoCheck();
    loadingController.setSuccess();
    getPostList();
    _listenConnectState();

    scrollController.addListener(() {
      if (scrollController.offset > 300) {
        MyCommunityUtil.homeButton.currentState?.changeMode(1);
      } else {
        MyCommunityUtil.homeButton.currentState?.changeMode(2);
      }
    });

    _setTabController();
    Bus.getInstance().on(EventType.login, (data) {
      _setTabController();
      update();
    });
    Bus.getInstance().off(EventType.signOut, (data) {
      _setTabController();
      update();
    });

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        Bus.getInstance().emit(EventType.postSend, null);
      }
    });

    super.onInit();
  }

  _setTabController() {
    if (UserGetx.to.isLogin) {
      tabController = TabController(length: 2, vsync: this);
    } else {
      tabController = TabController(length: 1, vsync: this);
    }
  }

  getOnRefresh() async {
    recommendList.clear();
    recommendPages = 1;
    recommendTotalPages = 1;
    isGetInterestPeople = false;
    isGetCmsAdvertList = false;
    await getPostList();
    refreshController.finishRefresh(IndicatorResult.success, true);
  }

  getOnLoading() async {
    if (recommendTotalPages <= recommendPages) {
      tabViewRefreshController.loadNoData();
    } else {
      recommendPages = recommendPages + 1;
      await getPostList();
      tabViewRefreshController.loadComplete();
    }
  }

  getPostList() async {
    List<TopicdetailModelWrapper> list;
    if (recommendPages == 1) {
      list = [];
    } else {
      list = recommendList;
    }
    var res = await topicpageList('$recommendPages', '10', '', '');

    if (res != null) {
      for (var i = 0; i < res.data!.length; i++) {
        var item = TopicdetailModel.fromJson(res.data![i]);
        list.add(TopicdetailModelWrapper(item));
      }
      recommendList = list;
      recommendTotalPages = res.totalPage;
      getInterestPeople();
      getCmsAdvertList();
      update();
    }
  }

  //获取感兴趣的人
  getInterestPeople() async {
    if (isGetInterestPeople == false) {
      try {
        List<InterestPeopleListModel?>? res =
            await CommunityApi.instance().getInterestPeople();

        if (res != null && res.isNotEmpty) {
          TopicdetailModel data = TopicdetailModel(interestPeopleList: res);
          if (recommendList.length > 2) {
            recommendList.insert(2, TopicdetailModelWrapper(data));
          } else {
            recommendList.add(TopicdetailModelWrapper(data));
          }
          isGetInterestPeople = true;
        }
        update();
      } catch (e) {
        Get.log('error when fetchContractOptionalList: $e');
        return [];
      }
    }
  }

  //获取活动
  getCmsAdvertList() async {
    if (isGetCmsAdvertList == false) {
      try {
        CmsAdvertModel? res = await CommunityApi.instance()
            .getCmsAdvertList(ActivityEnumn.homePost.position, '0');

        if (res != null) {
          TopicdetailModel data = TopicdetailModel(cmsDatatList: res.list);
          recommendList.removeWhere((item) => item.model.cmsDatatList != null);
          if (recommendList.length > 4) {
            recommendList.insert(4, TopicdetailModelWrapper(data));
          } else {
            recommendList.add(TopicdetailModelWrapper(data));
          }
          isGetCmsAdvertList = true;
        }
        update();
      } catch (e) {
        Get.log('error when getCmsAdvertList: $e');
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    getOnRefresh();
  }

  void backToTop() {
    scrollController.jumpTo(0);
    getPostList();
  }

  // 监听社区事件
  addCommunityListen() {
    Bus.getInstance().on(EventType.blockUser, (data) {
      recommendList.removeWhere((item) => item.model.memberId == data);
      update();
    });

    Bus.getInstance().on(EventType.delPost, (data) {
      recommendList.removeWhere((item) => item.model.id == data);
      update();
    });
    Bus.getInstance().on(EventType.postUpdate, (data) {
      int index = recommendList.indexWhere((item) => item.model.id == data.id);
      if (index != -1) {
        recommendList[index] = TopicdetailModelWrapper(data);
      }
      update();
    });

    Bus.getInstance().on(EventType.changeLang, (data) {
      NoticeGetx.to.getRefresh();
      LinksGetx.to.getRefresh();
      isGetCmsAdvertList = false;
      getCmsAdvertList();
      AreaGetx.to.countryTypeList.clear();
    });
  }

  // 监听社区事件
  removeCommunityListen() {
    Bus.getInstance().off(EventType.changeLang, (data) {});
    Bus.getInstance().off(EventType.blockUser, (data) {});
    Bus.getInstance().off(EventType.delPost, (data) {});
    Bus.getInstance().off(EventType.postUpdate, (data) {});
    Bus.getInstance().off(EventType.login, (data) {});
    Bus.getInstance().off(EventType.signOut, (data) {});
  }

  @override
  void onClose() {
    refreshController.dispose();
    tabController.dispose();
    removeCommunityListen();
    scrollController.dispose();
    super.onClose();
  }

  final Connectivity _connectivity = Connectivity();
  bool? connectState;

  _listenConnectState() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      var isFirst = BoolKV.isFirstInstall.get(); //只在第一次安装有效

      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        if (connectState == false && isFirst == null) {
          connectState = true;
          BoolKV.isFirstInstall.set(false);
          onInit(); //首页加载

          var homeFollow = Get.find<FollowHomeTrakerController>();
          homeFollow.onInit(); //首页跟单加载

          MarketDataManager.instance.getHotSymbol(); //首页热门

          var splash = Get.find<SplashController>();
          splash.onReady(); //全局数据加载
        }
      } else {
        connectState = false;
      }
    });
  }
}
