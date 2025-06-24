import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/index.dart';
import 'package:nt_app_flutter/app/modules/community/hot_detail_topic/controllers/hot_list_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_appbar_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
// import 'package:nt_app_flutter/app/widgets/basic/my_appbar_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../widgets/basic/my_image.dart';
import '../controllers/hot_detail_topic_controller.dart';

class HotDetailTopicView extends GetView<HotDetailTopicController> {
  const HotDetailTopicView({Key? key}) : super(key: key);

  @override
  // TODO: implement tag
  String? get tag => TagCacheUtil().getTag('HotDetailTopicController');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HotDetailTopicController>(
        tag: tag,
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                buildTabbar(),
                Container(
                  height: 1,
                  color: AppColor.colorECECEC,
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      KeepAliveWrapper(
                          child:
                              listContent('${tag}hot', controller.model?.name)),
                      KeepAliveWrapper(
                          child:
                              listContent('${tag}new', controller.model?.name))
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget listContent(String tag, String? keyword) {
    return GetBuilder<HotListController>(
        tag: tag,
        init: HotListController(tag, keyword),
        builder: (HotListController controller) {
          return controller.pageObx(
            (state) {
              return SmartRefresher(
                controller: controller.refreshController,
                onRefresh: () => controller.refreshData(true),
                onLoading: controller.loadMoreData,
                enablePullUp: true,
                enablePullDown: true,
                child: ListView.builder(
                  itemCount: state?.length,
                  itemBuilder: (BuildContext c, int i) {
                    return CommunityItemRow(
                      item: state![i],
                    );
                  },
                ),
              );
            },
            onRetryRefresh: () => controller.refreshData(false),
          );
        });
  }

  Widget buildHeader() {
    return Container(
        height: 180.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xffFF891C).withOpacity(0.1),
                const Color(0xffFF891C).withOpacity(0)
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 44.w,
            ),
            SizedBox(
              height: 44.w,
              child: const Row(
                children: [MyPageBackWidget()],
              ),
            ),
            8.verticalSpaceFromWidth,
            Column(
              children: [
                Row(
                  children: [
                    MyImage(
                      'community/hot_topic0'.svgAssets(),
                      width: 24.w,
                      height: 24.w,
                      fit: BoxFit.fill,
                    ),
                    8.horizontalSpace,
                    Expanded(
                        child: Text('${controller.model?.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.f_20_600.colorTextPrimary))
                  ],
                ),
                8.verticalSpaceFromWidth,
                Row(
                  children: [
                    if (controller.model?.sort != null)
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Text('TOP${controller.model?.sort ?? ''}',
                            style: AppTextStyle.f_14_600.colorTextSecondary),
                      ),
                    Text(
                        '${controller.model?.pageViewNum ?? '--'} ${LocaleKeys.community105.tr}', //浏览量',
                        style: AppTextStyle.f_12_400.colorTextTips),
                    10.horizontalSpace,
                    Text(
                        '${controller.model?.quoteNum ?? '--'} ${LocaleKeys.community106.tr}', //帖子',
                        style: AppTextStyle.f_12_400.colorTextTips),
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 16.w)
          ],
        ));
  }

  Widget buildTabbar() {
    return SizedBox(
      height: 38.w,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: true,
        indicatorColor: AppColor.colorTextPrimary,
        indicator: MyUnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.h,
            color: AppColor.color111111,
          ),
        ),
        unselectedLabelStyle: AppTextStyle.f_14_500.colorTextDisabled,
        labelStyle: AppTextStyle.f_14_500.colorTextPrimary,
        tabs: [
          Tab(text: LocaleKeys.community81.tr), //'热门'),
          Tab(text: LocaleKeys.community107.tr), //'最新内容'),
        ],
      ),
    );
  }
}
