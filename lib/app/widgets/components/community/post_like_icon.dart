import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/long_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class PostCollectButton extends StatefulWidget {
  final TopicdetailModel item;

  const PostCollectButton({super.key, required this.item});

  @override
  State<PostCollectButton> createState() => _PostCollectButtonState();
}

class _PostCollectButtonState extends State<PostCollectButton> {
  PostLikeIcon? likeIcon;

  likeOnTap() {
    if (widget.item.collectFlag == false) {
      widget.item.collectNum += 1;
    } else {
      widget.item.collectNum -= 1;
    }

    widget.item.collectFlag = !widget.item.collectFlag;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (Get.find<UserGetx>().goIsLogin()) {
          likeOnTap();
          var res = await topiccollectnewOrCancel(
            widget.item.topicNo,
          );
          if (res != true) {
            likeOnTap();
          }
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyImage(
            (widget.item.collectFlag
                    ? 'community/collected'
                    : 'community/collect')
                .svgAssets(),
            width: 16.w,
            height: 16.w,
            color: widget.item.collectFlag ? null : AppColor.color999999,
          ),
          Visibility(
              visible:
                  widget.item.collectNum != null && widget.item.collectNum != 0,
              child: Text(
                MyLongDataUtil.convert('${widget.item.collectNum}')
                    .stringSplit(),
                style: AppTextStyle.f_14_400.color4D4D4D,
              ).marginOnly(left: 4.w))
        ],
      ),
    );
  }
}

class PostLikeButton extends StatefulWidget {
  final dynamic item;
  final MainAxisAlignment? mainAxisAlignment;
  final bool showText;
  final PostLikeType likeType;
  final double? likeIconSize; //图标大小
  final Function(bool)? onTap;

  const PostLikeButton(
      {super.key,
      required this.item,
      this.showText = true,
      this.mainAxisAlignment,
      this.onTap,
      this.likeIconSize,
      this.likeType = PostLikeType.listLike});

  @override
  State<PostLikeButton> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends State<PostLikeButton> {
  PostLikeIcon? likeIcon;

  likeOnTap() {
    if (widget.item.praiseFlag == false) {
      widget.item.praiseNum += 1;
    } else {
      widget.item.praiseNum -= 1;
    }
    widget.item.praiseFlag = !widget.item.praiseFlag;
    setState(() {});
    likeIcon!.showLikeAnim(widget.item.praiseFlag);
    widget.onTap?.call(widget.item.praiseFlag);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: widget.key,
      onTap: () async {
        if (Get.find<UserGetx>().goIsLogin()) {
          likeOnTap();
          var res = await topicpraisenewOrCancel(widget.item.topicNo);
          if (res != true) {
            likeOnTap();
          }
        }
      },
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.end,
        children: [
          Builder(builder: (_) {
            if (likeIcon == null) {
              likeIcon = PostLikeIcon(
                  isLike: widget.item.praiseFlag,
                  likeIconSize: widget.likeIconSize ?? 20.w,
                  key: widget.key,
                  likeType: widget.likeType);
            } else {
              likeIcon!.setIsLike(widget.item.praiseFlag);
            }
            return likeIcon!;
          }),
          if (widget.showText)
            Text(
              MyLongDataUtil.convert('${widget.item.praiseNum}', showZero: true)
                  .stringSplit(),
              style: AppTextStyle.f_11_500.colorTextDescription,
            ).marginOnly(left: 4.w)
        ],
      ),
    );
  }
}

/// 点赞图标
// ignore: must_be_immutable
class PostLikeIcon extends StatefulWidget {
  bool isLike; // 是否喜欢
  double likeIconSize; //图标大小
  PostLikeType likeType;

  PostLikeIcon(
      {super.key,
      this.isLike = false,
      this.likeIconSize = 12,
      this.likeType = PostLikeType.listLike});

  _PostLikeIconState? state;

  /// 开始动画
  void showLikeAnim(bool? isLike) {
    if (state != null) state!._showLikeAnim(isLike);
  }

  /// 设置状态
  void setIsLike(bool? isLike) {
    if (state != null) state!._isLike(isLike);
  }

  @override
  // ignore: no_logic_in_create_state
  State<PostLikeIcon> createState() {
    var test = _PostLikeIconState();
    state = test;
    return test;
  }
}

class _PostLikeIconState extends State<PostLikeIcon>
    with TickerProviderStateMixin {
  bool isBeginAnim = false;
  late AnimationController _likeController;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(
        vsync: this,
        value: widget.isLike ? 1 : 0,
        duration: const Duration(seconds: 1))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isBeginAnim = false;
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    var lottieName = 'assets/json/community/like.json';

    return Lottie.asset(lottieName,
        key: widget.key,
        width: widget.likeIconSize,
        height: widget.likeIconSize,
        // frameRate: const FrameRate(60),
        repeat: false,
        controller: _likeController);
  }

  /// 做点赞动画
  void _showLikeAnim(bool? isLike) {
    if (isLike == null) return;
    widget.isLike = isLike;
    isBeginAnim = true;
    setState(() {});
    if (isLike) {
      _likeController.reset();
      _likeController.forward();
    } else {
      _likeController.reverse(from: 1);
    }
  }

  void _isLike(bool? like) {
    widget.isLike = like ?? false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _likeController.dispose();
    super.dispose();
  }
}

enum PostLikeType { postLike, videoPostLike, listLike }
