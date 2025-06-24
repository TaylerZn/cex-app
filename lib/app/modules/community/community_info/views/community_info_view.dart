import 'package:common_utils/common_utils.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/community_info/controllers/community_info_controller.dart';
import 'package:nt_app_flutter/app/modules/community/community_info/views/comment_list/view.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/community_comment_widget/index.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/more_widget.dart';
import 'package:nt_app_flutter/app/modules/community/widget/follow_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/community/community_info_public.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_like_icon.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../widgets/basic/my_tab_underline_widget.dart';
import '../../community_list/widgets/item_row/action.dart';
import '../../widget/more_dialog.dart';

class CommunityInfoView extends GetView<CommunityInfoController> {
  @override
  String? get tag => TagCacheUtil().getTag('CommunityInfoController');

  final TopicdetailModel? model;

  const CommunityInfoView({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityInfoController>(
        tag: tag,
        builder: (controller) {
          return MySystemStateBar(
              child: Scaffold(
            appBar: AppBar(
              leading: const MyPageBackWidget(),
              actions: [
                Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                    child: Row(
                      children: [
                        Visibility(
                            visible: (ObjectUtil.isEmpty(controller.infoData) &&
                                    ObjectUtil.isEmpty(
                                        controller.data?.topicTitle)) ||
                                true,
                            child: CommunityMoreWidget(
                                topFlag: controller.infoData?.topFlag,
                                model: controller.infoData,
                                size: 20.w,
                                color: AppColor.colorTextSecondary,
                                callback: (action) {
                                  topicPerformAction(
                                      action, controller.infoData, () {
                                    if (action == MoreActionType.delete) {
                                      Get.back();
                                    }
                                    controller.update();
                                  });
                                })),
                      ],
                    ))
              ],
              elevation: 0,
            ),
            bottomNavigationBar: controller.infoData != null
                ? Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 0.6,
                                color: AppColor.colorBorderGutter))),
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      6.w,
                      8.w,
                      6.w + Get.mediaQuery.padding.bottom,
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
                              alignment: Alignment.centerLeft,
                              height: 38.w,
                              decoration: BoxDecoration(
                                  color: AppColor.colorBackgroundInput,
                                  borderRadius: BorderRadius.circular(50.r)),
                              child: Text(
                                LocaleKeys.community1.tr,
                                style: AppTextStyle.f_14_400.colorTextDisabled,
                              ),
                            ),
                          ),
                        ),
                        16.horizontalSpace,
                        PostLikeButton(
                          onTap: (stat) {
                            controller.update();
                          },
                          likeIconSize: 20.w,
                          showText: false,
                          item: controller.infoData,
                          likeType: PostLikeType.postLike,
                        ).marginOnly(right: 24.w),
                        Visibility(
                            visible: UserGetx.to.isKol || true,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.COMMUNITY_POST, arguments: {
                                  'quoteId': controller.data?.topicNo
                                });
                              },
                              child: MyImage(
                                'community/quote'.svgAssets(),
                                width: 20.w,
                                height: 20.w,
                                color: AppColor.colorTextDescription,
                              ),
                            ).marginOnly(right: 14.w)),
                        InkWell(
                            onTap: () async {
                              controller.shareTap();
                            },
                            child: SizedBox(
                              width: 36.w,
                              height: 40.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyImage(
                                    'community/share'.svgAssets(),
                                    width: 20.w,
                                    height: 20.w,
                                    color: controller.infoData?.collectFlag
                                        ? null
                                        : AppColor.colorTextDescription,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                : const SizedBox(),
            body: SmartRefresher(
              controller: controller.refreshController,
              scrollController: controller.refreshScrollCtl,
              enablePullDown: true,
              enablePullUp: controller.onelevelTotalPage != 0 ? true : false,
              onRefresh: () async {
                controller.onelevelPage = 1;
                await controller.gettopicdetail();
                await controller.gettopiccommentpageList();
                controller.refreshController.refreshToIdle();
                controller.refreshController.loadComplete();
              },
              onLoading: () async {
                if (controller.onelevelTotalPage <= controller.onelevelPage) {
                  controller.refreshController.loadNoData();
                } else {
                  controller.onelevelPage = controller.onelevelPage + 1;
                  await controller.gettopiccommentpageList();
                  controller.refreshController.loadComplete();
                }
              },
              child: NestedScrollView(
                physics: const ClampingScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          UserAvatar(
                            '${controller.infoData?.memberHeadUrl ?? controller.data?.memberHeadUrl ?? ''}',
                            width: 36.w,
                            height: 36.w,
                            levelType: controller.infoData?.levelType,
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${controller.infoData?.memberName ?? controller.data?.memberName ?? '--'}',
                                        style: AppTextStyle
                                            .f_15_500.colorTextPrimary,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(1.w),
                                      child: MyImage(
                                        controller.infoData?.flagIcon ?? '',
                                        width: 16.w,
                                        height: 12.w,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1.w),
                                        child: MyImage(
                                          controller
                                                  .infoData?.organizationIcon ??
                                              '',
                                          width: 12.w,
                                          height: 12.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${controller.infoData?.displayTime}',
                                  style: AppTextStyle.f_11_400.colorTextTips,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: controller.infoData?.memberId !=
                                      UserGetx.to.uid &&
                                  !controller.focusObs.value,
                              child: Obx(() => FollowWidget(
                                  isFollow: controller.focusObs.value,
                                  onTap: () async {
                                    if (Get.find<UserGetx>().goIsLogin()) {
                                      if (await socialsocialfollowfollow(
                                          controller.infoData)) {
                                        controller.focusObs.value =
                                            controller.infoData?.focusOn ??
                                                false;
                                      }
                                    }
                                  })))
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: (ObjectUtil.isEmpty(controller.infoData) &&
                                ObjectUtil.isEmpty(controller.data?.topicTitle))
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Container(
                                      child: communityInfoPublicWidget(
                                          context,
                                          controller.data,
                                          controller.infoData, callback: () {
                                    controller.gettopicdetail();
                                  })),
                                  Row(
                                    children: [
                                      Text(
                                          key: controller.newCommentKey,
                                          LocaleKeys.community2.trArgs([
                                            '${controller.onelevellistTotal}'
                                          ]),
                                          style: AppTextStyle.f_14_600),
                                      Expanded(
                                          child: Container(
                                              width: double.infinity,
                                              alignment: Alignment.centerRight,
                                              child: buildTab()))
                                    ],
                                  )
                                ],
                              ).marginOnly(top: 16.h)),
                  ];
                },
                body: buildTabView(),
              ).marginSymmetric(horizontal: 16.w),
            ),
          ));
        });
  }

  Widget buildTabView() {
    return TabBarView(
      controller: controller.commentTab,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        KeepAliveWrapper(
            child: CommentListView(controller.childTags[0],
                model: controller.data)),
        KeepAliveWrapper(
            child: CommentListView(
          controller.childTags[1],
          model: controller.infoData,
        )),
      ],
    );
  }

  Widget buildTab() {
    return SizedBox(
        height: 14.w,
        child: TabBar(
          labelPadding: EdgeInsets.only(left: 0.w),
          controller: controller.commentTab,
          isScrollable: true,
          indicator: const MyUnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: AppColor.colorFFFFFF,
            ),
          ),
          labelColor: AppColor.color111111,
          unselectedLabelColor: AppColor.colorABABAB,
          labelStyle: AppTextStyle.f_12_400,
          unselectedLabelStyle: AppTextStyle.f_12_400,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(LocaleKeys.community81.tr), // 热门

                  Container(
                    width: 1,
                    height: 14.w,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    decoration: BoxDecoration(
                      color: AppColor.colorF5F5F5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
            Tab(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(LocaleKeys.community82.tr), // 热门
            ])),
          ],
        ));
  }

  // 显示长按弹窗
  removePlDialog(context, CommunityCommentReplyEnum level, int firstIndex,
      int? secondIndex) {
    CommunityCommentItem? item;
    if (level == CommunityCommentReplyEnum.firstLevel) {
      item = controller.onelevellist[firstIndex];
    } else {
      item = controller
          .onelevellist[firstIndex].childComments?.data?[secondIndex!];
    }
    var isMe = UserGetx.to.uid == item?.memberId;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(
                    0.w, 0.w, 0.w, controller.paddingBottom),
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
                                      controller.onelevellist
                                          .removeAt(firstIndex);
                                      controller.onelevellist[firstIndex]
                                          .childComments?.total -= 1;
                                    } else {
                                      controller.onelevellist[firstIndex]
                                          .childComments?.data
                                          ?.removeAt(secondIndex!);
                                    }
                                    Get.back();
                                    controller.update();
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
                                    showPLDialog(context, level, firstIndex,
                                        secondIndex);
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
      data = controller.onelevellist[firstIndex];
    } else if (level == CommunityCommentReplyEnum.secondLevel) {
      data = controller
          .onelevellist[firstIndex].childComments?.data?[secondIndex!];
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.colorF5F5F5,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: ExtendedTextField(
                            scrollPadding: const EdgeInsets.all(0),
                            autofocus: true,
                            onChanged: (text) {
                              // 强制更新状态以确保文本框重绘
                              //   controller.update();
                            },
                            onSubmitted: (String val) async {
                              controller.commentreply(
                                  data, level, firstIndex, secondIndex);
                              // 提交后确保焦点正确
                              controller.focus.requestFocus();
                            },
                            maxLines: null,
                            minLines: 1,
                            textInputAction: TextInputAction.send,
                            focusNode: controller.focus,
                            specialTextSpanBuilder:
                                controller.mySpecialTextSpanBuilder,
                            controller: controller.replyController,
                            style: AppTextStyle.f_14_500,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: level == CommunityCommentReplyEnum.post
                                  ? LocaleKeys.community1.tr
                                  : LocaleKeys.community5
                                      .trArgs([' ${data?.memberName ?? ''}']),
                              hintStyle: AppTextStyle.f_14_400.colorABABAB
                                  .copyWith(height: 1),
                            ),
                            // // 添加监听粘贴操作
                            // onPaste: () {
                            //   // 强制更新状态并重绘
                            //   controller.replyController.text =
                            //       controller.replyController.text;
                            //   controller.update();
                            // },
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
                            controller.commentreply(
                                data, level, firstIndex, secondIndex);
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
          ));
        });
  }
}
