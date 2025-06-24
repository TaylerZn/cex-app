import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/long_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_like_icon.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_list_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_more_bottom_dialog.dart';

class BottomAction extends StatefulWidget {
  final TopicdetailModel item;

  const BottomAction({super.key, required this.item});

  @override
  State<BottomAction> createState() => _BottomActionState();
}

class _BottomActionState extends State<BottomAction> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildActionRow('community/graph', widget.item.pageViewNum),
          buildActionRow('community/comment', widget.item.commentNum,
              onTap: () {
            if (Get.find<UserGetx>().goIsLogin()) {
              getCommentDialog(context, widget.item, isDismissible: true)
                  ?.then((value) {
                setState(() {});
              });
            }
          }),
          PostLikeButton(
            item: widget.item,
            key: ValueKey('${widget.item.id}${widget.item.praiseNum}'),
          ),
          buildActionRow('community/quote', widget.item.quoteNum, onTap: () {
            if (UserGetx.to.goIsLogin() && UserGetx.to.isKol) {
              Get.toNamed(Routes.COMMUNITY_POST,
                  arguments: {'quoteId': widget.item.topicNo});
            }
          }),
          buildActionRow('community/share', widget.item.forwardNum, onTap: () {
            postShareBottomDialog(
                uid: widget.item.memberId,
                userName: '${widget.item.memberName ?? '--'}',
                postData: widget.item,
                blockSuccessFun: () {
                  Get.back();
                });
          }),
        ],
      ),
    );
  }

  Widget buildActionRow(String asset, int? value, {Function? onTap}) {
    return InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Row(
          children: [
            MyImage(
              asset.svgAssets(),
              width: 20.w,
            ),
            3.5.horizontalSpace,
            Text(MyLongDataUtil.convert('${value ?? '0'}', showZero: true),
                style: AppTextStyle.f_11_500.colorTextDescription)
          ],
        ));
  }
}
