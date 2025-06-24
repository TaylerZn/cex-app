import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'dart:async';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/models/community/focus.dart';
import 'package:nt_app_flutter/app/models/community/greed_voting.dart';
import 'package:nt_app_flutter/app/models/community/hot_topic.dart';
import 'package:nt_app_flutter/app/models/community/interest.dart';
import 'package:nt_app_flutter/app/models/community/vote_wrapper.dart';
import 'package:nt_app_flutter/app/modules/community/widget/more_dialog.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';

class CommunityListController extends GetxController with GetTickerProviderStateMixin {
  num? uid;
  String? tagKey;
  bool myPage;

  CommunityListController({this.uid, this.tagKey, this.myPage = false, this.isGetInterestPeople = false, this.isCmplete});
  ScrollController scrollController = ScrollController();
  final RefreshController refreshController = RefreshController();
  MyPageLoadingController loadingController = MyPageLoadingController();
  List<TopicdetailModelWrapper> recommendList = <TopicdetailModelWrapper>[];
  int recommendPages = 1;
  int recommendTotalPages = 1;
  Timer? resendTimer;
  int? voteValue;
  List<HotTopicModel> hotTopicModel = [];
  //----贪婪指数缓存---
  int? value = 0;
  GreedVotingModel? model;

  Rx<VoteWrapper?> voteWrapper = VoteWrapper().obs;

  dynamic voting;
  //----------

  late final AnimationController animationController;
  LottieComposition? composition;
  bool isSendExpand = false;
  bool isGetInterestPeople = false;
  Function(bool)? isCmplete;
  @override
  void onInit() {
    super.onInit();
    loadLottieComposition();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    addCommunityListen();
    getRecommendList();
    getBearishData(); //贪婪数据
    topicTalkingPointList();
    Bus.getInstance().on(EventType.postSend, (data) {
      try {
        refreshController.requestRefresh(needMove: false);
      } catch (e) {}
    });
    Bus.getInstance().on(EventType.changeLang, (data) {
      update();
    });
  }

  void backToTop() {
    scrollController.jumpTo(0);
    getRecommendList();
  }

  Future<void> getBearishData() async {
    dynamic voteOption = await CommunityApi.instance().isVotedTopic('sys');
    voteWrapper.value?.voting = voteOption?['votingOption'];

    dynamic history = await CommunityApi.instance().greedHistory();
    voteWrapper.value?.value = history?['value'] ?? 0;
    dynamic model = await CommunityApi.instance().voteInfo();
    voteWrapper.value?.model = model;
  }

  reloadList(MoreActionType type, TopicdetailModel model) {
    TopicdetailModelWrapper? wrapper = recommendList.firstWhereOrNull((element) => element.model.topicNo == model.topicNo);
    switch (type) {
      case MoreActionType.delete:
        {
          recommendList.remove(wrapper);
          update();
        }
        break;
      case MoreActionType.like:
        {
          recommendList.forEach((element) {
            if (element.model.memberId == model.memberId) {
              element.model.focusOn = model.focusOn;
            }
          });
          update();
        }
        break;
      case MoreActionType.block:
        {}
        break;
      default:
        {
          getRecommendList();
        }
    }
  }

  getRecommendList() async {
    List<TopicdetailModelWrapper> list;
    if (recommendPages == 1) {
      list = [];
    } else {
      list = recommendList;
    }
    dynamic res;
    if (tagKey != 'myStar' && !myPage) {
      loadGraphData();
      if (tagKey == 'Market2') {
        //关注列表
        res = await focusPageList('$recommendPages', '10', '', '${uid ?? UserGetx.to.uid}');
      } else {
        res = await topicpageList('$recommendPages', '10', '', '${uid ?? ''}');
      }
    } else if (myPage) {
      res = await myFocusPageList('$recommendPages', '10', '', '${uid ?? ''}');
    } else {
      res = await topicCollectPage('$recommendPages', '10', '', '${uid ?? ''}');
    }

    if (res != null) {
      for (var i = 0; i < res.data!.length; i++) {
        var item = TopicdetailModel.fromJson(res.data![i]);
        TopicdetailModelWrapper model = TopicdetailModelWrapper(item, type: TopicdetailModelType.normal);
        list.add(model);
      }

      if (UserGetx.to.isLogin && tagKey == ('Market1')) {
        TopicdetailModelWrapper? wrapper = list.firstWhereOrNull((element) => element.type == TopicdetailModelType.recommended);
        if (ObjectUtil.isEmpty(wrapper)) {
          list.insert(5, TopicdetailModelWrapper(TopicdetailModel(), type: TopicdetailModelType.recommended));
          list.insert(3, TopicdetailModelWrapper(TopicdetailModel(), type: TopicdetailModelType.graph));
        }
      }

      recommendList = list;
      recommendTotalPages = res.totalPage;

      getInterestPeople();
      loadingController.setSuccess();
      update();
    }
    if (recommendList.isEmpty) {
      loadingController.setEmpty();
    }
  }

