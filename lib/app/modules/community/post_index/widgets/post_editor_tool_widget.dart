import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class PostEditorToolWidgetController extends GetxController {
  // var isKeyboardVisible = false.obs;
  var isBearishClicked = false.obs; //是否看涨
  var isBullishClicked = false.obs; //是否看跌

  void onBearishTap(final ValueChanged<PostEditorTooType>? onTypeTap) {
    //看涨
    isBearishClicked.value = !isBearishClicked.value;
    if (isBearishClicked.value) {
      //涨跌互斥
      isBullishClicked.value = false;
    } else {}
    debugPrint('点击看涨');
    update();
  }

  void onBullishTap(final ValueChanged<PostEditorTooType>? onTypeTap) {
    //看跌
    isBullishClicked.value = !isBullishClicked.value;
    if (isBullishClicked.value) {
      isBearishClicked.value = false;
    } else {
      onTypeTap?.call(PostEditorTooType.normal);
    }
    debugPrint('点击看跌');
    update();
  }

  void onReseTap(final ValueChanged<PostEditorTooType>? onTypeTap) {
    //
    isBearishClicked.value = false;
    isBullishClicked.value = false;
    onTypeTap?.call(PostEditorTooType.normal);
    debugPrint('点击重置');
    update();
  }

  void onInit() {
    super.onInit();
    // _checkKeyboardVisibility();
  }
}

enum PostEditorTooType {
  photo, // 唤起 图片视频
  topic, // 唤起 话题
  Kline, // 投票or币对
  inter, // 插入(定时发帖/投票)
  bearish, // 看涨
  smooth, // 看平
  bullish, // 看跌
  normal
}

class PostEditorToolWidget extends StatelessWidget {
  final PostEditorToolWidgetController controller =
      Get.put(PostEditorToolWidgetController());
  final ValueChanged<PostEditorTooType>? onTypeTap;
  final bool allowKline;

  PostEditorToolWidget({super.key, this.onTypeTap, this.allowKline = true});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 40.h,
        padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 8.h),
        decoration: BoxDecoration(
          color: AppColor.colorFFFFFF,
          boxShadow: [
            BoxShadow(
              color:
                  Color(0xff000000).withOpacity(0.08), //TODO: check this color
              blurRadius: 4.r,
              offset: Offset(0, -2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                _buildInkWell('community/community_post_tool/to_photo',
                    PostEditorTooType.photo),
                SizedBox(width: 10.w),
                _buildInkWell('community/community_post_tool/to_topic',
                    PostEditorTooType.topic),
                SizedBox(width: 10.w),
                _buildInkWell(
                    allowKline
                        ? 'community/community_post_tool/to_vote'
                        : 'community/vote_unsel',
                    PostEditorTooType.Kline),
                SizedBox(width: 10.w),
                _buildInkWell('community/community_post_tool/to_inter',
                    PostEditorTooType.inter),
              ],
            ),
            Row(
              children: _buildChildren(onTypeTap),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInkWell(String assetName, PostEditorTooType type,
      {bool isTight = false}) {
    return InkWell(
      child: Padding(
        padding: isTight
            ? EdgeInsets.fromLTRB(0, 2.w, 0, 2.w)
            : EdgeInsets.fromLTRB(1, 5.w, 5.w, 5.w),
        child: MyImage(
          assetName.svgAssets(),
          width: 22.w,
          height: 22.w,
          fit: BoxFit.fitHeight,
        ),
      ),
      onTap: () {
        if (type == PostEditorTooType.bearish) {
          onTypeTap?.call(PostEditorTooType.bullish);
          //看涨
          controller.onBearishTap(onTypeTap);
        } else if (type == PostEditorTooType.bullish) {
          onTypeTap?.call(PostEditorTooType.bearish);
          //看跌
          controller.onBullishTap(onTypeTap);
        } else {
          onTypeTap!(type);
        }
      },
    );
  }

  Widget _buildNewWell(String assetName, bool isRise, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70.w,
        height: 26.w,
        decoration: BoxDecoration(
          color: isRise ? AppColor.colorSuccess : AppColor.colorDanger,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: isRise
              ? [
                  MyImage(
                    assetName.svgAssets(),
                    width: 22.w,
                    height: 22.w,
                    fit: BoxFit.fill,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(LocaleKeys.community52.tr,
                          style: AppTextStyle.f_10_600.colorFFFFFF),
                    ),
                  )
                ]
              : [
                  Expanded(
                    child: Center(
                      child: Text(LocaleKeys.community53.tr,
                          style: AppTextStyle.f_10_600.colorFFFFFF),
                    ),
                  ),
                  MyImage(
                    assetName.svgAssets(),
                    width: 22.w,
                    height: 22.w,
                    fit: BoxFit.fill,
                  ),
                ],
        ),
      ),
    );
  }

  List<Widget> _buildChildren(
      final ValueChanged<PostEditorTooType>? onTypeTap) {
    if (controller.isBearishClicked.value) {
      return [
        _buildNewWell('community/community_post_tool/up_green', true, () {
          controller.onReseTap(onTypeTap);
        }),
      ];
    } else if (controller.isBullishClicked.value) {
      return [
        _buildNewWell('community/community_post_tool/down_red', false, () {
          controller.onReseTap(onTypeTap);
        }),
      ];
    } else {
      return [
        Container(
          width: 74.w,
          height: 26.h,
          decoration: BoxDecoration(
            color: AppColor.colorF5F5F5,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            children: [
              _buildInkWell('community/community_post_tool/to_bearish',
                  PostEditorTooType.bearish,
                  isTight: true),
              _buildInkWell('community/community_post_tool/to_smooth',
                  PostEditorTooType.smooth,
                  isTight: true),
              _buildInkWell('community/community_post_tool/to_bullish',
                  PostEditorTooType.bullish,
                  isTight: true),
            ],
          ),
        ),
      ];
    }
  }
}
