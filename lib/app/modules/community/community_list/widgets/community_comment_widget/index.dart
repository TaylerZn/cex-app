import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/community_comment_widget/translate_widget.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/more_widget.dart';
import 'package:nt_app_flutter/app/modules/community/widget/more_dialog.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/widgets/styled_text.dart';

import '../../../../../utils/utilities/ui_util.dart';
import '../../../../../widgets/basic/my_image.dart';
import 'comment_action_widget.dart';

enum CommunityCommentReplyEnum { post, firstLevel, secondLevel }

class CommunityCommentWidget extends StatefulWidget {
  final TopicdetailModel? model;
  final int firstLevelIndex; // 一级评论的索引
  final CommunityCommentItem item;

  final Function(MoreActionType action, CommunityCommentReplyEnum level) onRefresh;
  final Function(MoreActionType action, CommunityCommentReplyEnum leveL, CommunityCommentItem item)? onMoreTap;
  final void Function(int? secondIndex, CommunityCommentReplyEnum level)? onLongPress;
  final void Function(int? secondIndex, CommunityCommentReplyEnum level)? onTap;
  // final Map<int, GlobalKey>
  //     keys; // 一级评论的 GlobalKeys（放在里侧，因为要以一级评论为标准，而不是整体CommentItem）
  final Map<String, GlobalKey> subCommentKeys; // 二级评论的 GlobalKeys

  const CommunityCommentWidget({
    super.key,
    required this.model,
    required this.item,
    required this.onRefresh,
    required this.firstLevelIndex,
    this.onLongPress,
    this.onTap,
    this.onMoreTap,
    // required this.keys,
    required this.subCommentKeys,
  });

  @override
  State<CommunityCommentWidget> createState() => _CommunityCommentWidgetState();
}

class _CommunityCommentWidgetState extends State<CommunityCommentWidget> {
  RxBool isLoading = false.obs;
  String? translateContent;
  bool showTranslate = false;
  Map<String, dynamic> translateCache = {};

  @override
  void initState() {
    super.initState();
  }