  topicTalkingPointList() async {
    try {
      TopicTalkingPointListModel? res = await CommunityApi.instance().topicTalkingPointList();
      if (res != null) {
        hotTopicModel = res.talkingPointList!;
        update();
      }
      update();
    } catch (e) {
      Get.log('error when getFocusList: $e');
    }
  }

  Future<void> loadGraphData() async {
    try {
      // dynamic response =  await CommunityApi.instance().greedHistory();
      // dynamic voted = await CommunityApi.instance().isVotedTopic('sys');//贪婪指数固定传这个参数
      //
      // if(ObjectUtil.isNotEmpty(response)){
      //   voteValue = response['value'];
      // }
      //
      // GreedVotingModel? model = await  CommunityApi.instance().voteInfo();
      // update();
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }

  getInterestPeople() async {
    if (isGetInterestPeople == false) {
      try {
        List<InterestPeopleListModel?>? res = await CommunityApi.instance().getInterestPeople();

        if (res != null && res.isNotEmpty) {
          TopicdetailModel data = TopicdetailModel(interestPeopleList: res);
          TopicdetailModelWrapper model = TopicdetailModelWrapper(data);

          if (recommendList.length > 2) {
            recommendList.insert(2, model);
          } else {
            recommendList.add(model);
          }
        }
        isGetInterestPeople = true;
        update();
      } catch (e) {
        Get.log('error when fetchContractOptionalList: $e');
      }
    }
  }

  // 监听社区事件
  addCommunityListen() {
    Bus.getInstance().on(EventType.blockUser, (data) {
      recommendList.removeWhere((item) => item.model.memberId == data);
    });
    Bus.getInstance().on(EventType.delPost, (data) {
      recommendList.removeWhere((item) => item.model.id == data);
    });
    Bus.getInstance().on(EventType.postUpdate, (data) {
      int index = recommendList.indexWhere((item) => item.model.id == data.id);
      if (index != -1) {
        recommendList[index] = TopicdetailModelWrapper(data);
      }
      update();
    });
  }

  // 监听社区事件
  removeCommunityListen() {
    Bus.getInstance().off(EventType.blockUser, (data) {});
    Bus.getInstance().off(EventType.delPost, (data) {});
  }

  Future<void> loadLottieComposition() async {
    final bytes = await DefaultAssetBundle.of(Get.context!).load('assets/json/community/send.json');
    final compositionDate = await LottieComposition.fromBytes(bytes.buffer.asUint8List());

    composition = compositionDate;
    animationController.duration = composition?.duration;
    update(['send']);
  }

  void playAnimation(int startFrame, int endFrame) {
    if (composition == null) return;
    final frameCount = composition!.endFrame - composition!.startFrame;
    final startProgress = startFrame / frameCount;
    final endProgress = endFrame / frameCount;
    animationController.animateTo(
      endProgress,
      duration: Duration(milliseconds: ((endProgress - startProgress) * composition!.duration.inMilliseconds).round()),
      curve: Curves.linear,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    removeCommunityListen();
    animationController.dispose();
    super.onClose();
  }

  onLoading() async {
    if (recommendTotalPages <= recommendPages) {
      // refreshController.loadNoData();

      isCmplete?.call(false);
    } else {
      recommendPages = recommendPages + 1;
      await getRecommendList();

      // refreshController.loadComplete();
      isCmplete?.call(true);
    }
  }
}
