import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/file_upload.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/comment_widget_page.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/interested_people_widget.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_like_icon.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_more_bottom_dialog.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/model/pic_swiper_item.dart';
import 'package:nt_app_flutter/app/widgets/imageWidget/common/widget/pic_swiper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

Widget postListWidget(context, TopicdetailModel item, {key, isMe = false, isFail = false, tap, isSC = false, isLike = false}) {
  return item.interestPeopleList != null
      ? InterestedPeopleWidget(
          list: item.interestPeopleList!,
        )
      : item.cmsDatatList != null
          ? item.cmsDatatList!.isNotEmpty
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.h),
                  decoration: const BoxDecoration(
                      color: AppColor.colorWhite, border: Border(bottom: BorderSide(width: 1, color: AppColor.colorEEEEEE))),
                  child: Column(children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Get.toNamed(Routes.FOLLOW_TAKER_LIST, arguments: {'index': 1}),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            LocaleKeys.community41.tr,
                            style: AppTextStyle.f_16_600,
                          ),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    MyActivityWidget(
                      height: 130.h,
                      list: item.cmsDatatList!,
                    ),
                  ]))
              : const SizedBox()
          : GestureDetector(
              onTap: () async {
                if (item.type == CommunityFileTypeEnum.VIDEO) {
                  Get.toNamed(Routes.COMMUNITY_VIDEO_INFO, arguments: {'topicNo': item.topicNo, 'data': item});
                } else {
                  Get.toNamed(Routes.COMMUNITY_INFO, arguments: {'topicNo': item.topicNo, 'data': item});
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0.w, 16.h, 0.w, 12.h),
                decoration: BoxDecoration(
                    color: AppColor.colorFFFFFF, border: Border(bottom: BorderSide(width: 1.w, color: AppColor.colorEEEEEE))),
                key: key,
                child: Column(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // var model = FollowKolInfo()..uid = item.memberId;
                            Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': item.memberId});
                          },
                          child: Row(
                            children: [
                              UserAvatar(
                                '${item.memberHeadUrl ?? ''}',
                                width: 34.w,
                                height: 34.w,
                                tradeIconSize: 11.w,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${item.memberName ?? '--'}'.stringSplit(), style: AppTextStyle.f_15_500.color4D4D4D),
                                  Text(
                                      item.createTime != null
                                          ? RelativeDateFormat.format(DateTime.parse('${item.createTime}'))
                                          : '',
                                      style: AppTextStyle.f_12_400.color999999)
                                ],
                              )),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SizedBox(
                                    width: 32.w,
                                    height: 16.w,
                                  ),
                                  Positioned(
                                      right: -16.w,
                                      top: -16.w,
                                      child: InkWell(
                                          onTap: () {
                                            postMoreBottomDialog(
                                                uid: item.memberId,
                                                userName: '${item.memberName ?? '--'}',
                                                postData: item,
                                                blockSuccessFun: () {});
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(16.w),
                                            child: MyImage(
                                              'community/more'.svgAssets(),
                                              width: 16.w,
                                              color: AppColor.color999999,
                                            ),
                                          )))
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Visibility(
                          visible: (item.topicTitle ?? '').isNotEmpty || (item.topicContent ?? '').isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: (item.topicTitle ?? '').isNotEmpty,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 8.h),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${item.topicTitle ?? ''}'.stringSplit(),
                                    style: AppTextStyle.f_18_500.color111111,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: (item.topicContent ?? '').isNotEmpty,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${item.topicContent ?? ''}'.stringSplit(),
                                    style: AppTextStyle.f_15_400.color4D4D4D,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AbsorbPointer(
                          absorbing: true, // 设置为 true 来阻止子级接收点击事件
                          child: (item.picList != null && item.picList!.isNotEmpty) ||
                                  (item.videoList != null && item.videoList!.isNotEmpty)
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                    postImageWidget(context, item.type,
                                        item.type == CommunityFileTypeEnum.VIDEO ? item.videoList : item.picList,
                                        coverInfo: item.coverInfo)
                                  ],
                                )
                              : const SizedBox(),
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                      ],
                    ).marginSymmetric(horizontal: 16.w),
                    Container(
                      height: 22.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyImage('community/graph'.svgAssets()),
                              Visibility(
                                  visible: item.pageViewNum != null && item.pageViewNum != 0,
                                  child: Text(
                                    MyLongDataUtil.convert('${item.pageViewNum}').stringSplit(),
                                    style: AppTextStyle.f_14_400.color4D4D4D,
                                  ).marginOnly(left: 4.w))
                            ],
                          )),
                          Expanded(
                              child: PostCollectButton(
                            item: item,
                          )),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    if (Get.find<UserGetx>().goIsLogin()) {
                                      getCommentDialog(context, item, isDismissible: true)?.then((value) {
                                        if (value is Map && value.isNotEmpty) {}
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyImage(
                                        'community/comment'.svgAssets(),
                                        width: 16.w,
                                        height: 16.w,
                                        color: AppColor.color999999,
                                      ),
                                      Visibility(
                                          visible: item.commentNum != null && item.commentNum != 0,
                                          child: Text(
                                            MyLongDataUtil.convert('${item.commentNum}').stringSplit(),
                                            style: AppTextStyle.f_14_400.color4D4D4D,
                                          ).marginOnly(left: 4.w))
                                    ],
                                  ))),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    Get.dialog(
                                      MyShareView(
                                        content: postShareWidget(item, '${LinksGetx.to.topicUrl}${item.topicNo}'),
                                        url: '${LinksGetx.to.topicUrl}${item.topicNo}',
                                      ),
                                      useSafeArea: false,
                                      barrierDismissible: true,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyImage(
                                        'default/share'.svgAssets(),
                                        width: 14.w,
                                        height: 14.w,
                                        color: AppColor.color999999,
                                      ),
                                      Visibility(
                                          visible: item.shareNum != null && item.shareNum != 0,
                                          child: Text(
                                            MyLongDataUtil.convert('${item.shareNum}').stringSplit(),
                                            style: AppTextStyle.f_14_400.color4D4D4D,
                                          ).marginOnly(left: 4.w))
                                    ],
                                  ))),
                          Expanded(
                              child: PostLikeButton(
                            item: item,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ))
                        ],
                      ),
                    ),
                    /* 列表-评论框（暂时隐藏）  */
                    // item.scTopicCommentVoList != null &&
                    //         item.scTopicCommentVoList!.isNotEmpty
                    //     ? InkWell(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               color: AppColor.colorF5F5F5,
                    //               borderRadius: BorderRadius.circular(6)),
                    //           margin: EdgeInsets.only(top: 12.h),
                    //           padding: EdgeInsets.fromLTRB(10.w, 14.w, 10.w, 8.w),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text('查看全部${item.commentNum}条评论',
                    //                   style: AppTextStyle.medium2_400.color999999),
                    //               Column(
                    //                   // crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: worker<Widget>(
                    //                       item.scTopicCommentVoList, (indexs, items) {
                    //                 return Container(
                    //                   padding: EdgeInsets.symmetric(vertical: 5.w),
                    //                   child: Row(
                    //                     children: [
                    //                       Text(
                    //                         '${items.memberName ?? ''}：',
                    //                         style:
                    //                             AppTextStyle.medium2_500.color111111,
                    //                       ),
                    //                       items.preMemberName != null
                    //                           ? Row(
                    //                               children: [
                    //                                 Text(
                    //                                   '回复 ',
                    //                                   style: AppTextStyle
                    //                                       .medium2_400.color111111,
                    //                                 ),
                    //                                 Text(
                    //                                   '${items.preMemberName}',
                    //                                   style: AppTextStyle
                    //                                       .medium2_400.color666666,
                    //                                   maxLines: 1,
                    //                                   overflow: TextOverflow.ellipsis,
                    //                                 ),
                    //                                 Text(
                    //                                   '：',
                    //                                   style: AppTextStyle
                    //                                       .medium2_400.color999999,
                    //                                   maxLines: 1,
                    //                                   overflow: TextOverflow.ellipsis,
                    //                                 ),
                    //                               ],
                    //                             )
                    //                           : const SizedBox(),
                    //                       Flexible(
                    //                         child: Text(
                    //                           '${items.commentContent ?? ''}',
                    //                           style: AppTextStyle
                    //                               .medium2_400.color666666,
                    //                           maxLines: 1,
                    //                           overflow: TextOverflow.ellipsis,
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 );
                    //               }))
                    //             ],
                    //           ),
                    //         ),
                    //         onTap: () {
                    //           if (Get.find<UserGetx>().goIsLogin()) {
                    //             getCommentDialog(context, item.topicNo,
                    //                 isDismissible: true);
                    //           }
                    //         },
                    //       )
                    //     : Container(),
                  ],
                ),
              ),
            );
}

