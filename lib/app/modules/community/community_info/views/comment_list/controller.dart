import 'package:dio/dio.dart' as dio;
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/community_comment_widget/index.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/copy_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../widgets/components/community/text/my_special_text_span_builder.dart';
import '../../../community_info/controllers/community_info_controller.dart';

class TopicCommentListViewController
    extends GetListController<CommunityCommentItem> {
  final String tag;
  final String topicNo;
  TopicCommentListViewController(this.tag, this.topicNo);
  final Map<String, GlobalKey> subCommentKeys = {};
  TextEditingController replyController = TextEditingController()..text = '';
  final MySpecialTextSpanBuilder mySpecialTextSpanBuilder =
      MySpecialTextSpanBuilder();

  final ScrollController refreshScrollCtl = ScrollController();
  final GlobalKey topCommentKey = GlobalKey();
  final FocusNode focus = FocusNode();
  final GlobalKey newCommentKey = GlobalKey();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    refreshData(false);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  // 显示长按弹窗
  removePlDialog(context, CommunityCommentReplyEnum level, int firstIndex,
      int? secondIndex) {
    CommunityCommentItem? item;
    if (level == CommunityCommentReplyEnum.firstLevel) {
      item = dataList[firstIndex];
    } else {
      item = dataList[firstIndex].childComments?.data?[secondIndex!];
    }
    var isMe = UserGetx.to.uid == item?.memberId;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(0.w, 0.w, 0.w, 30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  color: AppColor.colorWhite,
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        isMe
                            ? InkWell(
                                onTap: (() async {
                                  bool res = await socialsocialpostcommentdel(
                                      item?.id);
                                  if (res == true) {
                                    if (level ==
                                        CommunityCommentReplyEnum.firstLevel) {
                                      dataList.removeAt(firstIndex);
                                      dataList[firstIndex]
                                          .childComments
                                          ?.total -= 1;
                                    } else {
                                      dataList[firstIndex]
                                          .childComments
                                          ?.data
                                          ?.removeAt(secondIndex!);
                                    }
                                    Get.back();
                                    update();
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
                              )
                            : InkWell(
                                onTap: (() async {
                                  if (Get.find<UserGetx>().goIsLogin()) {
                                    Get.back();
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
                          height: 1,
                          color: AppColor.colorEEEEEE,
                        ),
                        InkWell(
                          onTap: (() async {
                            CopyUtil.copyText(
                                MyCommunityUtil.specialStringtToCommonString(
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
      data = dataList[firstIndex];
    } else if (level == CommunityCommentReplyEnum.secondLevel) {
      data = dataList[firstIndex].childComments?.data?[secondIndex!];
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
            child: StatefulBuilder(builder: (context1, state) {
              return Container(
                padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: 38.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                              height: 38.h,
                              decoration: BoxDecoration(
                                color: AppColor.colorF5F5F5,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: ExtendedTextField(
                                scrollPadding: const EdgeInsets.all(0),
                                autofocus: true,
                                onChanged: (text) {
                                  state(() {});
                                },
                                textInputAction: TextInputAction.send,
                                focusNode: focus,
                                onSubmitted: (String val) async {
                                  commentreply(
                                      data, level, firstIndex, secondIndex);
                                },
                                specialTextSpanBuilder:
                                    mySpecialTextSpanBuilder,
                                controller: replyController,
                                style: AppTextStyle.f_14_500,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText:
                                      level == CommunityCommentReplyEnum.post
                                          ? LocaleKeys.community1.tr
                                          : LocaleKeys.community5.trArgs(
                                              [' ${data?.memberName ?? ''}']),
                                  hintStyle: AppTextStyle.f_14_400.colorABABAB
                                      .copyWith(height: 1),
                                ),
                              ),
                            )),
                            10.horizontalSpace,
                            MyButton(
                              text: LocaleKeys.community37.tr,
                              minWidth: 72.w,
                              height: 38.h,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              textStyle: AppTextStyle.f_15_500,
                              onTap: () {
                                commentreply(
                                    data, level, firstIndex, secondIndex);
                              },
                            )
                          ],
                        ))
                  ],
                ),
              );
            }),
          ));
        });
  }

  void calcCommentCount({bool isAdd = false}) {
    //计算当前评论数
    int cur = 0;
    dataList.forEach((element) {
      ++cur;
      element.childComments?.data?.forEach((element) {
        ++cur;
      });
    });
    Get.find<CommunityInfoController>(
            tag: TagCacheUtil().getTag('CommunityInfoController'))
        .infoData
        ?.commentNum = cur; //.login(user);
    Get.find<CommunityInfoController>(
            tag: TagCacheUtil().getTag('CommunityInfoController'))
        .update();
  }

  //回复评论
  commentreply(CommunityCommentItem? data, CommunityCommentReplyEnum level,
      int firstIndex, int? secondIndex) async {
    TopicdetailModel? infoData = Get.find<CommunityInfoController>(
            tag: TagCacheUtil().getTag('CommunityInfoController'))
        .infoData;

    if (replyController.text.isEmpty) {
      return;
    }

    if (level == CommunityCommentReplyEnum.post) {
      CommunityCommentItem? res =
          await commentReplyPost(infoData?.topicNo, replyController.text);
      if (res != null) {
        res.shouldFlash = true;
        dataList.insert(0, res);
        infoData?.commentNum = (infoData.commentNum ?? 0) + 1;
        Future.delayed(const Duration(seconds: 1), () {
          res.shouldFlash = false;
          update();
        });
        keyToScroll(newCommentKey);
        replyController.text = '';
        calcCommentCount();
        update();
      }
    } else {
      CommunityCommentItem? res = await commentReplyComment(
          infoData?.topicNo, data?.commentNo, replyController.text);
      if (res != null) {
        if (level == CommunityCommentReplyEnum.firstLevel) {
          if (dataList[firstIndex].childComments == null) {
            dataList[firstIndex].childComments = CommunityCommentPageListModel(
              data: [],
              total: 0,
              totalPage: 0,
              pageSize: 0,
              currentPage: 0,
            );
          }
          dataList[firstIndex].childComments?.data?.insert(0, res);

          update();
          Future.delayed(const Duration(milliseconds: 100), () {
            var key = subCommentKeys['$firstIndex-0']; // 获取二级评论的 GlobalKey
            keyToScroll(key);
            res.shouldFlash = true;
          });
        } else {
          dataList[firstIndex]
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
        calcCommentCount();
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

      // // 获取最大滚动范围，并考虑屏幕高度的一半以防止回弹
      // final double maxScrollExtent = refreshScrollCtl.position.maxScrollExtent;
      // final double safeScrollExtent =
      //     min(maxScrollExtent, refreshScrollCtl.offset + targetOffset);

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

  @override
  Future<List<CommunityCommentItem>> fetchData() async {
    // TODO: implement fetchData
    List<CommunityCommentItem> list = [];
    try {
      try {
        var res;
        if (tag.contains('hot')) {
          res = await CommunityApi.instance()
              .commentpageHotList('$pageIndex', '$pageSize', topicNo, '');
        } else {
          res = await CommunityApi.instance()
              .commentpageList('$pageIndex', '$pageSize', topicNo, '');
        }

        if (res != null && res.data != null) {
          for (var i = 0; i < res.data!.length; i++) {
            CommunityCommentItem items = res.data![i];
            list.add(items);
          }
        }
        return list;
      } on dio.DioException catch (e) {
        print('topicpageList: e.error===${e.error}');
      }
    } catch (e) {}
    return [];
  }
}
