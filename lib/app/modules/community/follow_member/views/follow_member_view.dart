import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/focus.dart';
import 'package:nt_app_flutter/app/modules/community/follow_member/controllers/member_list.dart';
import 'package:nt_app_flutter/app/modules/community/widget/follow_widget.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../widgets/basic/my_tab_underline_widget.dart';
import '../controllers/follow_member_controller.dart';

class FollowMemberView extends GetView<FollowMemberController> {
  const FollowMemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? uid = '${DateTime.now().millisecondsSinceEpoch}';
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments?['name'] ?? LocaleKeys.community108.tr),

        ///'关注列表'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: controller.viewType.followTab.length > 1
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 37.h,
            child: buildTabbar(),
          ),
          Container(height: 1, color: AppColor.colorEEEEEE),
          Expanded(
              child: TabBarView(
                  controller: controller.tabController,
                  children: controller.viewType.followTab
                      .map((e) => buildListContent('${e.key()}${uid}'))
                      .toList()
                  // children: [
                  //   buildListContent('follow'),
                  //   buildListContent('follower')
                  // ],
                  ))
        ],
      ),
    );
  }

  Widget buildListContent(String tag) {
    return KeepAliveWrapper(
        child: GetBuilder<FollowMemberListController>(
      tag: tag,
      builder: (controller) {
        return controller.pageObx(
          (state) {
            return SmartRefresher(
              controller: controller.refreshController,
              onRefresh: () => controller.refreshData(true),
              onLoading: controller.loadMoreData,
              enablePullUp: false,
              enablePullDown: false,
              child: ListView.builder(
                  itemCount: state?.length,
                  itemBuilder: (context, index) {
                    TopicFocusListModel? model = state?[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            MyCommunityUtil.pushToUserInfo(model?.uid);
                          },
                          child: Container(
                              height: 76.h,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      UserAvatar(model?.pictureUrl),
                                      10.horizontalSpace,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(model?.nickName ?? '--'),
                                          4.verticalSpace,
                                          Visibility(
                                              visible: model?.isKol == 1,
                                              child: Row(
                                                children: [
                                                  Text('${model?.focusNum}',
                                                      style: AppTextStyle
                                                          .f_11_600),
                                                  4.horizontalSpace,
                                                  Text(
                                                      LocaleKeys.community109
                                                          .tr, //'关注者',
                                                      style: AppTextStyle
                                                          .f_11_600
                                                          .color999999),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                      visible: model?.uid != UserGetx.to.uid &&
                                          model?.isKol == 1,
                                      child: FollowWidget(
                                          isFollow: model?.followStatus == 1,
                                          onTap: () async {
                                            TopicdetailModel item =
                                                TopicdetailModel(
                                                    memberId: model?.uid,
                                                    focusOn:
                                                        model?.followStatus ==
                                                            1);
                                            if (await socialsocialfollowfollow(
                                                item)) {
                                              model?.followStatus =
                                                  model.followStatus == 0
                                                      ? 1
                                                      : 0;
                                              controller.update();
                                            }
                                            // if (await socialFollow(
                                            //     model?.followStatus == 1,
                                            //     model?.uid?.toInt())) {
                                            //   model?.followStatus =
                                            //       model.followStatus == 0
                                            //           ? 1
                                            //           : 0;
                                            //   // controller.refreshData(false);
                                            //   controller.update();
                                            // }
                                          })),
                                ],
                              )),
                        ),
                        Container(
                          height: 1,
                          color: AppColor.colorEEEEEE,
                        )
                      ],
                    );
                  }),
            );
          },
          onRetryRefresh: () => controller.refreshData(false),
        );
      },
      init: FollowMemberListController(tag),
    ));
  }

  Widget buildTabbar() {
    return TabBar(
      controller: controller.tabController,
      isScrollable: true,
      indicatorColor: AppColor.color111111,
      indicator: MyUnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.h,
          color: AppColor.color111111,
        ),
      ),
      unselectedLabelStyle: AppTextStyle.f_15_400.colorABABAB,
      labelStyle: AppTextStyle.f_15_400,
      tabs: controller.viewType.followTab.map((e) => Text(e.title())).toList(),
    );
  }
}
