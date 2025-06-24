import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/widget/more_dialog.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'community_list/widgets/community_comment_widget/index.dart';

// ignore: must_be_immutable
class MyCommentWidget extends StatefulWidget {
  Function(List<CommunityCommentItem> onelevellist, int onlevetotal)
      onUpdateOneLevelList;
  final String topicNo;
  final TopicdetailModel model;

  MyCommentWidget(
      {super.key,
      required this.topicNo,
      required this.model,
      required this.onUpdateOneLevelList});
  @override
  State<StatefulWidget> createState() {
    return MyCommentWidgetState();
  }
}

class MyCommentWidgetState extends State<MyCommentWidget>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final RefreshController _refreshController = RefreshController();
  final ScrollController refreshScrollCtl = ScrollController();
  late PageController pageController;
  ScrollController scrollController = ScrollController();
  List<CommunityCommentItem> onelevellist = [];
  int onelevelPage = 1;
  int onelevelTotalPage = 1;
  int onelevelTotal = 0;

  TextEditingController plControll = TextEditingController();
  final FocusNode _focus = FocusNode();
  TextEditingController replyController = TextEditingController()..text = '';

  Map<String, GlobalKey> subCommentKeys = {}; // 二级评论的 GlobalKeys

  @override
  void initState() {
    pageController = PageController();
    gettopiccommentpageList();
    // TODO: implement initState
    super.initState();
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
        await commentHotPageList('$onelevelPage', '10', widget.topicNo);
    if (res != null) {
      for (var i = 0; i < res.data!.length; i++) {
        var items = res.data![i];
        // await gettopiccommentpageListTwoLevel(items);
        // List<TwoLevelListVoIPageModel> twoList = [];
        // for (var j = 0; j < items.childComments.length; j++) {
        //   twoList.add(
        //       TwoLevelListVoIPageModel.fromJson(items.childComments[j]));
        // }
        // items.childComments = twoList;
        list.add(items);
      }
      onelevellist = list;
      onelevelTotalPage = res.totalPage;
      onelevelTotal = widget.model.commentNum; // res.total;
      // calcCommentCount();
      print("----${widget.model.commentNum}");
      if (mounted) setState(() {});
    }
  }

  commentreply(CommunityCommentItem? data, CommunityCommentReplyEnum level,
      int firstIndex, int? secondIndex) async {
    if (replyController.text.isEmpty) {
      return;
    }

    if (level == CommunityCommentReplyEnum.post) {
      var res = await commentReplyPost(widget.topicNo, replyController.text);
      if (res != null) {
        onelevellist.insert(0, res);
        onelevelTotal = onelevelTotal + 1;
        widget.onUpdateOneLevelList(onelevellist, onelevelTotal);
        _refreshController.position?.animateTo(0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutQuart);
        replyController.text = '';

        setState(() {});
      }
    } else {
      print('onSubmitTap1,level=${data?.levelType}');
      CommunityCommentItem? res = await commentReplyComment(
          data?.topicNo, data?.commentNo, replyController.text);
      if (res != null) {
        res.shouldFlash = true;
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

          setState(() {});
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
          setState(() {});
          Future.delayed(const Duration(milliseconds: 100), () {
            var key =
                subCommentKeys['$firstIndex-$secondIndex']; // 获取二级评论的 GlobalKey
            keyToScroll(key);
            res.shouldFlash = true;
          });
        }

        onelevelTotal = onelevelTotal + 1;
        widget.onUpdateOneLevelList(onelevellist, onelevelTotal);
        replyController.text = '';
        _refreshController.position?.animateTo(0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutQuart);
        setState(() {});
      }
    }

    Get.back();
    _focus.unfocus();
    // 点击软键盘的动作按钮时的回调
    // widget.onPressed?.call(val);
  }

  // 通过key滚动到某个位置
  keyToScroll(GlobalKey<State<StatefulWidget>>? key) {
    // 如果 GlobalKey 关联的 Widget 存在，滚动到该 Widget 位置
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: Duration(milliseconds: 300),
        alignment: 0.5,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  // MallIndexLogic _mallIndexLogic = Get.put(MallIndexLogic());
  void calcCommentCount({bool isAdd = false}) {
    //计算当前评论数
    int cur = 0;
    onelevellist.forEach((element) {
      ++cur;
      element.childComments?.data?.forEach((element) {
        ++cur;
      });
    });

    setState(() {
      onelevelTotal = cur;
      widget.model.commentNum = onelevelTotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200.w,
      clipBehavior: Clip.none,
      child: DefaultTextStyle(
          style: TextStyle(color: AppColor.color111111, fontSize: 10.sp),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(LocaleKeys.community2.trArgs(['$onelevelTotal']),
                      style: AppTextStyle.f_16_500),
                ],
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SmartRefresher(
                        controller: _refreshController,
                        scrollController: refreshScrollCtl,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: () async {
                          onelevelPage = 1;
                          await gettopiccommentpageList();
                          _refreshController.refreshToIdle();
                          _refreshController.loadComplete();
                        },
                        onLoading: () async {
                          if (onelevelTotalPage <= onelevelPage) {
                            _refreshController.loadNoData();
                          } else {
                            onelevelPage = onelevelPage + 1;
                            await gettopiccommentpageList();
                            _refreshController.loadComplete();
                          }
                        },
                        child: CustomScrollView(slivers: [
                          onelevellist.isEmpty
                              ? SliverToBoxAdapter(
                                  child: Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80.w,
                                      ),
                                      noDataWidget(
                                        context,
                                        wigetHeight: 300.w,
                                      )
                                    ],
                                  ),
                                ))
                              : SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      var item = onelevellist[index];
                                      return CommunityCommentWidget(
                                        item: item,
                                        firstLevelIndex: index,
                                        subCommentKeys: subCommentKeys,
                                        onLongPress: (int? secondIndex,
                                            CommunityCommentReplyEnum level) {
                                          removePlDialog(context, level, index,
                                              secondIndex);
                                        },
                                        onTap: (int? secondIndex,
                                            CommunityCommentReplyEnum level) {
                                          if (Get.find<UserGetx>()
                                              .goIsLogin()) {
                                            showPLDialog(context, level, index,
                                                secondIndex);
                                          }
                                        },
                                        model: widget.model,
                                        onMoreTap: (action, level, item) {
                                          if (action == MoreActionType.delete) {
                                            setState(() {
                                              if (level ==
                                                  CommunityCommentReplyEnum
                                                      .firstLevel) {
                                                onelevellist.remove(item);
                                              } else {
                                                onelevellist[index]
                                                    .childComments
                                                    ?.data
                                                    ?.remove(item);
                                              }
                                            });
                                            calcCommentCount();
                                          } else {}
                                        },
                                        onRefresh: (MoreActionType action,
                                            CommunityCommentReplyEnum level) {
                                          gettopiccommentpageList();
                                        },
                                      );
                                    },
                                    childCount: onelevellist.length,
                                  ),
                                ),
                        ]))),
              ),
              Container(
                height: 50.w,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: AppColor.colorEEEEEE)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (Get.find<UserGetx>().goIsLogin()) {
                            showPLDialog(
                              context,
                              CommunityCommentReplyEnum.post,
                              0,
                              0,
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          height: 38.h,
                          decoration: BoxDecoration(
                              color: AppColor.colorF5F5F5,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            LocaleKeys.community7.tr,
                            style: AppTextStyle.f_14_400.colorABABAB,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

// 显示弹窗
  Future? showMoreDialog() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(
                    0.w, 16.w, 0.w, MediaQuery.of(context).padding.bottom),
                // height: loginType == 4 ? 380.h : 320.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  color: Color(0xffffffff),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        child: Text(
                          LocaleKeys.community8.tr, //'置顶',
                          style: TextStyle(
                              color: AppColor.color111111,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        height: 60.0,
                        alignment: Alignment.center,
                      ),
                      onTap: (() async {}),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                    InkWell(
                      onTap: (() async {}),
                      child: Container(
                        child: Text(
                          LocaleKeys.community9.tr, //'仅自己可见',
                          style: TextStyle(
                              color: AppColor.color111111,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        height: 60.0,
                        alignment: Alignment.center,
                      ),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                    InkWell(
                      onTap: (() async {
                        UIUtil.showConfirm(
                            LocaleKeys.community118.tr, //'删除此动态?',
                            confirmHandler: () {});
                        // showMyDialog(context, '删除此动态?', '', [
                        //   {
                        //     "name": '取消',
                        //   },
                        //   {"name": '确认', "tap": () => {}}
                        // ]);
                      }),
                      child: Container(
                        child: Text(
                          LocaleKeys.community117.tr, //'删除',
                          style: TextStyle(
                              color: AppColor.color111111,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        height: 60.0,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                )),
          );
        });
    return null;
  }

  // 显示弹窗
  removePlDialog(context, CommunityCommentReplyEnum level, int firstIndex,
      int? secondIndex) {
    CommunityCommentItem? item;
    if (level == CommunityCommentReplyEnum.firstLevel) {
      item = onelevellist[firstIndex];
    } else {
      item = onelevellist[firstIndex].childComments?.data?[secondIndex!];
    }
    var isMe = UserGetx.to.uid == item?.memberId;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(
                    0.w, 2.h, 0.w, MediaQuery.of(context).padding.bottom),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.r)),
                  color: AppColor.colorWhite,
                ),
                child: Column(
                  children: <Widget>[
                    isMe
                        ? Column(
                            children: [
                              InkWell(
                                onTap: (() async {
                                  bool res = await socialsocialpostcommentdel(
                                      item?.id);
                                  if (res == true) {
                                    if (level ==
                                        CommunityCommentReplyEnum.firstLevel) {
                                      onelevellist.removeAt(firstIndex);
                                      onelevelTotal = onelevelTotal - 1;
                                      widget.onUpdateOneLevelList(
                                          onelevellist, onelevelTotal);
                                    } else {
                                      onelevellist[firstIndex]
                                          .childComments
                                          ?.data
                                          ?.removeAt(secondIndex!);
                                    }
                                    Get.back();
                                    setState(() {});
                                  }
                                }),
                                child: Container(
                                  height: 48.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocaleKeys.community3.tr,
                                    style: AppTextStyle.f_16_500,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: AppColor.colorEEEEEE,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              InkWell(
                                onTap: (() async {
                                  if (Get.find<UserGetx>().goIsLogin()) {
                                    // Get.back();
                                    showPLDialog(
                                      context,
                                      level,
                                      firstIndex,
                                      secondIndex,
                                    );
                                  }
                                }),
                                child: Container(
                                  height: 48.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocaleKeys.community4.tr,
                                    style: AppTextStyle.f_16_500,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 1.0,
                              ),
                              InkWell(
                                onTap: (() async {
                                  CopyUtil.copyText(MyCommunityUtil
                                      .specialStringtToCommonString(
                                    item?.commentContent ?? '',
                                  ));
                                  Get.back();
                                }),
                                child: Container(
                                  height: 48.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocaleKeys.public6.tr,
                                    style: AppTextStyle.f_16_500,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: AppColor.colorEEEEEE,
                              ),
                            ],
                          ),
                    InkWell(
                      onTap: (() async {
                        Get.back();
                      }),
                      child: Container(
                        height: 48.h,
                        alignment: Alignment.center,
                        child: Text(
                          LocaleKeys.public2.tr,
                          style: AppTextStyle.f_16_600.color999999,
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  showPLDialog(context, CommunityCommentReplyEnum level, int firstIndex,
      int? secondIndex) {
    CommunityCommentItem? data;
    if (level == CommunityCommentReplyEnum.firstLevel) {
      data = onelevellist[firstIndex];
    } else if (level == CommunityCommentReplyEnum.secondLevel) {
      data = onelevellist[firstIndex].childComments?.data?[secondIndex!];
    }
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom +
                  MediaQuery.of(context).viewInsets.bottom,
            ),
            child: GestureDetector(onTap: () {
              // 触摸收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            }, child: StatefulBuilder(builder: (context1, state) {
              return Container(
                  padding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(
                            color: AppColor.colorF5F5F5,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: TextField(
                            obscuringCharacter: '1',
                            autofocus: true,
                            onChanged: (text) {
                              state(() {});
                            },
                            textInputAction: TextInputAction.send,
                            focusNode: _focus,
                            controller: replyController,
                            textAlignVertical: TextAlignVertical.center,
                            style: AppTextStyle.f_14_500.color111111,
                            cursorColor: AppColor.color111111,
                            decoration: InputDecoration(
                              hintText: level == CommunityCommentReplyEnum.post
                                  ? LocaleKeys.community1.tr
                                  : LocaleKeys.community5
                                      .trArgs([' ${data?.memberName ?? ''}']),
                              hintStyle: AppTextStyle.f_14_400.colorABABAB
                                  .copyWith(height: 1),
                            ),
                            onSubmitted: (String val) async {
                              commentreply(
                                  data, level, firstIndex, secondIndex);
                            },
                          ),

                          // obscuringCharacter: '1',
                          // autofocus: true,
                          // onChanged: (text) {
                          //   state(() {});
                          // },
                          // textInputAction: TextInputAction.send,
                          // focusNode: _focus,

                          // specialTextSpanBuilder: _mySpecialTextSpanBuilder,
                          // controller: controller,
                          // textAlignVertical: TextAlignVertical.center,
                          // style: AppTextStyle.medium_500,
                          // decoration: InputDecoration(
                          //   enabledBorder: const OutlineInputBorder(
                          //     borderSide: BorderSide.none,
                          //   ),
                          //   focusedBorder: const OutlineInputBorder(
                          //     borderSide: BorderSide.none,
                          //   ),
                          //   // errorText: '${errorText ?? null}',
                          //   hintText: '123123123',
                          //   hintStyle: AppTextStyle.medium_400.colorABABAB,
                          // ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      MyButton(
                        text: LocaleKeys.community37.tr,
                        minWidth: 72.w,
                        height: 38.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        textStyle: AppTextStyle.f_15_500,
                        onTap: () {
                          commentreply(data, level, firstIndex, secondIndex);
                        },
                      )
                    ],
                  ));
            })),
          ));
        });
    return null;
  }
}
