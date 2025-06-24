import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'dart:async';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/community_comment_widget/index.dart';
import 'package:nt_app_flutter/app/modules/community/community_video_info/widgets/community_video_loading_widget.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_like_icon.dart';
import 'package:nt_app_flutter/app/widgets/components/community/text/my_special_text_span_builder.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:nt_app_flutter/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';

class CommunityVideoInfoController extends GetxController
    with GetTickerProviderStateMixin, RouteAware {
  dynamic topicNo;
  TopicdetailModel? data;

  /// 来自消息跳转id
  String? infoIdFull;

  final MySpecialTextSpanBuilder mySpecialTextSpanBuilder =
      MySpecialTextSpanBuilder();
  TextEditingController replyController = TextEditingController()..text = '';
  final RefreshController refreshController = RefreshController();
  ScrollController refreshScrollCtl = ScrollController();
  List<CommunityCommentItem> onelevellist = [];
  int onelevelPage = 1;
  int onelevelTotalPage = 1;
  int onelevellistTotal = 0;
  int swiperIndex = 0;
  TextEditingController plControll = TextEditingController();
  TopicdetailModel? infoData;
  final FocusNode focus = FocusNode();
  List<TopicdetailModel> textFieldList = [];
  bool isMe = false;
  String targetDescription = '';
  String targetName = '';
  int translateType = 0;
  SocialsocialpostpublicsfindOneTranslateModel? translateData;

  var isOnePlay = false;
  var isPause = false;
  var isAddSpeed = false;

  /// 是否加速
  var panTop = 0.00;
  late BetterPlayerController betterPlayerController;
  late BetterPlayerDataSource betterPlayerDataSource;
  var progressWidgetKey = 'progress_1';
  var aspectRatio;

  bool condition = false;
  String? videoUrl;
  VideoLoadingWidget? videoLoadingWidget = VideoLoadingWidget();

  bool hasShowAddSpeedTips = true;

  PostLikeIcon? postLikeIcon;
  bool uploadingCollect = false; // 是否正在提交收藏数据
  final GlobalKey newCommentKey = GlobalKey();
  var paddingBottom;

  Map<String, GlobalKey> subCommentKeys = {}; // 二级评论的 GlobalKeys

  @override
  void onInit() {
    topicNo = Get.arguments?['topicNo'] ?? Get.parameters['topicNo'] ?? '';
    data = Get.arguments?['data'] ?? TopicdetailModel();
    super.onInit();
    data?.topicNo = topicNo;
    if (data?.videoList != null && data!.videoList!.isNotEmpty) {
      videoUrl = data?.videoList?[0].fileUrl;
    }
    getVideo();
    getsocialsocialpostpublicsfindOne();
    gettopiccommentpageList();
    // 判断是不是展示视频加速指引
    hasShowAddSpeedTips = BoolKV.hasShowAddSpeedTips.get() ?? true;
    if (!hasShowAddSpeedTips) {
      Future.delayed(const Duration(seconds: 3), () {
        setHasShowAddSpeedTips();
      });
    }
  }

  Future getVideo() async {
    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl ?? '',
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 10 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
        key: videoUrl ?? '$topicNo',
      ),
    );

    betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          placeholder: Container(),
          // aspectRatio: ,
          aspectRatio: 1 / 16,
          autoPlay: true,
          looping: true,
          expandToFill: true,
          // autoDetectFullscreenAspectRatio: true,
          fit: BoxFit.fitWidth,
          controlsConfiguration: const BetterPlayerControlsConfiguration(
            showControls: false,
            enablePlayPause: false,
            enableFullscreen: false,
            enableMute: false,
            enableProgressText: true,
            enableProgressBar: false,
            enableProgressBarDrag: true,
            enableSkips: false,
            enableAudioTracks: false,
            showControlsOnInitialize: false,
            enableOverflowMenu: false,
            enablePlaybackSpeed: false,
            enableSubtitles: false,
            enableQualities: false,
            enablePip: false,
            enableRetry: false,
          ),
        ),
        betterPlayerDataSource:
            videoUrl == null ? null : betterPlayerDataSource);
    betterPlayerController.addEventsListener(betterPlayerEventListener);
    if (videoUrl != null) {
      await betterPlayerController.preCache(betterPlayerDataSource);
    }
    var progressKeyNum = int.parse(progressWidgetKey.split('_').last) + 1;
    progressWidgetKey = 'progress_' + '$progressKeyNum';
    update();
  }

  getsocialsocialpostpublicsfindOne() async {
    var res = await topicdetail('$topicNo');
    if (res != null) {
      infoData = res;

      if (infoData?.memberId == UserGetx.to.user?.info?.id) {
        isMe = true;
      }
      if (videoUrl == null) {
        videoUrl = res.videoList[0]?.fileUrl;
        if (betterPlayerController.controlsEnabled) {
          betterPlayerDataSource = betterPlayerDataSource.copyWith(
              url: videoUrl,
              cacheConfiguration: BetterPlayerCacheConfiguration(
                useCache: true,
                preCacheSize: 10 * 1024 * 1024,
                maxCacheSize: 10 * 1024 * 1024,
                maxCacheFileSize: 10 * 1024 * 1024,
                key: videoUrl ?? '$topicNo',
              ));
          betterPlayerController.setupDataSource(betterPlayerDataSource);
          betterPlayerController.play();
          betterPlayerController.preCache(betterPlayerDataSource);
        }
      }
    }
    update();
  }

