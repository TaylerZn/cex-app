import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_my_star/controllers/follow_my_star_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_block/model/follow_kol_relation.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowMyStarList extends StatelessWidget {
  const FollowMyStarList({
    super.key,
    required this.list,
    required this.controller,
  });

  final List<FollowkolRelationList> list;

  final FollowMyStarController controller;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshVc,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async {
        await controller.getData(isPullDown: true);
        controller.refreshVc.refreshToIdle();
        controller.refreshVc.loadComplete();
      },
      onLoading: () async {
        if (controller.model.value.haveMore) {
          controller.model.value.page++;
          await controller.getData();
          controller.refreshVc.loadComplete();
        } else {
          controller.refreshVc.loadNoData();
        }
      },
      child: CustomScrollView(slivers: [
        SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            sliver: SliverList.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var model = list[index];
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.userId});
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            UserAvatar(
                              model.icon,
                              width: 40.w,
                              height: 40.w,
                              levelType: model.levelType,
                              isTrader: true,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(model.name, style: AppTextStyle.f_15_500.color111111),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(model.startStr, style: AppTextStyle.f_12_500.color333333),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                    Text(LocaleKeys.follow160.tr, style: AppTextStyle.f_12_400.color999999)
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        MyImage('default/go'.svgAssets(), color: AppColor.color111111, height: 12.h)
                      ],
                    ),
                  ),
                );
              },
            ))
      ]),
    );
  }
}
