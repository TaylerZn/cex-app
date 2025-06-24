import 'package:common_utils/common_utils.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/focus.dart';
import 'package:nt_app_flutter/app/models/community/hot_topic.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/views/my_polling_widget.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/image_selection_widget.dart';
import 'package:nt_app_flutter/app/modules/community/enum.dart';
import 'package:nt_app_flutter/app/modules/community/post_index/controllers/post_index_controller.dart';
import 'package:nt_app_flutter/app/modules/community/post_index/widgets/post_editor_tool_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/community/commodity_selector_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/components/community/flutter_polls.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:styled_text/styled_text.dart';

import '../../widget/vote_widget.dart';

class PostIndexView extends GetView<PostIndexController> {
  const PostIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        child: Scaffold(
      backgroundColor: AppColor.colorBackgroundPrimary,
      appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              UIUtil.showConfirm(LocaleKeys.community40.tr,
                  titleStyle: AppTextStyle.f_14_500.color333333,
                  confirmHandler: () {
                Get.back();
                Get.back();
              });
            },
            child: Icon(Icons.close, color: AppColor.color111111, size: 25.w),
          ),
          actions: [
            Row(
              children: [
                MyButton.mainBg(
                  height: 28.w,
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  text: LocaleKeys.community22.tr,
                  textStyle: AppTextStyle.f_13_500.colorAlwaysBlack,
                  onTap: () {
                    controller.submitOntap();
                  },
                ),
                SizedBox(
                  width: 16.w,
                )
              ],
            )
          ],
          elevation: 0),
      body: InkWell(
        onTap: () {
          AppUtil.hideKeyboard(context);
          controller.closeTags();
        },
        child: Container(
          color: AppColor.colorBackgroundPrimary,
          child: Column(children: [
            Container(
                color: AppColor.colorBackgroundPrimary,
                padding: EdgeInsets.only(top: 24.w, left: 16.w, right: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => ExtendedTextField(
                            // inputFormatters: [
                            //   LengthLimitingTextInputFormatter(
                            //       controller.titleMax.value),
                            // ],
                            maxLines: 2,
                            minLines: 1,
                            controller: controller.titleControll.value,
                            focusNode: controller.titleFocusNode,
                            style: AppTextStyle.f_16_500.colorTextPrimary,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              hintText: LocaleKeys.community23.trArgs([
                                '${controller.titleMin}',
                                '${controller.titleMax}'
                              ]).stringSplit(),
                              hintStyle: AppTextStyle.f_16_500.colorABABAB,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.transparent)),
                            ),
                          )),
                    ),
                  ],
                )),
            24.verticalSpaceFromWidth,
            Container(
                height: 1.w,
                color: AppColor.colorBorderGutter,
                width: double.infinity),
            24.verticalSpaceFromWidth,
            Expanded(
              child: Container(
                  color: AppColor.colorBackgroundPrimary,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ExtendedTextField(
                                specialTextSpanBuilder:
                                    controller.contentSpecialTextSpanBuilder,
                                //       inputFormatters: [
                                //   LengthLimitingTextInputFormatter(
                                //       controller.contentMax.value),
                                // ],
                                cursorColor: AppColor.color111111,
                                minLines: 1,
                                maxLines: 10,
                                textInputAction: TextInputAction.newline,
                                controller: controller.contentControll.value,
                                focusNode: controller.contentFocusNode,
                                style: AppTextStyle.f_14_400.colorTextSecondary,
                                decoration: InputDecoration(
                                  hintText: LocaleKeys.community24.trArgs([
                                    '${controller.contentMin.value}',
                                    '${controller.contentMax.value}'
                                  ]),
                                  hintMaxLines: 2,
                                  hintStyle: AppTextStyle.f_15_400.colorABABAB,
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.transparent)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.transparent)),
                                ),
                              ),
                              Obx(() => Visibility(
                                    visible: controller.contentLength > 0,
                                    child: Container(
                                        color: Colors.white,
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(
                                            top: 10.w, right: 16.w),
                                        child: StyledText(
                                          text:
                                              '${controller.contentLength.value}<b>/${controller.contentMax}</b>',
                                          style:
                                              AppTextStyle.f_12_500.colorFFD429,
                                          tags: {
                                            'b': StyledTextTag(
                                                style: AppTextStyle
                                                    .f_12_500.color666666),
                                          },
                                        )),
                                  )),
                              buildChildWidget(),
                              SizedBox(
                                height: 7.h,
                              ),
                            ],
                          ),
                        );
                      })),
            ),
            bottomWidget(),
            editorToolWidget(),
            Obx(() => Visibility(
                visible: controller.isShowScheduled.value,
                child: bottomAddWidget(context))),
          ]),
        ),
      ),
    ));
  }

  Widget buildChildWidget() {
    return Obx(() {
      return Visibility(
          visible: ObjectUtil.isNotEmpty(controller.itemList),
          child: Container(
              margin: EdgeInsets.only(top: 16.w),
              child: Column(
                children: controller.itemList.map((e) {
                  return Container(
                    child: e.widget ?? const SizedBox(),
                  );
                }).toList(),
              )));
    });
  }

  Widget buildVotePost() {
    return Obx(() => Visibility(
        visible: controller.voteList
                .where((p0) => ObjectUtil.isNotEmpty(p0))
                .length >=
            2,
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
          child: MyPollingWidget(
            options: controller.voteList
                .map((element) => PollOption(title: Text(element), votes: 0))
                .toList(),
          ),
        )));
  }

  Widget editorToolWidget() {
    return Container(
      color: AppColor.colorFFFFFF,
      child: Column(
        children: [
          Obx(() => PostEditorToolWidget(
                allowKline: controller.allowKline,
                onTypeTap: (type) {
                  switch (type) {
                    case PostEditorTooType.photo:
                      if (!controller.enabledVote) {
                        //已经加了投票元数
                        return;
                      }
                      controller.showOrHideScheduled(change: false);
                      controller.showOrHideMediaFiles();
                      controller.bottomShowType.value = PostShowTypeEnum.public;
                      break;
                    case PostEditorTooType.topic:
                      controller.showOrHideScheduled(change: false);
                      print(controller.bottomShowType.value);
                      if (controller.bottomShowType.value ==
                          PostShowTypeEnum.topic) {
                        controller.bottomShowType.value =
                            PostShowTypeEnum.public;
                      } else {
                        controller.bottomShowType.value =
                            PostShowTypeEnum.topic;
                      }

                      controller.topicTalkingPointList('');
                      break;
                    case PostEditorTooType.Kline:
                      if (!controller.allowKline) {
                        return;
                      }
                      CommoditySelectorBottomSheet.showCoinBottomSheet(
                              contractInfoList: controller.symbolList)
                          .then((value) {
                        String? type = value?.type;
                        num? id = value?.id;
                        if (type != null && id != null) {
                          controller.addCoinWidget(value);
                        }
                      });
                      break;
                    case PostEditorTooType.inter:
                      // 添加 退出键盘,避免键盘遮挡了编辑内容
                      FocusScope.of(Get.context!).requestFocus(FocusNode());
                      controller.showOrHideScheduled();
                      break;
                    default:
                      controller.postType = type;
                      break;
                  }
                },
              )),
          Obx(() => controller.isShowScheduled.value == true ||
                  controller.contentFocusNode.hasFocus ||
                  controller.titleFocusNode.hasFocus
              ? 0.verticalSpace
              : 30.verticalSpace),
          Container(height: 1, color: AppColor.colorEEEEEE),
        ],
      ),
    );
  }

  Widget bottomWidget() {
    return Stack(
      children: [
        Obx(() => Visibility(
              visible: controller.isShowMediaFiles.value == true,
              child: bottomImageWidget(),
            )),
        Obx(() => Visibility(
            visible: controller.bottomShowType.value == PostShowTypeEnum.at &&
                controller.focusList.isNotEmpty,
              child: Container(
                  height: 204.w,
                  color: AppColor.colorBackgroundPrimary,
                  child: ListView.builder(
                    // padding: EdgeInsets.symmetric(horizontal: 16.w),
                    physics: const ClampingScrollPhysics(),
                    itemCount: controller.focusList.length,
                    itemBuilder: (BuildContext c, int i) {
                      TopicFocusListModel item = controller.focusList[i];
                      return InkWell(
                        onTap: () {
                          controller.addAtWidget(item.nickName ?? '', '${item.uid}');
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.w),
                          child: Column(
                            children: [
                              if (i == 0) ...[
                                Divider(
                                  color: AppColor.colorF5F5F5, // 分割线颜色
                                  thickness: 1, // 分割线粗细
                                  // indent: 16.w, // 左边缩进
                                  // endIndent: 16.w, // 右边缩进
                                ),
                                SizedBox(height: 16.h), // Divider 和 Row 之间的间距
                              ],
                              Container(
                                height: 36.w,
                                child: Row(
                                  children: [
                                    UserAvatar(
                                      item.pictureUrl,
                                      levelType: item.levelType,
                                      width: 36.w,
                                      height: 36.w,
                                    ),
                                    8.horizontalSpace,
                                    Expanded(
                                        child: Text(
                                      (item.nickName ?? '').stringSplit(),
                                      style: AppTextStyle.f_15_500.colorTextTertiary,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    8.horizontalSpace,
                                    item.followStatus == 1
                                        ? Expanded(
                                            child: Text(
                                            LocaleKeys.community110.tr, //'关注中',
                                            style: AppTextStyle.f_12_400.colorTextTips,
                                            textAlign: TextAlign.end,
                                          ))
                                        : const SizedBox()
                                  ],
                                ).marginOnly(left: 16.w,right: 16.w),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            )),
        Obx(() => Visibility(
            visible:
                controller.bottomShowType.value == PostShowTypeEnum.topic &&
                    controller.topicList.isNotEmpty,
            child: Container(
              height: 220.h,
              color: AppColor.colorWhite,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.topicList.length,
                  itemBuilder: (BuildContext c, int i) {
                    HotTopicModel? item = controller.topicList[i];
                    return InkWell(
                        onTap: () {
                          controller.addTopicWidget(item.name ?? '');
                        },
                        child: Container(
                          height: 24.h,
                          margin: EdgeInsets.only(top: 20.h),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 220.w,
                                  child: Text(
                                    '#${item.displayName.stringSplit()}',
                                    style: AppTextStyle.f_14_500.color333333,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Expanded(
                                  child: Text(
                                MyLongDataUtil.convert(item.pageViewNum),
                                style: AppTextStyle.f_12_400.color999999,
                                textAlign: TextAlign.end,
                              ))
                            ],
                          ),
                        ));
                  }),
            ))),
      ],
    );
  }

  Widget bottomImageWidget() {
    return Obx(() => Container(
        width: Get.width,
        padding: EdgeInsets.fromLTRB(0.w, 16.w, 0.w, 16.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.videoCoverFile.value != null
                ? Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                              width: 100.w,
                              constraints: BoxConstraints(
                                maxHeight: 100 * 4 / 3,
                                minHeight: 100.w * 3 / 4,
                              ),
                              margin: EdgeInsets.only(
                                  left: 6.w, right: 8.w, top: 0.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2)),
                              clipBehavior: Clip.antiAlias,
                              child: Image.file(
                                controller.videoCoverFile.value!,
                                fit: BoxFit.cover,
                              )),
                          Align(
                              alignment: Alignment.center,
                              child: MyImage(
                                'community/video_play'.svgAssets(),
                                width: 16.w,
                                height: 16.w,
                              )),
                          Positioned(
                            right: 0.w,
                            top: 0.w,
                            child: InkWell(
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(right: 14.w, top: 6.w),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 14.w,
                                        height: 14.w,
                                        padding: EdgeInsets.all(3.w),
                                        decoration: BoxDecoration(
                                            color: AppColor.color111111
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(3.r)),
                                        child: MyImage(
                                          'default/close'.svgAssets(),
                                          color: Colors.white,
                                          width: 9.w,
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () => controller.onDeleteVideo(),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Container(
                            height: 64.w,
                            constraints: BoxConstraints(
                              maxWidth: Get.width,
                            ),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.picList.length < 9
                                    ? controller.picList.length + 1
                                    : 9,
                                itemBuilder: (context, index) {
                                  var itemIndex = controller.picList.length < 9
                                      ? index - 1
                                      : index;
                                  return index == 0 &&
                                          controller.picList.length < 9
                                      ? InkWell(
                                          child: Container(
                                            width: 64.w,
                                            height: 64.w,
                                            margin: EdgeInsets.only(
                                              left: 16.w,
                                              right: 6.w,
                                            ),
                                            decoration: BoxDecoration(
                                                color: AppColor.colorF5F5F5,
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            clipBehavior: Clip.antiAlias,
                                            alignment: Alignment.center,
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                  color: AppColor.colorA3A3A3,
                                                  fontSize: 32.sp,
                                                  height: 1),
                                            ),
                                          ),
                                          onTap: () async {
                                            controller.getPhotos();
                                            // if (await requestPhotosPermission()) {
                                            //   final List<AssetEntity>?
                                            //       result = await AssetPicker
                                            //           .pickAssets(
                                            //     context,
                                            //     pickerConfig:
                                            //         AssetPickerConfig(
                                            //             requestType:
                                            //                 RequestType
                                            //                     .image,
                                            //             maxAssets: 9 -
                                            //                 picList.length),
                                            //   );
                                            //   if (result != null) {
                                            //     _onAddImage(result);
                                            //   }
                                            // }
                                          },
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(right: 8.w),
                                          child: ImageSelectionWidget(
                                              imgPath: controller
                                                      .picList[itemIndex]
                                                      .imageFile
                                                      ?.path ??
                                                  '',
                                              index: itemIndex,
                                              onDelete: () {
                                                controller
                                                    .onDeleteImage(itemIndex);
                                              }),
                                        );
                                }))
                      ])
          ],
        )));
  }

  Widget bottomAddWidget(BuildContext context) {
    return Container(
      // height: 120.h,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage(
                      'community/set_time'.svgAssets(),
                      width: 36.w,
                      height: 36.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.community73.tr, //'定时发布',
                            style: AppTextStyle.f_16_500),
                        Visibility(
                            visible: (controller.isScheduled.value &&
                                controller.publishTime.value != DateTime.now()),
                            child: Text(
                                '${LocaleKeys.community125.tr}:${DateUtil.formatDate(controller.publishTime.value, format: 'yyyy-MM-dd HH:mm')}',
                                style: AppTextStyle.f_12_400.color999999))
                      ],
                    ),
                  ],
                ).marginOnly(right: 4.w),
                FlutterSwitch(
                  width: 37.w,
                  height: 20.w,
                  toggleSize: 16.w,
                  value: controller.isScheduled.value,
                  borderRadius: 30.0,
                  padding: 2.w,
                  activeColor: AppColor.mainColor,
                  inactiveColor: AppColor.colorDDDDDD,
                  onToggle: (val) {
                    controller.showTimeDialog(val);
                    // controller.changemobileverify();
                  },
                )
                // Obx(() => Switch(
                //

                //     ))
              ],
            ),
          ),
          SizedBox(height: 16.h),
          InkWell(
            onTap: () {
              if (!controller.enabledVote) {
                return;
              }
              controller.showOrHideScheduled(change: false);
              controller.showOrHideMediaFiles(change: false);
              controller.voteList = ['', ''].obs;
              PostChildWrapper element = PostChildWrapper(
                  tag: 'vote',
                  type: PostChild.vote,
                  widget: VoteWidget(removeTap: (t) {
                    controller.removeItemList('vote');
                    //  controller.itemList.remove(element);
                  }));
              controller.addItem([element]);
            },
            child: SizedBox(
              height: 36.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyImage('community/set_vote_no_sel'.svgAssets(),
                          width: 36.w,
                          height: 36.w,
                          color: controller.enabledVote
                              ? AppColor.color111111
                              : AppColor.color999999),
                      Text(LocaleKeys.community74.tr,
                          style: AppTextStyle.f_16_500.copyWith(
                              color: controller.enabledVote
                                  ? AppColor.color111111
                                  : AppColor.color999999)),
                    ],
                  ),
                  // 箭头图标放在右侧
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: MyImage('community/arrow_forward_ios'.svgAssets(),
                        width: 12.w, height: 12.w),
                  ),
                ],
              ),
            ),
          ),
          30.h.verticalSpace
        ],
      ),
    );
  }
}