// 显示弹窗
Future? getCommentDialog(context, TopicdetailModel item, {isDismissible = false}) {
  return showMyBottomDialog(
    context,
    padding: EdgeInsets.fromLTRB(0.w, 24.h, 0.w, 0),
    MyCommentWidget(
      topicNo: item.topicNo,
      model: item,
      onUpdateOneLevelList: (onlevelList, onelevelTotal) {
        item.commentNum = onelevelTotal;
      },
    ),
  );
}

postImageOneWidget(context, {required pics, required index, width, height}) {
  return InkWell(
    onTap: () {
      Get.dialog(
        Material(
          type: MaterialType.transparency,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: PicSwiper(
              index: index,
              pics: pics,
            ),
          ),
        ),
        barrierDismissible: true,
      );
    },
    child: MyImage(
      '${pics[index].picUrl}',
      width: width,
      height: height,
      radius: 6,
      fit: BoxFit.cover,
    ),
  );
}

postImageWidget(context, type, List<ScTopicFileVoListModel>? picList, {coverInfo}) {
  if (picList == null) return const SizedBox.shrink();
  List<PicSwiperItem> pics = [];

  for (var i = 0; i < picList.length; i++) {
    if (picList[i].fileUrl != null) {
      pics.add(PicSwiperItem(picUrl: picList[i].fileUrl, des: ''));
    }
  }
  switch (picList.length) {
    case 0:
      return const SizedBox();
    case 1:
      return type == CommunityFileTypeEnum.VIDEO
          ? Stack(alignment: Alignment.center, children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  clipBehavior: Clip.antiAlias,
                  constraints: BoxConstraints(
                    maxHeight: Get.width * 4 / 3,
                    minHeight: Get.width * 3 / 4,
                  ),
                  child: MyImage(
                    '${coverInfo?.fileUrl ?? ''}',
                    width: coverInfo?.width,
                    height: coverInfo?.height,
                    radius: 6,
                    isDefaultSize: true,
                    fit: BoxFit.cover,
                  )),
              Align(
                  alignment: Alignment.center, // 垂直居中对齐
                  child: Center(
                      child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(color: Color(0x40111111), borderRadius: BorderRadius.circular(99)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyImage(
                                'community/video_play'.svgAssets(),
                                width: 14.w,
                                radius: 6,
                              ),
                            ],
                          ))) // 你要居中的组件 B
                  ),
            ])
          : InkWell(
              onTap: () {
                Get.dialog(
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: PicSwiper(
                      index: 0,
                      pics: pics,
                    ),
                  ),
                  useSafeArea: false,
                  barrierDismissible: true,
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  clipBehavior: Clip.antiAlias,
                  constraints: BoxConstraints(
                    maxHeight: Get.width * 4 / 3,
                    minHeight: Get.width * 3 / 4,
                  ),
                  child: MyImage(
                    '${picList[0].fileUrl ?? ''}',
                    width: picList[0].width,
                    height: picList[0].height,
                    isDefaultSize: true,
                    radius: 6,
                    fit: BoxFit.cover,
                  )));

    case 2:
      return Row(
        children: [
          postImageOneWidget(
            context,
            pics: pics,
            index: 0,
            width: 170.w,
            height: 170.w,
          ),
          const Spacer(),
          postImageOneWidget(
            context,
            pics: pics,
            index: 1,
            width: 170.w,
            height: 170.w,
          )
        ],
      );
    case 3:
      return Row(
        children: [
          postImageOneWidget(
            context,
            pics: pics,
            index: 0,
            width: 170.w,
            height: 170.w,
          ),
          const Spacer(),
          Column(
            children: [
              postImageOneWidget(
                context,
                pics: pics,
                index: 1,
                width: 170.w,
                height: 83.w,
              ),
              SizedBox(
                height: 4.w,
              ),
              postImageOneWidget(
                context,
                pics: pics,
                index: 2,
                width: 170.w,
                height: 83.w,
              )
            ],
          )
        ],
      );

    case 4:
      return Row(
        children: [
          Column(
            children: [
              postImageOneWidget(
                context,
                pics: pics,
                index: 0,
                width: 170.w,
                height: 83.w,
              ),
              SizedBox(
                height: 4.w,
              ),
              postImageOneWidget(
                context,
                pics: pics,
                index: 1,
                width: 170.w,
                height: 83.w,
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              postImageOneWidget(
                context,
                pics: pics,
                index: 2,
                width: 170.w,
                height: 83.w,
              ),
              SizedBox(
                height: 4.w,
              ),
              postImageOneWidget(
                context,
                pics: pics,
                index: 3,
                width: 170.w,
                height: 83.w,
              )
            ],
          )
        ],
      );

    default:
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 112.w,
        child: WaterfallFlow.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: 3,
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.w,
              mainAxisSpacing: 0.w,
            ),
            itemBuilder: (context, i) {
              return SizedBox(
                  width: 112.w,
                  height: 112.w,
                  child: Stack(
                    children: [
                      postImageOneWidget(
                        context,
                        pics: pics,
                        index: i,
                        width: 112.w,
                        height: 112.w,
                      ),
                      i == 2
                          ? Positioned(
                              right: 4.w,
                              bottom: 4.w,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(6.w, 2.w, 6.w, 2.w),
                                decoration: BoxDecoration(
                                    color: AppColor.colorBlack.withOpacity(0.4), borderRadius: BorderRadius.circular(4)),
                                child: Text('+${picList.length}'.stringSplit(),
                                    style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ));
            }),
      );
  }
}
