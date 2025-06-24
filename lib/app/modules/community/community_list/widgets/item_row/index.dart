import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/file_upload.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/translate.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/translate_widget.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/post_quote_widget.dart';
import 'package:nt_app_flutter/app/modules/community/widget/follow_widget.dart';
import 'package:nt_app_flutter/app/modules/community/widget/more_dialog.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/community/community_info_public.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_list_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';

import '../../../../../enums/community.dart';
import '../../../../../utils/utilities/community_util.dart';
import '../../../../../utils/utilities/woker_util.dart';
import '../../../enum.dart';
import '../../../post_index/widgets/coin_market_widget.dart';
import 'bottom_action.dart';
import 'community_polling.dart';
import 'controller.dart';
import 'more_widget.dart';

class CommunityItemRow extends StatefulWidget {
  final TopicdetailModel item;
  final Function? callback;
  final Function(MoreActionType, TopicdetailModel item)? onRefresh;
  final Function? onDelete;

  const CommunityItemRow(
      {super.key,
      required this.item,
      this.callback,
      this.onRefresh,
      this.onDelete});

  @override
  State<CommunityItemRow> createState() => _CommunityItemRowState();
}

class _CommunityItemRowState extends State<CommunityItemRow> {
  late CommunityItemRowController controller;
  late bool focusOn;

  Rx<LanguageTranslateModel?> translateContent =
      Rx<LanguageTranslateModel?>(null);

