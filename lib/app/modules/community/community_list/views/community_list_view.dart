import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/controllers/community_list_controller.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/post_list_row.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityListView extends GetView<CommunityListController> {
  const CommunityListView(
      {super.key, required this.tagKey, this.isFromFollowName = ''});

  final String tagKey;
  final String isFromFollowName;

  @override
  // TODO: implement tag
  String? get tag => ObjectUtil.isNotEmpty(tagKey)
      ? tagKey
      : TagCacheUtil().getTag('CommunityListController');

  @override
  Widget build(BuildContext context) {
    return isFromFollowName.isNotEmpty
        ? GetBuilder<CommunityListController>(
            tag: tag,
            builder: (controller) {
              return controller.recommendList.isNotEmpty
                  ? SliverMainAxisGroup(slivers: [
                      SliverToBoxAdapter(
                          child: Column(
                        children: [
                          Container(height: 8.w, color: AppColor.colorF1F1F1),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 8.w),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    isFromFollowName,
                                    style: AppTextStyle.f_15_600.tradingYel,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(LocaleKeys.follow465.tr,
                                    style: AppTextStyle.f_15_600.color111111),
                              ],
                            ),
                          ),
                        ],
                      )),
                      SliverList.builder(
                        itemCount: controller.recommendList.length,
                        itemBuilder: (context, index) {
                          return PostListRow(
                            controller: controller,
                            onRefresh: (action, model) {
                              controller.reloadList(action, model);
                            },
                            item: index >= controller.recommendList.length
                                ? TopicdetailModelWrapper(TopicdetailModel(),
                                    type: TopicdetailModelType.none)
                                : controller.recommendList[index],
                          );
                        },
                      )
                    ])
                  : const SliverToBoxAdapter(child: SizedBox());
            })
        : Scaffold(
            // floatingActionButton: Obx(() =>  AnimatedOpacity(
            //     opacity: !MyCommunityUtil.showAction.value ? 1 : 0,
            //     duration: Duration(milliseconds: 500),
            //     child: InkWell(
            //       onTap: () {
            //         Get.find<CommunityListController>(tag: tag)
            //             .scrollController
            //             .jumpTo(0);
            //       },
            //       child: Container(
            //         margin: EdgeInsets.only(bottom: 5.w, right: 10.w),
            //         width: 38.w,
            //         height: 38.h,
            //
            //         child: MyImage('community/top'.svgAssets()),
            //       ),
            //     ))),
            // floatingActionButtonAnimator: ScalingCustomAnimation(),
            // floatingActionButtonLocation: CustomFloatingActionButtonLocation(
            //     FloatingActionButtonLocation.endFloat, 0, 5.h),
            body: GetBuilder<CommunityListController>(
                tag: tag,
                builder: (controller) {
                  return SmartRefresher(
                      controller: controller.refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      scrollController: controller.scrollController,
                      onRefresh: () async {
                        controller.recommendPages = 1;
                        controller.recommendTotalPages = 1;
                        controller.getRecommendList();
                        controller.refreshController.refreshCompleted();
                        controller.refreshController.loadComplete();
                      },
                      onLoading: () async {
                        if (controller.recommendTotalPages <=
                            controller.recommendPages) {
                          controller.refreshController.loadNoData();
                        } else {
                          controller.recommendPages =
                              controller.recommendPages + 1;
                          await controller.getRecommendList();

                          controller.refreshController.loadComplete();
                        }
                      },
                      child: MyPageLoading(
                          controller: controller.loadingController,
                          onEmpty: noDataWidget(context, wigetHeight: 400.w),
                          body: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: tag!.contains('CommunityListController'),
                            itemCount: controller.recommendList.length,
                            itemBuilder: (context, index) {
                              return PostListRow(
                                controller: controller,
                                onRefresh: (action, model) {
                                  controller.reloadList(action, model);
                                },
                                item: index >= controller.recommendList.length
                                    ? TopicdetailModelWrapper(
                                        TopicdetailModel(),
                                        type: TopicdetailModelType.none)
                                    : controller.recommendList[index],
                              );
                            },
                          )));
                }));
  }

  Widget buildOption(CommunityListController controller) {
    Widget buildAvatar() {
      return InkWell(
        onTap: () {
          // var model = FollowKolInfo()..uid = UserGetx.to.uid as num;
          Get.toNamed(Routes.FOLLOW_TAKER_INFO,
              arguments: {'uid': UserGetx.to.uid, 'isSelf': true});
        },
        child: Container(
            width: 40.h,
            height: 40.h,
            child: UserAvatar(
              UserGetx.to.avatar,
              width: 40.w,
              height: 40.h,
              isTrader: UserGetx.to.isKol,
              tradeIconSize: 15.w,
            )),
      );
    }

    Widget buildPost() {
      return InkWell(
          onTap: () {
            Get.toNamed(Routes.COMMUNITY_POST);
          },
          child: Container(
            width: 40.h,
            height: 40.h,
            decoration: BoxDecoration(
                color: AppColor.colorFFD429,
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyImage(
                  'community/plus'.svgAssets(),
                  width: 16.w,
                  height: 16.w,
                )
              ],
            ),
          ));
    }

    Widget buildNotif() {
      return InkWell(
          onTap: () {
            // Get.toNamed(Routes.COMMUNITY_MESSAGE); 后期再修改,复用首页的方案
            if (UserGetx.to.goIsLogin()) {
              Get.toNamed(Routes.NOTIFY, arguments: {'messageType': 10});
              UserGetx.to.messageUnreadCount = 0;
              UserGetx.to.update();
            }
          },
          child: SizedBox(
            width: 40.h,
            height: 40.h,
            child: MyImage(
              'community/comnotif1'.svgAssets(),
            ),
          ));
    }

    if (!UserGetx.to.isKol) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: controller.isSendExpand ? 132.h : 0,
        child: Column(
          children: [
            buildAvatar(),
            16.verticalSpace,
            buildNotif(),
            16.verticalSpace,
          ],
        ),
      );
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: controller.isSendExpand ? 187.h : 0,
      child: Column(
        children: [
          buildAvatar(),
          16.verticalSpace,
          buildNotif(),
          16.verticalSpace,
          buildPost(),
          16.verticalSpace,
        ],
      ),
    );
  }
}
