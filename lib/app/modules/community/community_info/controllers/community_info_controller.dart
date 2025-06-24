import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'dart:async';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/community/community_info/views/comment_list/controller.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/community_comment_widget/index.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_like_icon.dart';
import 'package:nt_app_flutter/app/widgets/components/community/text/my_special_text_span_builder.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../widgets/components/community/post_more_bottom_dialog.dart';

class CommunityInfoController extends GetxController
    with GetTickerProviderStateMixin {
  dynamic topicNo;
  TopicdetailModel? data;
  RxBool focusObs = true.obs;

  /// 来自消息跳转id
  String? infoIdFull;

  final MySpecialTextSpanBuilder mySpecialTextSpanBuilder =
      MySpecialTextSpanBuilder();
  TextEditingController replyController = TextEditingController()..text = '';
  RxDouble boxHeight = 38.0.h.obs;
  final RefreshController refreshController = RefreshController();
  final ScrollController refreshScrollCtl = ScrollController();
  final GlobalKey topCommentKey = GlobalKey();
  late PageController pageController;
  late TabController tabController;
  //一级评论列表
  List<CommunityCommentItem> onelevellist = [];
  late TabController commentTab;

  int onelevelPage = 1;
  int onelevelTotalPage = 1;
  int onelevellistTotal = 0;
  int swiperIndex = 0;
  TextEditingController plControll = TextEditingController();
  TopicdetailModel? infoData;
  Rx<TopicdetailModel?> temp = Rx<TopicdetailModel?>(null);
  final FocusNode focus = FocusNode();
  List<TopicdetailModel> textFieldList = [];
  RxInt tabIndex = 0.obs;
  List<String> childTags = [];
  bool isMe = false;
  String targetDescription = '';
  String targetName = '';
  int translateType = 0;
  SocialsocialpostpublicsfindOneTranslateModel? translateData;
  bool isPageLoading = true;

  bool condition = false;

  bool uploadingCollect = false; // 是否正在提交收藏数据

  GlobalKey imageStackKey = GlobalKey();
  Size? imgStackContainerSize;
  Offset? imgStackContainerOffset;

  PostLikeIcon? postLikeIcon;
  final GlobalKey newCommentKey = GlobalKey();
  var paddingBottom;
  Map<String, GlobalKey> subCommentKeys = {}; // 二级评论的 GlobalKeys

  @override
  void onInit() {
    topicNo = Get.arguments?['topicNo'] ?? Get.parameters['topicNo'] ?? '';
    print(topicNo);
    data = Get.arguments?['data'] ?? TopicdetailModel();
    super.onInit();
    data?.topicNo = topicNo;
    tabController = TabController(length: 3, vsync: this);
    pageController = PageController();
    childTags = [
      '${DateTime.now().microsecond}hot',
      '${DateTime.now().microsecond}new'
    ];
    commentTab = TabController(
        length: 2, vsync: this, animationDuration: Duration(seconds: 0));

    commentTab.addListener(() {
      if (!commentTab.indexIsChanging) {
      //.login(user);
        tabIndex.value = commentTab.index;
        Get.find<TopicCommentListViewController>(tag: childTags[tabIndex.value]).refreshData(false);
      }
    });
    replyController.addListener(_updateHeight);
    getData();
  }

  void _updateHeight() {
    boxHeight.value = replyController.text.isEmpty ? 38.0.h : 76.0.h;
  }

  getData() async {
    Future.wait([
      gettopicdetail(),
      gettopiccommentpageList(),
    ]);
    update();
  }

  Future<void> gettopicdetail() async {
    var res = await topicdetail('$topicNo');
    if (res != null) {
      infoData = res;

      focusObs.value = infoData?.focusOn ?? false;
      if (infoData?.memberId == UserGetx.to.user?.info?.id) {
        isMe = true;
      }

      Bus.getInstance().emit(EventType.postUpdate, infoData);
      update();
    }
  }

  //一级评论列表
  Future<void> gettopiccommentpageList() async {
    List<CommunityCommentItem> list;
    if (onelevelPage == 1) {
      list = [];
    } else {
      list = onelevellist;
    }
    var res;
    if (commentTab.index == 0) {
      res = await commentHotPageList('$onelevelPage', '10', '$topicNo');
    } else {
      res = await commentpageList('$onelevelPage', '10', '$topicNo');
    }
    if (res != null && res.data != null) {
      for (var i = 0; i < res.data!.length; i++) {
        var items = res.data![i];
        list.add(items);
      }
      onelevellist = list;
      onelevellistTotal = res.total;
      onelevelTotalPage = res.totalPage;
      isPageLoading = false;
      update();
    }
  }

  /// 根据infoIdFull 获取一级评论ID
  String? getNotifOneLeveCommentId() {
    if (infoIdFull == null) {
      return null;
    } else {
      return infoIdFull!.split('-').first;
    }
  }

  //回复评论
  commentreply(CommunityCommentItem? data, CommunityCommentReplyEnum level,
      int firstIndex, int? secondIndex) async {
    if (replyController.text.isEmpty) {
      return;
    }

    TopicCommentListViewController controller =
        Get.find<TopicCommentListViewController>(
            tag: childTags[commentTab.index]); //.login(user);

    if (level == CommunityCommentReplyEnum.post) {
      CommunityCommentItem? res =
          await commentReplyPost(infoData?.topicNo, replyController.text);
      if (res != null) {
        res.shouldFlash = true;
        bool empty = false;

        if (controller.dataList.isEmpty) {
          empty = true; //
          controller.dataList.add(res);
        } else {
          controller.dataList.insert(0, res);
        }

        infoData?.commentNum = (infoData?.commentNum ?? 0) + 1;
        onelevellistTotal += 1;
        Future.delayed(const Duration(seconds: 1), () {
          res.shouldFlash = false;
          controller.update();
        });
        keyToScroll(newCommentKey);
        replyController.text = '';

        if (empty) {
          controller.refreshData(false);
        } else {
          controller.update();
        }
        update();
      }
    } else {
      CommunityCommentItem? res = await commentReplyComment(
          infoData?.topicNo, data?.commentNo, replyController.text);
      if (res != null) {
        if (level == CommunityCommentReplyEnum.firstLevel) {
          if (controller.dataList[firstIndex].childComments == null) {
            controller.dataList[firstIndex].childComments =
                CommunityCommentPageListModel(
              data: [],
              total: 0,
              totalPage: 0,
              pageSize: 0,
              currentPage: 0,
            );
          }
          controller.dataList[firstIndex].childComments?.data?.insert(0, res);

          controller.update();
          Future.delayed(const Duration(milliseconds: 100), () {
            var key = subCommentKeys['$firstIndex-0']; // 获取二级评论的 GlobalKey
            keyToScroll(key);
            res.shouldFlash = true;
          });
        } else {
          controller.dataList[firstIndex].childComments?.data
              ?.insert(secondIndex! + 1, res);
          controller.update();

          Future.delayed(const Duration(milliseconds: 100), () {
            var key =
                subCommentKeys['$firstIndex-$secondIndex']; // 获取二级评论的 GlobalKey
            keyToScroll(key);
            res.shouldFlash = true;
          });
        }

        infoData?.commentNum = (infoData?.commentNum ?? 0) + 1;
        onelevellistTotal += 1;
        Future.delayed(const Duration(seconds: 1), () {
          res.shouldFlash = false;
        });

        replyController.text = '';

        controller.update();
        ;
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
    // 收藏
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

  //分享
  shareTap() {
    // if (infoData != null) {
    postShareBottomDialog(
        uid: infoData?.memberId,
        userName: '${infoData?.memberName ?? '--'}',
        postData: infoData,
        blockSuccessFun: () {
          Get.back();
        });
    // }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    replyController.removeListener(_updateHeight);
    pageController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