  getCommentpageListTwoLevel(CommunityCommentItem item) async {
    isLoading.value = true;

    Set<int?> existingCommentIds = item.childComments?.data?.map((comment) => comment.id).toSet() ?? {};

    CommunityCommentPageListModel? res =
        await commentpageListTwoLevel('${item.childComments?.currentPage}', '5', item.topicNo, item.commentNo);

    if (res != null) {
      if (res.data != null) {
        for (var i = 0; i < res.data!.length; i++) {
          var newComment = res.data![i];
          if (!existingCommentIds.contains(newComment.id)) {
            item.childComments?.data?.add(newComment);
            existingCommentIds.add(newComment.id);
          }
        }
      }

      setState(() {
        item.childComments?.currentPage += 1;
        item.childComments?.total = res.total;
      });
    }
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      commentWidget(
        null,
        // widget.keys.putIfAbsent(
        //     widget.firstLevelIndex, () => GlobalKey()), // 为一级评论创建或获取 GlobalKey
        widget.firstLevelIndex, widget.item,
      ),
      widget.item.childComments != null
          ? ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.item.childComments?.data?.length,
              itemBuilder: (context, index) {
                CommunityCommentItem? items = widget.item.childComments?.data?[index];
                return commentWidget(
                    widget.subCommentKeys
                        .putIfAbsent('${widget.firstLevelIndex}-$index', () => GlobalKey()), // 为二级评论创建或获取 GlobalKey

                    index,
                    items!,
                    type: CommunityCommentReplyEnum.secondLevel);
              }).paddingOnly(left: 36.w)
          : Container(),
      buildLeve2CommentLoadMore(widget.item)
    ]);
  }

  commentWidget(Key? key, int index, CommunityCommentItem item,
      {CommunityCommentReplyEnum type = CommunityCommentReplyEnum.firstLevel}) {
    bool isFirstLevel = type == CommunityCommentReplyEnum.firstLevel;
    return InkWell(
      onLongPress: () {
        widget.onLongPress?.call(isFirstLevel ? null : index, type);
      },
      onTap: () {
        widget.onTap?.call(isFirstLevel ? null : index, type);
      },
      child: Container(
        key: key,
        margin: EdgeInsets.only(top: 24.w),
        clipBehavior: Clip.none,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: UserAvatar(
                '${item.memberHeadUrl ?? ''}',
                width: isFirstLevel ? 36.w : 24.w,
                height: isFirstLevel ? 36.w : 24.w,
                tradeIconSize: isFirstLevel ? 14.w : 10.w,
                levelType: item.levelType,
              ),
              onTap: () {
                Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': item.memberId});
              },
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        (item.memberName ?? '').stringSplit(),
                        style: AppTextStyle.f_13_500.colorTextPrimary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CommunityMoreWidget(
                        size: 16.w,
                        color: AppColor.colorTextTips,
                        secondLevel: type == CommunityCommentReplyEnum.secondLevel,
                        topFlag: item.topFlag,
                        model: widget.model,
                        isPost: false,
                        commentId: item.memberId.toString(),
                        callback: (action) async {
                          switch (action) {
                            case MoreActionType.pinTop:
                              {
                                if (await pinComment(item.id)) {
                                  UIUtil.showSuccess(item.topFlag == false
                                      ? LocaleKeys.community89.tr
                                      : LocaleKeys.community90.tr); //'已置顶' : '已取消置顶');
                                  setState(() {
                                    item.topFlag = !(item.topFlag ?? false);
                                  });
                                  widget.onRefresh.call(action, type);
                                }
                              }
                              break;
                            case MoreActionType.delete:
                              {
                                UIUtil.showConfirm(LocaleKeys.community122.tr, confirmHandler: () async {
                                  Get.back();
                                  if (await socialsocialpostcommentdel(item.id)) {
                                    if (type == CommunityCommentReplyEnum.secondLevel) {
                                      setState(() {
                                        widget.item.childComments?.data?.remove(item);
                                      });
                                    }
                                    widget.onRefresh.call(action, type);
                                    widget.onMoreTap?.call(action, type, item);
                                  }
                                });
                              }
                              break;
                            case MoreActionType.block:
                              {
                                blockMember(item.memberName ?? '', item.memberId, blockSuccessFun: () {
                                  widget.onRefresh.call(action, type);
                                });
                              }
                              break;
                            default:
                              break;
                          }
                        })
                  ],
                ),
                6.verticalSpaceFromWidth,
                ObjectUtil.isNotEmpty(cacheTranslateContent(item))
                    ? StyledText(
                        text: (item.commentLevel == 3
                                ? (item.preMemberName != null
                                    ? '${LocaleKeys.community4.tr} <b>${item.preMemberName}：</b>'
                                    : '')
                                : '') +
                            cacheTranslateContent(item),
                        style: AppTextStyle.f_13_400,
                        tags: {'b': StyledTextTag(style: AppTextStyle.f_13_400.colorABABAB)})
                    : StyledText(
                        text: (item.commentLevel == 3
                                ? (item.preMemberName != null
                                    ? '${LocaleKeys.community4.tr} <b>${item.preMemberName}：</b>'
                                    : '')
                                : '') +
                            (item.commentContent ?? '').commentSplit(),
                        style: AppTextStyle.f_13_400,
                        tags: {
                          'b': StyledTextTag(style: AppTextStyle.f_13_400.colorABABAB),
                        },
                      ),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Visibility(
                            visible: item.topFlag ?? false,
                            child: Row(children: [
                              MyImage('community/pin_icon'.svgAssets()),
                              Text(LocaleKeys.community8.tr, style: AppTextStyle.f_10_400.tradingYel),
                              8.horizontalSpace
                            ])),
                        Text(
                            (item.createTime != null
                                    ? RelativeDateFormat.format(MyTimeUtil.timestampToDate(item.createTimeTime ?? 0))
                                    : '')
                                .stringSplit(),
                            style: AppTextStyle.f_10_400.colorTextDisabled),
                        10.horizontalSpace,
                        Visibility(
                            visible: item.isTranslate ?? true,
                            child: ComTranslateWidget(
                                commentItem: item,
                                ontap: (show, content, cur) {
                                  setState(() {
                                    translateCache[cur.commentNo.toString()] = {'showContent': show, 'translate': content};
                                  });
                                }))
                      ],
                    ),
                    buildAction(item, () {
                      widget.onTap?.call(isFirstLevel ? null : index, type);
                    })
                  ],
                )
              ],
            )),

            // DialogCommentItem(item: item)
          ],
        ),
      ),
    );
  }

  String cacheTranslateContent(CommunityCommentItem item) {
    if (ObjectUtil.isEmpty(translateCache[item.commentNo])) {
      return '';
    }
    Map<String, dynamic> temp = translateCache[item.commentNo];
    if (temp['showContent']) {
      return temp['translate'];
    }
    return '';
  }

  Widget buildAction(CommunityCommentItem item, onTap) {
    return CommentActionWidget(item: item, onTap: onTap);
  }

  Widget buildLeve2CommentLoadMore(CommunityCommentItem item) {
    return item.childComments != null && (item.childComments?.totalPage ?? 0) > (item.childComments?.currentPage ?? 0)
        ? Obx(() => isLoading.value
            ? Lottie.asset(
                'assets/json/loading.json',
                repeat: true,
                width: 20.w,
                height: 20.w,
              ).marginOnly(left: 70.w, top: 14.h)
            : InkWell(
                onTap: () {
                  getCommentpageListTwoLevel(item);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70.w, top: 14.h),
                  child: Text(LocaleKeys.community91.tr, //'查看更多',
                      style: AppTextStyle.f_12_400_15.tradingYel),
                ),
              ))
        : Container();
  }

  @override
  void didUpdateWidget(covariant CommunityCommentWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
}