  @override
  void initState() {
    controller =
        Get.put(CommunityItemRowController(), tag: '${widget.item.id}');
    focusOn = widget.item.focusOn ?? false;

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CommunityItemRowController>(tag: '${widget.item.id}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityItemRowController>(
        tag: '${widget.item.id}',
        builder: (controller) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              await MyCommunityUtil.jumpToTopicDetail(widget.item);
            },
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        16.verticalSpaceFromWidth,
                        buildAvatar(),
                        12.verticalSpaceFromWidth,
                        buildInfo(widget.item),
                        upDownWidget(widget.item),
                        buildMedia(widget.item),
                        CommunityPolling(
                          model: widget.item,
                          callback: () => widget.onRefresh
                              ?.call(MoreActionType.refresh, widget.item),
                        ),
                        Visibility(
                            visible:
                                ObjectUtil.isNotEmpty(widget.item.quoteTopicId),
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.w),
                              child: PostQuoteWidget(
                                  quoteId: widget.item.quoteTopicId),
                            )),
                        topicWidget(),
                        12.verticalSpaceFromWidth,
                        SizedBox(
                            height: 36.w,
                            child: BottomAction(item: widget.item)),
                        commentWidget(widget.item),
                        16.verticalSpaceFromWidth,
                      ],
                    )),
                Container(height: 0.5.w, color: AppColor.colorBorderGutter)
              ],
            ),
          );
        });
  }

  Widget upDownWidget(model) {
    return Visibility(
        visible: model.symbolList != null,
        child: model.symbolList != null
            ? Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 8.w),
                child: Wrap(
                    children: worker<Widget>(model.symbolList, (index, item) {
                  ContractInfo? info = getContract(model, index);
                  if (ObjectUtil.isNotEmpty(info)) {
                    return Container(
                      margin: EdgeInsets.only(
                          right: info != model.symbolList?.last ? 6.w : 0),
                      child: CoinMarketWidget(
                        contractInfo: info!,
                      ),
                    );
                  }
                  return const SizedBox();
                })),
              )
            : const SizedBox());
  }

  @override
  void didUpdateWidget(covariant CommunityItemRow oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (focusOn != widget.item.focusOn) {
      focusOn = widget.item.focusOn!;
      setState(() {});
    }
  }

  Widget buildInfo(TopicdetailModel item) {
    return Visibility(
      visible: (item.topicTitle ?? '').isNotEmpty ||
          (item.topicContent ?? '').isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: (item.topicTitle ?? '').isNotEmpty,
            child: Obx(() => Text(
                  '${translateContent.value?.translateTitle ?? item.topicTitle ?? ''}'
                      .stringSplit(),
                  style: AppTextStyle.f_16_600.colorTextPrimary,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.verticalSpaceFromWidth,
              Obx(() => Container(
                    alignment: Alignment.centerLeft,
                    child: MyCommunityUtil.specialStringtToWidget(
                        ObjectUtil.isNotEmpty(
                                translateContent.value?.translateContent)
                            ? MyCommunityUtil.specialStringtToCommonString(
                                translateContent.value!.translateContent!)
                            : item.topicContent,
                        SpecialContentEnum.postContent,
                        textStyle: AppTextStyle.f_15_400,
                        specialTextStyle: AppTextStyle.f_15_400.tradingYel),
                  )),
              Visibility(
                  visible: widget.item.isTranslate == true,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.w),
                    child: ComTopicTranslateWidget(
                        model: widget.item,
                        ontap: (showTranslate, content) {
                          if (showTranslate) {
                            translateContent.value = content;
                          } else {
                            translateContent.value = null;
                          }
                        }),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMedia(TopicdetailModel item) {
    return AbsorbPointer(
      absorbing: true, // 设置为 true 来阻止子级接收点击事件
      child: (item.picList != null && item.picList!.isNotEmpty) ||
              (item.videoList != null && item.videoList!.isNotEmpty)
          ? Column(
              children: [
                SizedBox(
                  height: 12.w,
                ),
                postImageWidget(
                    context,
                    item.type,
                    item.type == CommunityFileTypeEnum.VIDEO
                        ? item.videoList
                        : item.picList,
                    coverInfo: item.coverInfo)
              ],
            )
          : const SizedBox(),
    );
  }

  Widget buildAvatar() {
    return InkWell(
      onTap: () {
        MyCommunityUtil.pushToUserInfo(widget.item.memberId);
      },
      child: Row(
        children: [
          UserAvatar(
            '${widget.item.memberHeadUrl ?? ''}',
            width: 36.w,
            height: 36.w,
            levelType: widget.item.levelType,
            tradeIconSize: 14.w,
            borderRadius: BorderRadius.circular(6.w),
          ),
          8.horizontalSpace,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 120.w),
                    child: Text(
                        '${widget.item.memberName ?? '--'}'.stringSplit(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.f_14_500.colorTextPrimary),
                  ),
                  8.horizontalSpace,
                  if (!ObjectUtil.isEmptyString(widget.item.flagIcon))
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1.w),
                      child: MyImage(
                        widget.item.flagIcon ?? '',
                        width: 16.w,
                        height: 12.w,
                      ),
                    ),
                  if (!ObjectUtil.isEmptyString(widget.item.organizationIcon))
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.item.organizationIcon!
                            .split(',')
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1.w),
                                  child: MyImage(
                                    e,
                                    width: 12.w,
                                    height: 12.w,
                                  ),
                                ),
                              ),
                            )
                            .toList()),
                ],
              ),
              Row(
                children: [
                  Text(
                      widget.item.topicDateTime != null
                          ? widget.item.displayTime
                          : '',
                      style: AppTextStyle.f_11_400.colorTextTips),
                  6.horizontalSpace,
                  if (ObjectUtil.isNotEmpty(widget.item.trendDirection))
                    Container(
                      constraints: BoxConstraints(minWidth: 28.w),
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 16.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (widget.item.isUp
                                ? AppColor.colorFunctionBuy
                                : AppColor.colorFunctionSell)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: Text(
                          widget.item.isUp
                              ? TrendDirection.up.title()
                              : TrendDirection.down.title(),
                          style: widget.item.isUp
                              ? AppTextStyle.f_10_500.colorFunctionBuy
                              : AppTextStyle.f_10_500.colorFunctionSell),
                    )
                ],
              )
            ],
          )),

          /// 关注
          Row(
            children: [
              Visibility(
                visible: widget.item.memberId != UserGetx.to.uid && !focusOn,
                child: FollowWidget(
                    isFollow: focusOn,
                    onTap: () async {
                      if (Get.find<UserGetx>().goIsLogin()) {
                        if (await socialsocialfollowfollow(widget.item)) {
                          setState(() {
                            focusOn = !focusOn;
                          });
                          widget.item.focusOn = focusOn;
                        }
                      }
                      widget.onRefresh?.call(MoreActionType.like, widget.item);
                    }),
              ),
              8.horizontalSpace,
              CommunityMoreWidget(
                  size: 24.w,
                  color: AppColor.colorTextTips,
                  topFlag: widget.item.topFlag,
                  model: widget.item,
                  callback: (action) {
                    controller.performAction(action, widget.item, () {
                      widget.onRefresh?.call(action, widget.item);
                    });
                  })
            ],
          )
        ],
      ),
    );
  }

  topicWidget() {
    RegExp topicRegex = RegExp(r'#(\S{1,64})\s');
    List<RegExpMatch> topicMatches =
        topicRegex.allMatches(widget.item.topicContent ?? '').toList();
    if (topicMatches.isEmpty) return const SizedBox();
    return Container(
      padding: EdgeInsets.only(top: 12.w),
      child: SizedBox(
        height: 24.w,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: worker<Widget>(topicMatches, (index, item) {
            String topic = item.group(0);
            return GestureDetector(
              onTap: () {
                RouteUtil.goTo(Routes.HOT_DETAIL_TOPIC,
                    parameters: {'data': topic});
              },
              child: UnconstrainedBox(
                child: Container(
                  margin: EdgeInsets.only(right: 6.w),
                  alignment: Alignment.center,
                  height: 24.w,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.w),
                    border: Border.all(
                      width: 1.w,
                      color: AppColor.colorBorderGutter,
                    ),
                  ),
                  child: Row(
                    children: [
                      MyImage(
                        'community/hot_topic'.svgAssets(),
                        width: 16.w,
                        height: 16.w,
                      ),
                      4.horizontalSpace,
                      Text(
                        processString(topic),
                        maxLines: 1,
                        style: AppTextStyle.f_12_400.colorTextSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  String processString(String input) {
    // 判断字符串是否以#开头
    if (input.startsWith('#')) {
      // 删除#
      input = input.substring(1);
    }

    // 如果长度超过30，进行截取并加上...
    if (input.length > 30) {
      return '${input.substring(0, 30)}...';
    }

    return input;
  }

  commentWidget(TopicdetailModel item) {
    if (item.scTopicCommentVoList?.isEmpty ?? true) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.verticalSpaceFromWidth,
        Container(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${item.scTopicCommentVoList?.first.memberName}：',
                  style: AppTextStyle.f_12_400.colorTextSecondary,
                ),
                TextSpan(
                  text: '${item.scTopicCommentVoList?.first.commentContent}',
                  style: AppTextStyle.f_12_400.colorTextDescription,
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
