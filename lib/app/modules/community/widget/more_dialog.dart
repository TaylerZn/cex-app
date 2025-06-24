import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/theme/app_color.dart';

enum MoreActionType {
  delete,
  pinTop,
  block,
  share,
  refresh,
  like,
  favourite;

  const MoreActionType();

  String title() {
    switch (this) {
      // TODO: Handle this case.
      case MoreActionType.delete:
        return LocaleKeys.community11.tr;
      // TODO: Handle this case.
      case MoreActionType.pinTop:
        return '从个人资料中取消置顶';
      // TODO: Handle this case.
      case MoreActionType.block:
        return LocaleKeys.community13.tr; // '拉黑';
      // TODO: Handle this case.
      case MoreActionType.share:
        return LocaleKeys.community12.tr;
      // TODO: Handle this case.
      case MoreActionType.favourite:
        return LocaleKeys.community31.tr;
      default:
        return '';
      // TODO: Handle this case.
    }
    return '';
  }

  String icon() {
    switch (this) {
      // TODO: Handle this case.
      case MoreActionType.delete:
        return 'community/trash'.svgAssets();
      // TODO: Handle this case.
      case MoreActionType.pinTop:
        return 'community/settop'.svgAssets();
      // TODO: Handle this case.
      case MoreActionType.block:
        return 'community/block'.svgAssets();
      // TODO: Handle this case.
      case MoreActionType.share:
        return 'community/share1'.pngAssets();
      // TODO: Handle this case.
      case MoreActionType.favourite:
        return 'community/favorite'.svgAssets();
      default:
        return '';
      // TODO: Handle this case.
    }
    return '';
  }
}

enum MoreListType {
  selfPostComment, //自己帖子自己评论
  otherPostSelfComment, //别人帖子自己评论
  selfPostOtherComment, //自己帖子别人评论
  otherPostOtherComment //别人帖子别人评论
}

class MoreDialog extends StatefulWidget {
  final String memberId;
  final bool isPost;
  final Function(MoreActionType) onTap;
  final String? commentId;
  final String? favouriteTitle;
  final String? favouriteIcon;
  final String? topIcon;
  final String? topTitle;
  final bool secondLevel; //二级评论

  const MoreDialog(
      {super.key,
      required this.memberId,
      this.favouriteTitle,
      this.favouriteIcon,
      this.topTitle,
      required this.onTap,
      this.commentId,
      this.topIcon,
      this.secondLevel = false,
      this.isPost = true});

  @override
  State<MoreDialog> createState() => _MoreDialogState();
}

class _MoreDialogState extends State<MoreDialog> {
  Widget buildContent() {
    bool isSelf = widget.memberId == '${UserGetx.to.uid}';
    bool selfComment = widget.commentId == '${UserGetx.to.uid}';
    List<MoreActionType> type = [];
    if (widget.isPost) {
      type = [MoreActionType.favourite, MoreActionType.share];

      if (isSelf) {
        type.add(MoreActionType.delete);
        if (UserGetx.to.isKol) {
          type.insert(0, MoreActionType.pinTop);
        }
      } else {
        type.add(MoreActionType.block);
      }
    } else {
      if (isSelf) {
        type = [MoreActionType.delete];
        if (!widget.secondLevel) {
          type.insert(0, MoreActionType.pinTop);
        }
        if (!selfComment) {
          type = [
            MoreActionType.pinTop,
            MoreActionType.delete,
            MoreActionType.block
          ];
        }
      } else {
        if (selfComment) {
          type = [MoreActionType.delete];
        } else {
          type = [MoreActionType.block];
        }
      }
    }
    return Column(
      children: type
          .map((e) => Container(
                margin: EdgeInsets.only(bottom: 16.h),
                child: InkWell(
                    onTap: () {
                      widget.onTap.call(e);
                    },
                    child: buildAction(buildIcon(e), buildTitle(e),
                        isRed: e == MoreActionType.delete)),
              ))
          .toList(),
    );
  }

  String buildIcon(MoreActionType e) {
    switch (e) {
      case MoreActionType.favourite:
        return widget.favouriteIcon ?? e.icon();
      case MoreActionType.pinTop:
        return widget.topIcon ?? e.icon();
      default:
        return e.icon();
    }
  }

  String buildTitle(MoreActionType e) {
    switch (e) {
      case MoreActionType.favourite:
        return widget.favouriteTitle ?? e.title();
      case MoreActionType.pinTop:
        return widget.topTitle ?? e.title();
      default:
        return e.title();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
          color: AppColor.colorFFFFFF),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          35.verticalSpace,
          buildContent(),
          // buildAction('community/settop'.svgAssets(), '置顶'),
          // 16.verticalSpace,
          // buildAction('community/trash'.svgAssets(), '删除', isRed: true),
          // 16.verticalSpace,
          // buildAction('community/block'.svgAssets(), '拉黑'),
          30.verticalSpace
        ],
      ),
    );
  }

  Widget buildAction(String icon, String title, {bool isRed = false}) {
    return Row(
      children: [
        SizedBox(
            width: 36.w,
            child: MyImage(
              icon,
              width: 36.w,
              height: 36.h,
            )),
        4.horizontalSpace,
        Text(title,
            style: isRed
                ? AppTextStyle.f_16_500.colorDanger
                : AppTextStyle.f_16_500)
      ],
    );
  }
}
