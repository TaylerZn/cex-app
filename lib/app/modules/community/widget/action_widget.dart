import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';

import '../../../getX/user_Getx.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/basic/my_image.dart';
import '../../../widgets/components/user_avatar.dart';

class CommunityActionWidget extends StatefulWidget {
  const CommunityActionWidget({super.key});

  @override
  State<CommunityActionWidget> createState() => CommunityActionWidgetState();
}

class CommunityActionWidgetState extends State<CommunityActionWidget>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  LottieComposition? composition;
  bool isSendExpand = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() => MyCommunityUtil.showSocialMenu.value
        ? SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    dismiss();
                  },
                  child: Container(
                    color: isSendExpand ? Colors.black.withOpacity(0.5) : null,
                  ),
                ),
                Positioned(
                    right: 16.w,
                    bottom: 100.w,
                    child: Container(
                        width: 50, height: 56.w * 4, child: content()))
              ],
            ),
          )
        : const SizedBox());
  }

  void dismiss() {
    setState(() {
      if (isSendExpand) {
        isSendExpand = false;
      }
    });
  }

  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildOption(),
        InkWell(
          onTap: () {
            setState(() {
              isSendExpand = !isSendExpand;
            });
          },
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: MyImage(
              isSendExpand
                  ? 'community/community_close_expand'.svgAssets()
                  : 'community/community_option'.svgAssets(),
              width: 44.w,
              height: 44.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAvatar() {
    return InkWell(
      onTap: () {
        // var model = FollowKolInfo()..uid = UserGetx.to.uid as num;
        dismiss();
        Get.toNamed(Routes.FOLLOW_TAKER_INFO,
            arguments: {'uid': UserGetx.to.uid, 'isSelf': true});
      },
      child: UserAvatar(
        UserGetx.to.avatar,
        width: 40.w,
        height: 40.w,
        isTrader: UserGetx.to.isKol,
        tradeIconSize: 15.w,
      ),
    );
  }

  Widget buildPost() {
    return InkWell(
        onTap: () {
          dismiss();
          Get.toNamed(Routes.COMMUNITY_POST);
        },
        child: MyImage(
          'community/community_option'.svgAssets(),
          width: 44.w,
          height: 44.w,
        ));
  }

  Widget buildNotif() {
    return InkWell(
        onTap: () {
          // Get.toNamed(Routes.COMMUNITY_MESSAGE); 后期再修改,复用首页的方案
          if (UserGetx.to.goIsLogin()) {
            Get.toNamed(Routes.COMMUNITY_NOTIFY,
                arguments: {'messageType': 10});
            UserGetx.to.messageUnreadCount = 0;
            UserGetx.to.update();
            dismiss();
          }
        },
        child: ClipOval(
          child: MyImage(
            'community/comnotif1'.svgAssets(),
            width: 44.w,
            height: 44.w,
          ),
        ));
  }

  Widget buildOption() {
    if (!UserGetx.to.isKol) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: isSendExpand ? 116.w : 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildAvatar(),
              16.verticalSpace,
              buildNotif(),
              16.verticalSpace,
            ],
          ),
        ),
      );
    }

    return AnimatedContainer(
      color: Colors.transparent,
      duration: const Duration(milliseconds: 400),
      height: isSendExpand ? 176.w : 0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildAvatar(),
            16.verticalSpaceFromWidth,
            buildNotif(),
            16.verticalSpaceFromWidth,
            buildPost(),
          ],
        ),
      ),
    );
  }
}
