import 'dart:ui';

import 'package:better_player/better_player.dart';
import 'package:better_player/src/controls/better_player_material_progress_bar.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/community_comment_widget/index.dart';
import 'package:nt_app_flutter/app/modules/community/community_video_info/controllers/community_video_info_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/community/community_info_public.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_like_icon.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_more_bottom_dialog.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityVideoInfoView extends GetView<CommunityVideoInfoController> {
  const CommunityVideoInfoView({super.key});

  @override
  String? get tag => TagCacheUtil().getTag('CommunityVideoInfoController');

  @override
  Widget build(BuildContext context) {
    controller.paddingBottom = MediaQuery.of(context).padding.bottom;
    return GetBuilder<CommunityVideoInfoController>(
        tag: tag,
        builder: (assetsGetx) {
          return Material(color: Colors.black, child: SafeArea(top: false, bottom: true, child: _buildMainContent(context)));
        });
  }

  Widget _buildMainContent(BuildContext context) {
    return MySystemStateBar(
        color: SystemColor.white,
        child: Stack(
          children: [
            GestureDetector(
                onTap: () {
                  if (controller.isOnePlay != true) {
                    controller.isOnePlay = true;
                  }
                  if (controller.isPause == true) {
                    controller.isPause = false;

                    controller.betterPlayerController.play();
                  } else {
                    controller.isPause = true;
                    controller.betterPlayerController.pause();
                  }
                  if (controller.isAddSpeed) {
                    controller.isAddSpeed = false;
                    controller.betterPlayerController.setSpeed(1);
                    controller.update();
                  }
                  controller.update();
                  controller.setHasShowAddSpeedTips();
                },
                onLongPressStart: (detail) {
                  debugPrint('onLongPressStart');
                  _onActionAddSpeed();
                  controller.setHasShowAddSpeedTips();
                },
                onLongPressEnd: (detial) {
                  _cancelAddSpeed();
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 50.w,
                    color: Colors.black,
                    child: AspectRatio(
                      aspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 50.w),
                      child: AbsorbPointer(
                          absorbing: true,
                          child: BetterPlayer(
                            controller: controller.betterPlayerController,
                          )),
                    ))),
            controller.isPause == true
                ? Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 32.w,
                    top: MediaQuery.of(context).size.height / 2 - 32.w - 50.w,
                    child: InkWell(
                      onTap: () {
                        if (controller.isOnePlay != true) {
                          controller.isOnePlay = true;
                        }
                        if (controller.isPause == true) {
                          controller.isPause = false;

                          controller.betterPlayerController.play();
                        } else {
                          controller.isPause = true;
                          controller.betterPlayerController.pause();
                        }
                        controller.update();
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                                width: 64.w,
                                height: 64.w,
                                child: Image.asset(
                                  'assets/images/community/pause.webp',
                                ))
                          ],
                        ),
                      ),
                    ))
                : Container(),
            // 外部内容
            _buildPostContentWidget(context),
            // _buildLikeColButton(),
            _buildNavWidget(context),
            //进度条
            _buildProgressBar(),
            // 2x快进提示
            _buildSpeedTips(),
            _buildVideoLoadingWidget(context),

            // 第一次进入app提示可以长按加速⏩
            _buildAddSpeedFirstTips(),
          ],
        ));
  }

  /// Navigator bar
  Widget _buildNavWidget(context) {
    return Positioned(
        child: AnimatedOpacity(
      opacity: controller.isAddSpeed ? 0 : 1,
      duration: Duration(milliseconds: 100),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40.w + MediaQuery.of(context).padding.top,
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration:
                      BoxDecoration(color: AppColor.colorBlack.withOpacity(0.2), borderRadius: BorderRadius.circular(100)),
                  margin: EdgeInsets.fromLTRB(19.w, 5.w, 19.w, 5.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyImage(
                        'default/page_back'.svgAssets(),
                        color: Colors.white,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ],
                  )),
              onTap: () {
                Get.back();
              },
            ),
            Flexible(
                child: InkWell(
              onTap: () {
                // var model = FollowKolInfo()
                //   ..uid = controller.infoData?.memberId
                //   ..userName = controller.infoData?.memberName
                //   ..imgUrl = controller.infoData?.memberHeadUrl;
                Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': controller.infoData?.memberId});
              },
              child: Row(
                children: [
                  UserAvatar(
                    '${controller.infoData?.memberHeadUrl ?? controller.data?.memberHeadUrl ?? ''}',
                    width: 20.w,
                    height: 20.w,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Flexible(
                    child: Text(
                      '${controller.infoData?.memberName ?? controller.data?.memberName ?? ''}',
                      style: AppTextStyle.f_15_600.colorWhite,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )),
            const Spacer(),
            InkWell(
              child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration:
                      BoxDecoration(color: AppColor.colorBlack.withOpacity(0.2), borderRadius: BorderRadius.circular(100)),
                  margin: EdgeInsets.fromLTRB(19.w, 5.w, 19.w, 5.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyImage(
                        'community/more'.svgAssets(),
                        color: AppColor.colorWhite,
                        width: 18.w,
                      )
                    ],
                  )),
              onTap: () {
                if (controller.infoData != null) {
                  postMoreBottomDialog(
                      uid: controller.infoData?.memberId,
                      userName: '${controller.infoData?.memberName ?? '--'}',
                      postData: controller.infoData,
                      blockSuccessFun: () {
                        Get.back();
                      });
                }
              },
            ),
          ],
        ),
      ),
    ));
  }

  /// 帖子信息
  Widget _buildPostContentWidget(context) {
    return Positioned(
        child: AnimatedOpacity(
      opacity: controller.isAddSpeed ? 0 : 1,
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                  Color(0x00000000),
                  Color(0xff000000),
                ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: '${controller.infoData?.topicTitle ?? controller.data?.topicTitle ?? ''}'.isNotEmpty,
                                  child: Text(
                                      '${controller.infoData?.topicTitle ?? controller.data?.topicTitle ?? ''}'.stringSplit(),
                                      style: AppTextStyle.f_18_600.colorWhite),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Visibility(
                                  visible:
                                      '${controller.infoData?.topicContent ?? controller.data?.topicContent ?? ''}'.isNotEmpty,
                                  child: GestureDetector(
                                    onTap: () {
                                      showMyBottomDialog(context, communityWidget(context),
                                          isDismissible: true, padding: EdgeInsets.only(top: 16.w));
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${controller.infoData?.topicContent ?? controller.data?.topicContent ?? ''}'
                                              .stringSplit(),
                                          style: AppTextStyle.f_14_400.colorWhite,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // TranslateWidget(
                                        //   text: infoData?.topicContent,
                                        //   postId: infoData?.id,
                                        //   translateFontColor: Colors.white,
                                        //   defaultTargetDesc: targetDescription,
                                        //   defaultTargetName: targetName,
                                        //   defaultTranslateType: translateType,
                                        //   maxTranslateContentLine: 2,
                                        //   translateComplete:
                                        //       (desc, name, type) {
                                        //     targetDescription = desc;
                                        //     targetName = name;
                                        //     translateType = type;
                                        //     if (mounted) setState(() {});
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 38.h),
                  ],
                ),
              ),
              controller.infoData != null
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.fromLTRB(
                        16.w,
                        6.w,
                        16.w,
                        6.w,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (Get.find<UserGetx>().goIsLogin()) {
                                  showMyBottomDialog(context, communityWidget(context),
                                      isDismissible: true, padding: EdgeInsets.only(top: 16.w));
                                  showPLDialog(
                                    context,
                                    CommunityCommentReplyEnum.post,
                                    0,
                                    0,
                                  )?.then((value) {
                                    controller.update();
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
                                alignment: Alignment.centerLeft,
                                height: 36.w,
                                decoration: BoxDecoration(
                                    color: AppColor.colorWhite.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  LocaleKeys.community1.tr,
                                  style: AppTextStyle.f_14_400.colorABABAB,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
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
                                margin: EdgeInsets.only(left: 20.w),
                                width: 29.w,
                                height: 40.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyImage(
                                      'community/comment'.svgAssets(),
                                      width: 18.w,
                                      height: 18.w,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )),
                          InkWell(
                              onTap: () async {
                                // 收藏
                                controller.collectTap();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 20.w),
                                width: 29.w,
                                height: 40.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyImage(
                                      (controller.infoData?.collectFlag ? 'community/collected' : 'community/collect')
                                          .svgAssets(),
                                      width: 18.w,
                                      height: 18.w,
                                      color: controller.infoData?.collectFlag ? null : Colors.white,
                                    ),
                                  ],
                                ),
                              )),
                          Visibility(
                              visible: controller.infoData?.praiseFlag != null,
                              child: InkWell(
                                  onTap: () async {
                                    controller.praiseTap();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20.w),
                                    width: 29.w,
                                    height: 40.w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Builder(builder: (_) {
                                          if (controller.postLikeIcon == null) {
                                            controller.postLikeIcon = PostLikeIcon(
                                              isLike: controller.infoData?.praiseFlag,
                                              likeIconSize: 22,
                                              likeType: PostLikeType.videoPostLike,
                                            );
                                          } else {
                                            controller.postLikeIcon!.setIsLike(controller.infoData?.praiseFlag);
                                          }
                                          return controller.postLikeIcon!;
                                        }),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 52.h,
                    ),
            ],
          )),
    ));
  }

  /// 喜欢 分享 评论 按钮
  Widget _buildLikeColButton() {
    return controller.infoData != null
        ? Builder(builder: (context) {
            var bottom = 130.w;

            /// 分享123
            return Positioned(
              right: 20.w,
              bottom: bottom,
              child: AnimatedOpacity(
                opacity: controller.isAddSpeed ? 0 : 1,
                duration: Duration(milliseconds: 100),
                child: Container(
                  child: Column(
                    children: [
                      PostLikeButton(item: controller.infoData),
                      SizedBox(
                        height: 30.w,
                      ),
                      InkWell(
                          onTap: () {
                            if (Get.find<UserGetx>().goIsLogin()) {
                              showMyBottomDialog(context, communityWidget(context),
                                  isDismissible: true, padding: EdgeInsets.only(top: 16.w));
                              showPLDialog(context, CommunityCommentReplyEnum.post, 0, 0)?.then((value) {
                                controller.update();
                              });
                            }
                          },
                          child: Container(
                            child: Column(
                              children: [
                                MyImage(
                                  'community/video_post/icon_sp_pl'.svgAssets(),
                                  width: 24.w,
                                  height: 24.w,
                                ),
                                SizedBox(
                                  height: 2.w,
                                ),
                                Text(
                                  '${controller.infoData?.commentNum != null ? controller.infoData?.commentNum == 0 ? '评论' : controller.infoData?.commentNum : '评论'}'
                                      .stringSplit(),
                                  style: TextStyle(
                                      // height: 1,
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30.w,
                      ),
                      InkWell(
                          onTap: () async {
                            // if (Get.find<UserGetx>().goIsLogin()) {
                            //   print(infoData?.collectFlag);
                            //   print(infoData?.collectNum);
                            //   if (infoData?.collectFlag == false) {
                            //     await topiccollectnewOrCancel(
                            //         1, infoData?.id, '');
                            //     infoData?.collectNum += 1;
                            //   } else {
                            //     await topiccollectnewOrCancel(
                            //         1, infoData?.id, '');
                            //     infoData?.collectNum -= 1;
                            //   }
                            //   infoData?.collectFlag = !infoData?.collectFlag;
                            //   setState(() {});
                            // }
                          },
                          child: Container(
                            child: Column(
                              children: [
                                MyImage(
                                  (controller.infoData?.collectFlag
                                          ? 'community/video_post/icon_sp_sced'
                                          : 'community/video_post/icon_sp_sc')
                                      .svgAssets(),
                                  width: 24.w,
                                  height: 24.w,
                                ),
                                SizedBox(
                                  height: 2.w,
                                ),
                                Text(
                                  '${controller.infoData?.collectNum != null ? controller.infoData?.collectNum == 0 ? LocaleKeys.community31.tr : controller.infoData?.collectNum : LocaleKeys.community31.tr}'
                                      .stringSplit(),
                                  style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            MyImage(
                              'icon_s_side_fx'.svgAssets(),
                              color: Colors.white,
                              width: 24.w,
                              height: 24.w,
                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                            Text(
                              '分享',
                              style: TextStyle(fontSize: 10.sp, color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          })
        : SizedBox();
  }

  /// 进度条
  Widget _buildProgressBar() {
    return Positioned(
      bottom: 50.w,
      left: 0,
      right: 0,
      child: Visibility(
        visible: controller.videoUrl != null,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          alignment: Alignment.bottomCenter,
          height: 38.w,
          // color: Colors.red,
          child: BetterPlayerMaterialVideoProgressBar(
            controller.betterPlayerController.videoPlayerController,
            controller.betterPlayerController,
            key: ValueKey(controller.progressWidgetKey),
            colors: BetterPlayerProgressColors(
              // 进度颜色
              playedColor: AppColor.colorWhite,
              // 进度块颜色
              handleColor: AppColor.colorWhite,
              // 缓冲颜色
              bufferedColor: AppColor.colorWhite.withOpacity(0.4),
              // backgroundColor: AppColor.colorWhite,
            ),
          ),
        ),
      ),
    );
  }

  /// 2x快进提示
  Widget _buildSpeedTips() {
    return Positioned(
        bottom: 29.w,
        child: AnimatedOpacity(
          opacity: controller.isAddSpeed ? 1 : 0,
          duration: Duration(milliseconds: 100),
          child: Container(
            width: ScreenUtil().screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('2X', style: AppTextStyle.f_12_600.colorWhite),
                Text(LocaleKeys.community15.tr, style: AppTextStyle.f_12_600.colorWhite),
                MyImage(
                  'community/video_speed'.svgAssets(),
                  width: 14.w,
                  height: 9.w,
                )
              ],
            ),
          ),
        ));
  }

  /// 第一次进入app提示可以长按加速⏩
  Widget _buildAddSpeedFirstTips() {
    if (!controller.hasShowAddSpeedTips) {
      return Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
              width: 168.w,
              height: 98.w,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(8.w)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.community16.tr,
                    style: TextStyle(fontSize: 20.w, color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  MyImage('community/video_speed'.svgAssets())
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  /// 视频加载中loading
  Widget _buildVideoLoadingWidget(context) {
    return Positioned(
        left: MediaQuery.of(context).size.width / 2 - 40.w,
        top: MediaQuery.of(context).size.height / 2 - 32.w - 50.w,
        child: controller.videoLoadingWidget ?? Container());
  }

  // 显示长按弹窗
  removePlDialog(context, CommunityCommentReplyEnum level, int firstIndex, int? secondIndex) {
    CommunityCommentItem? item;
    if (level == CommunityCommentReplyEnum.firstLevel) {
      item = controller.onelevellist[firstIndex];
    } else {
      item = controller.onelevellist[firstIndex].childComments?.data?[secondIndex!];
    }
    var isMe = UserGetx.to.uid == item?.memberId;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(0.w, 0.w, 0.w, controller.paddingBottom),
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
                                  bool res = await socialsocialpostcommentdel(item?.id);
                                  if (res == true) {
                                    if (level == CommunityCommentReplyEnum.firstLevel) {
                                      controller.onelevellist.removeAt(firstIndex);
                                      controller.onelevellist[firstIndex].childComments?.total -= 1;
                                    } else {
                                      controller.onelevellist[firstIndex].childComments?.data?.removeAt(secondIndex!);
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
                            CopyUtil.copyText(MyCommunityUtil.specialStringtToCommonString(
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

  showPLDialog(context, CommunityCommentReplyEnum level, int firstIndex, int? secondIndex) {
    CommunityCommentItem? data;
    if (level == CommunityCommentReplyEnum.firstLevel) {
      data = controller.onelevellist[firstIndex];
    } else if (level == CommunityCommentReplyEnum.secondLevel) {
      data = controller.onelevellist[firstIndex].childComments?.data?[secondIndex!];
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
              bottom: MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewInsets.bottom,
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
                                focusNode: controller.focus,
                                onSubmitted: (String val) async {
                                  controller.commentreply(data, level, firstIndex, secondIndex);
                                },
                                specialTextSpanBuilder: controller.mySpecialTextSpanBuilder,
                                controller: controller.replyController,
                                style: AppTextStyle.f_14_500,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: level == CommunityCommentReplyEnum.post
                                      ? LocaleKeys.community1.tr
                                      : LocaleKeys.community5.trArgs([' ${data?.memberName ?? ''}']),
                                  hintStyle: AppTextStyle.f_14_400.colorABABAB.copyWith(height: 1),
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
                                controller.commentreply(data, level, firstIndex, secondIndex);
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

  Widget communityWidget(context) {
    return Container(
        width: 1.sw,
        height: 1.sh - 64.w - ScreenUtil().bottomBarHeight - ScreenUtil().statusBarHeight,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Color(0xff999999), borderRadius: BorderRadius.circular(16)),
              width: 40.w,
              height: 5.w,
            ),
            SizedBox(height: 24.w),
            Expanded(
              child: SmartRefresher(
                controller: controller.refreshController,
                scrollController: controller.refreshScrollCtl,
                enablePullDown: true,
                enablePullUp: true,
                // onRefresh: _pullDown,
                onRefresh: () async {
                  controller.onelevelPage = 1;
                  await controller.getsocialsocialpostpublicsfindOne();
                  await controller.gettopiccommentpageList();
                  controller.update();
                  // await getMessage();
                  controller.refreshController.refreshToIdle();
                  controller.refreshController.loadComplete();
                },
                // onLoading: _pullUp,
                onLoading: () async {
                  if (controller.onelevelTotalPage <= controller.onelevelPage) {
                    controller.refreshController.loadNoData();
                  } else {
                    controller.onelevelPage = controller.onelevelPage + 1;
                    await controller.gettopiccommentpageList();
                    controller.update();
                    controller.refreshController.loadComplete();
                  }
                },
                // onLoading: _pullUp,
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      Container(child: communityInfoPublicWidget(context, controller.data, controller.infoData)),
                      14.verticalSpace,
                      Row(
                        children: [
                          Text(
                              key: controller.newCommentKey,
                              LocaleKeys.community2.trArgs(['${controller.infoData?.commentNum ?? '0'}']),
                              style: AppTextStyle.f_14_600),
                        ],
                      )
                    ],
                  ).marginOnly(top: 16.h)),
                  SliverToBoxAdapter(child: Builder(builder: (_) {
                    if (controller.onelevellist.isEmpty) {
                      return Container(
                        margin: EdgeInsets.only(top: 30.w),
                        child: noDataWidget(
                          context,
                          wigetHeight: 210.w,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var item = controller.onelevellist[index];
                        return CommunityCommentWidget(
                          item: item,
                          firstLevelIndex: index,
                          subCommentKeys: controller.subCommentKeys,
                          onLongPress: (int? secondIndex, CommunityCommentReplyEnum level) {
                            removePlDialog(context, level, index, secondIndex);
                          },
                          onTap: (int? secondIndex, CommunityCommentReplyEnum level) {
                            if (Get.find<UserGetx>().goIsLogin()) {
                              showPLDialog(context, level, index, secondIndex);
                            }
                          },
                          model: controller.data,
                          onRefresh: (action, type) {},
                        );
                      },
                      childCount: controller.onelevellist.length,
                    ),
                  ),
                ]),
              ).marginSymmetric(horizontal: 16.w),
            ),
            controller.infoData != null
                ? Container(
                    decoration: BoxDecoration(border: Border(top: BorderSide(width: 1.w, color: Color(0xffEEEEEE)))),
                    padding:
                        EdgeInsets.only(bottom: 6.h + MediaQuery.of(context).padding.bottom, left: 16.w, top: 6.w, right: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (Get.find<UserGetx>().goIsLogin()) {
                                showPLDialog(context, CommunityCommentReplyEnum.post, 0, 0);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(9.w, 0, 9.w, 0),
                              alignment: Alignment.centerLeft,
                              height: 36.w,
                              decoration: BoxDecoration(color: Color(0xffF9F9F9), borderRadius: BorderRadius.circular(6.w)),
                              child: Text(
                                LocaleKeys.community1.tr,
                                style: AppTextStyle.f_14_400.colorABABAB,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ));
  }

  /// 取消视频加速
  void _cancelAddSpeed() {
    var isPlayer = controller.betterPlayerController.isPlaying();
    if (isPlayer == true && controller.isAddSpeed) {
      controller.isAddSpeed = false;
      controller.betterPlayerController.setSpeed(1);
      controller.update();
    }
  }

  /// 执行视频加速
  void _onActionAddSpeed() {
    var isPlayer = controller.betterPlayerController.isPlaying();
    if (isPlayer == true && !controller.isAddSpeed) {
      controller.isAddSpeed = true;
      controller.betterPlayerController.setSpeed(2);
      controller.update();
    }
  }
}