//一级评论
  gettopiccommentpageList() async {
    List<CommunityCommentItem> list;
    if (onelevelPage == 1) {
      list = [];
    } else {
      list = onelevellist;
    }
    CommunityCommentPageListModel? res =
        await commentpageList('$onelevelPage', '10', '$topicNo');
    if (data != null) {
      for (var i = 0; i < res!.data!.length; i++) {
        var items = res.data![i];
        // List<TwoLevelListVoIPageModel> twoList = [];
        // for (var j = 0; j < items.childComments.length; j++) {
        //   twoList.add(
        //       TwoLevelListVoIPageModel.fromJson(items.childComments[j]));
        // }
        // items.childComments = twoList;
        list.add(items);
      }
      onelevellist = list;
      onelevellistTotal = res.total;
      onelevelTotalPage = res.totalPage;
      update();
    }
  }

  //回复评论
  commentreply(CommunityCommentItem? data, CommunityCommentReplyEnum level,
      int firstIndex, int? secondIndex) async {
    if (replyController.text.isEmpty) {
      return;
    }

    if (level == CommunityCommentReplyEnum.post) {
      CommunityCommentItem? res =
          await commentReplyPost(infoData?.topicNo, replyController.text);
      if (res != null) {
        res.shouldFlash = true;
        onelevellist.insert(0, res);
        infoData?.commentNum = (infoData?.commentNum ?? 0) + 1;
        Future.delayed(const Duration(seconds: 1), () {
          res.shouldFlash = false;
          update();
        });
        keyToScroll(newCommentKey);
        replyController.text = '';

        update();
      }
    } else {
      CommunityCommentItem? res = await commentReplyComment(
          infoData?.topicNo, data?.commentNo, replyController.text);
      if (res != null) {
        if (level == CommunityCommentReplyEnum.firstLevel) {
          if (onelevellist[firstIndex].childComments == null) {
            onelevellist[firstIndex].childComments =
                CommunityCommentPageListModel(
              data: [],
              total: 0,
              totalPage: 0,
              pageSize: 0,
              currentPage: 0,
            );
          }
          onelevellist[firstIndex].childComments?.data?.insert(0, res);

          update();
          Future.delayed(const Duration(milliseconds: 100), () {
            var key = subCommentKeys['$firstIndex-0']; // 获取二级评论的 GlobalKey
            keyToScroll(key);
            res.shouldFlash = true;
          });
        } else {
          onelevellist[firstIndex]
              .childComments
              ?.data
              ?.insert(secondIndex! + 1, res);
          update();

          Future.delayed(const Duration(milliseconds: 100), () {
            var key =
                subCommentKeys['$firstIndex-$secondIndex']; // 获取二级评论的 GlobalKey
            keyToScroll(key);
            res.shouldFlash = true;
          });
        }

        infoData?.commentNum = (infoData?.commentNum ?? 0) + 1;
        Future.delayed(const Duration(seconds: 1), () {
          res.shouldFlash = false;
        });

        replyController.text = '';

        update();
      }
    }
    Get.back();
    focus.unfocus();
    Bus.getInstance().emit(EventType.postUpdate, infoData);
    // 点击软键盘的动作按钮时的回调
    // widget.onPressed?.call(val);
  }

  // 通过key滚动到某个位置
  keyToScroll(GlobalKey<State<StatefulWidget>>? key) {
    if (key?.currentContext != null) {
      //评论插到第一条的滚动逻辑
      final RenderBox renderBox =
          key?.currentContext?.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final double commentHeight = renderBox.size.height;
      final double screenHeight = Get.height;

      // 计算希望滚动到的位置（使评论位于屏幕中央）
      final double targetOffset =
          position.dy - screenHeight / 2 + commentHeight / 2;

      // 获取最大滚动范围，并考虑屏幕高度的一半以防止回弹
      final double maxScrollExtent = refreshScrollCtl.position.maxScrollExtent;
      final double safeScrollExtent =
          min(maxScrollExtent, refreshScrollCtl.offset + targetOffset);

      // if (refreshScrollCtl.hasClients) {
      //   refreshScrollCtl.animateTo(
      //     safeScrollExtent > 0 ? safeScrollExtent : 0,
      //     duration: const Duration(milliseconds: 300),
      //     curve: Curves.easeOut,
      //   );
      // }
      // 如果 GlobalKey 关联的 Widget 存在，滚动到该 Widget 位置
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: Duration(milliseconds: 300),
          alignment: 0.5,
        );
      }
    }
  }

  //收藏
  collectTap() async {
    if (Get.find<UserGetx>().goIsLogin()) {
      if (uploadingCollect == true) {
        return;
      }
      uploadingCollect = true;
      try {
        if (infoData?.collectFlag == false) {
          await topiccollectnewOrCancel(infoData?.topicNo);
          infoData?.collectNum += 1;
        } else {
          await topiccollectnewOrCancel(infoData?.topicNo);
          infoData?.collectNum -= 1;
          if (infoData?.collectNum <= 0) {
            infoData?.collectNum = 0;
          }
        }
        infoData?.collectFlag = !infoData?.collectFlag;
        uploadingCollect = false;
        Bus.getInstance().emit(EventType.postUpdate, infoData);
        update();
      } catch (e) {
        uploadingCollect = false;
        UIUtil.showError(LocaleKeys.public13.tr);
      }
    }
  }

  //点赞
  praiseTap() async {
    if (Get.find<UserGetx>().goIsLogin()) {
      if (postLikeIcon?.state?.isBeginAnim == true) {
        return;
      }
      if (infoData?.praiseFlag == false) {
        infoData?.praiseNum += 1;
      } else {
        infoData?.praiseNum -= 1;
      }
      infoData?.praiseFlag = !infoData?.praiseFlag;
      update();
      postLikeIcon!.showLikeAnim(infoData?.praiseFlag);

      var res = await topicpraisenewOrCancel(infoData?.topicNo);
      if (res != true) {
        if (infoData?.praiseFlag == false) {
          infoData?.praiseNum += 1;
        } else {
          infoData?.praiseNum -= 1;
        }
        infoData?.praiseFlag = !infoData?.praiseFlag;
        update();
        postLikeIcon!.showLikeAnim(infoData?.praiseFlag);
      }
      Bus.getInstance().emit(EventType.postUpdate, infoData);
    }
  }

  void setHasShowAddSpeedTips() {
    if (!hasShowAddSpeedTips) {
      hasShowAddSpeedTips = true;
      BoolKV.hasShowAddSpeedTips.set(true);
      update();
    }
  }

  /// 视频播放器事件监听
  void betterPlayerEventListener(BetterPlayerEvent event) {
    if (betterPlayerController.betterPlayerDataSource?.url != null) {
      bool? isBuffering = betterPlayerController.isBuffering();
      if (isBuffering == true) {
        videoLoadingWidget!.showVideoLoading();
      } else {
        videoLoadingWidget!.dismissVideoLoading();
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    betterPlayerController.stopPreCache(betterPlayerDataSource);
    betterPlayerController.removeEventsListener(betterPlayerEventListener);
    betterPlayerController.dispose();
    videoLoadingWidget = null;
    routeObserver.unsubscribe(this);
    super.onClose();
  }
}
