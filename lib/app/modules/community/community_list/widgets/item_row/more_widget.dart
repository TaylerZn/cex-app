import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/widget/more_dialog.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../../../generated/locales.g.dart';

class CommunityMoreWidget extends StatelessWidget {
  final TopicdetailModel? model;
  final Function(MoreActionType) callback;
  final bool isPost;
  final String? commentId;
  final bool? topFlag;
  final Color color;
  final bool secondLevel; //二级评论
  final double size;

  const CommunityMoreWidget({
    super.key,
    required this.model,
    required this.callback,
    required this.size,
    this.secondLevel = false,
    this.commentId,
    this.isPost = true,
    this.color = AppColor.colorABABAB,
    this.topFlag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
            context: Get.context!,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (BuildContext context) {
              return MoreDialog(
                  memberId: model!.memberId.toString(),
                  secondLevel: secondLevel,
                  topTitle: topFlag == true
                      ? LocaleKeys.community100.tr
                      : LocaleKeys.community8.tr,
                  //? '从个人资料中取消置顶' : '置顶' ,
                  favouriteIcon: model?.collectFlag == true
                      ? 'community/star'.svgAssets()
                      : 'community/favorite'.svgAssets(),
                  topIcon: model?.topFlag == true
                      ? 'community/remove_top'.svgAssets()
                      : 'community/settop'.svgAssets(),
                  favouriteTitle: model?.collectFlag == true
                      ? LocaleKeys.community94.tr
                      : LocaleKeys.community31.tr,
                  //? '已收藏' : '收藏'
                  isPost: isPost,
                  commentId: commentId,
                  onTap: (action) {
                    Get.back();
                    callback.call(action);
                  });
            },
          );
        },
        child: MyImage(
          'community/more'.svgAssets(),
          height:size,
          width: size,
          fit: BoxFit.fill,
          color: color,
        ));
  }
}
