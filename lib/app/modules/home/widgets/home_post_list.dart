import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../getX/user_Getx.dart';
import '../../../widgets/feedback/page_loading.dart';
import '../../../widgets/no/no_data.dart';
import '../../community/community_list/controllers/community_list_controller.dart';
import '../../community/community_list/widgets/post_list_row.dart';
import '../controllers/home_index_controller.dart';

class HomePostList extends StatefulWidget {
  ScrollPhysics physics;

  HomePostList({super.key, required this.physics});

  @override
  State<HomePostList> createState() => _HomePostListState();
}

class _HomePostListState extends State<HomePostList>
    with SingleTickerProviderStateMixin {
  HomeIndexController homeIndexController = Get.find();

  @override
  Widget build(BuildContext context) {
    return _tabBarView();
  }

  _tabBarView() {
    return GetBuilder<HomeIndexController>(builder: (controller) {
      return TabBarView(
        controller: homeIndexController.tabController,
        children: [
          SmartRefresher(
            controller: controller.tabViewRefreshController,
            enablePullDown: false,
            enablePullUp: true,
            onLoading: () async {
              controller.getOnLoading();
            },
            child: CustomScrollView(
              physics: widget.physics,
              slivers: [
                SliverList.builder(
                    itemCount: controller.recommendList.length,
                    itemBuilder: (context, index) {
                      TopicdetailModelWrapper? item = controller.recommendList.safe(index);
                      if(item == null) return 0.verticalSpaceFromWidth;
                      return PostListRow(
                        isHome: true,
                        item: item,
                        onRefresh: (action, model) {
                          controller.getPostList();
                        },
                      );
                    })
              ],
            ),
          ),
          if (UserGetx.to.isLogin)
            GetBuilder<CommunityListController>(
              tag: 'Market2',
              init: CommunityListController(tagKey: 'Market2'),
              builder: (controller) {
                return MyPageLoading(
                  controller: controller.loadingController,
                  onEmpty: noDataWidget(context, wigetHeight: 400.w),
                  body: CustomScrollView(
                    physics: widget.physics,
                    slivers: [
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
                    ],
                  ),
                );
              },
            ),
        ],
      );
    });
  }
}
