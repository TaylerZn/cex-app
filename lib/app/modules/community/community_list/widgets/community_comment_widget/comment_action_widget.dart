import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_like_icon.dart';

class CommentActionWidget extends StatefulWidget {
  final Function()? onTap;
  final CommunityCommentItem item;
  const CommentActionWidget({super.key, required this.item, this.onTap});

  @override
  State<CommentActionWidget> createState() => _CommentActionWidgetState();
}

class _CommentActionWidgetState extends State<CommentActionWidget> {
  PostLikeIcon? likeIcon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> checkComment() async {
    await isCommentLike(widget.item.commentNo);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            child: SizedBox(
              width: 20.w,
              height: 20.w,
              child: Row(
                children: [
                  MyImage(
                    'community/comment'.svgAssets(),
                    width: 16.w,
                    height: 16.w,
                    color: AppColor.colorTextDescription,
                  )
                ],
              ),
            )),
        16.horizontalSpace,
        InkWell(
          onTap: () async {
            if (UserGetx.to.goIsLogin()) {
              var res = await likeComment(widget.item.commentNo ?? '');
              if (res) {
                if (widget.item.praiseFlag == false) {
                  widget.item.praiseNum = (widget.item.praiseNum ?? 0) + 1;
                } else {
                  widget.item.praiseNum = (widget.item.praiseNum ?? 1) - 1;
                }

                widget.item.praiseFlag = !(widget.item.praiseFlag ?? false);
                setState(() {});
                likeIcon!.showLikeAnim(widget.item.praiseFlag);
              }
            }
          },
          child: Row(
            children: [
              SizedBox(
                width: 4.w,
              ),
              Builder(builder: (_) {
                if (likeIcon == null) {
                  likeIcon = PostLikeIcon(
                    isLike: widget.item.praiseFlag ?? false,
                    likeIconSize: 16.w,
                    likeType: PostLikeType.postLike,
                  );
                } else {
                  likeIcon!.setIsLike(widget.item.praiseFlag);
                }
                return likeIcon!;
              }),
              2.horizontalSpace,
              Text('${widget.item.praiseNum ?? 0}',
                  style: AppTextStyle.f_12_400.colorTextDescription),
            ],
          ),
        ),
      ],
    );
  }
}
