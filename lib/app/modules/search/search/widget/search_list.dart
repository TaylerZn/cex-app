import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_home_traker/widget/follow_orders_cell.dart';
import 'package:nt_app_flutter/app/modules/search/search/controllers/search_index_controller.dart';
import 'package:nt_app_flutter/app/modules/search/search/model/search_enum.dart';
import 'package:nt_app_flutter/app/modules/search/search/widget/search_view.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_list_widget.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.type, required this.controller, required this.model});
  final SearchResultsType type;
  final SearchIndexController controller;
  final SearchResultsModel model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchIndexController>(builder: (controller) {
      return MyPageLoading(
          controller: model.loadingController,
          body: SmartRefresher(
              controller: model.refreshVc,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () async {
                model.page = 1;
                await controller.getListData();
                model.refreshVc.refreshToIdle();
              },
              onLoading: () async {
                if (model.haveMore) {
                  model.page++;
                  await controller.getListData();
                  model.refreshVc.loadComplete();
                } else {
                  model.refreshVc.loadNoData();
                }
              },
              child: getBody(context)));
    });
  }

  Widget getBody(context) {
    switch (type) {
      case SearchResultsType.all:
        return getAllView(context);
      case SearchResultsType.contract:
        return CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
                padding: EdgeInsets.only(top: 10.h),
                sliver: SearchGroupContractList(
                  list: controller.contractList,
                )),
          ],
        );
      case SearchResultsType.spot:
        return CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
                padding: EdgeInsets.only(top: 10.h),
                sliver: SearchGroupMarketList(
                  list: controller.spotsList,
                )),
          ],
        );
      case SearchResultsType.community:
        return WaterfallFlow.builder(
          padding: const EdgeInsets.all(0),
          itemCount: controller.topicsList.length,
          gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 0.w,
            mainAxisSpacing: 0.h,
          ),
          itemBuilder: (context, i) {
            return postListWidget(context, controller.topicsList[i]);
          },
        );
      case SearchResultsType.trader:
        return CustomScrollView(
          slivers: <Widget>[FollowOrdersList(list: controller.traderList)],
        );
      case SearchResultsType.functiontype:
        return CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var item = controller.functionsList[index];
                  return InkWell(
                      onTap: () {
                        if (item.nativeUrl != null) {
                          Get.toNamed(item.nativeUrl!);
                        }
                      },
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 44.w,
                                height: 44.w,
                                margin: EdgeInsets.only(right: 10.w),
                                decoration: const ShapeDecoration(
                                    shape: OvalBorder(
                                  side: BorderSide(width: 1, color: AppColor.colorF1F1F1),
                                )),
                                alignment: Alignment.center,
                                child: MyImage(
                                  '${item.imageUrl}',
                                )),
                            Text('${item.title}', style: AppTextStyle.f_16_500.color111111)
                          ],
                        ),
                      ));
                },
                childCount: controller.functionsList.length,
              ),
            )
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget getAllView(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        getFunctionView(),
        getContractView(),
        getSpotView(),
        getCommunityView(),
        getTraderView(),
        getPaddingView(context)
      ],
    );
  }

  getFunctionView() {
    return controller.functionsList.isNotEmpty
        ? SliverToBoxAdapter(
            child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: Wrap(
              spacing: 16.w,
              runSpacing: 6.h,
              children: List.generate(controller.functionsList.length, (index) {
                var item = controller.functionsList[index];
                return InkWell(
                  onTap: () {
                    if (item.nativeUrl != null) {
                      Get.toNamed(item.nativeUrl!);
                    }
                  },
                  child: Container(
                      width: 163.w,
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 8.w, 13.h),
                      decoration: ShapeDecoration(
                        color: AppColor.colorF4F4F4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MyImage(
                            '${item.imageUrl}',
                            width: 24.w,
                            height: 24.w,
                          ).marginOnly(bottom: 11.h),
                          Text('${item.title}', style: AppTextStyle.f_15_500.color111111)
                        ],
                      )),
                );
              }),
            ),
          ))
        : SliverToBoxAdapter(child: 0.verticalSpace);
  }

  getContractView() {
    return SearchGroupList(
      title: LocaleKeys.public36.tr,
      controller: controller,
      contractList: controller.contractList,
      searchText: controller.searchText,
    );
  }

  getSpotView() {
    return SearchGroupList(
      title: LocaleKeys.public37.tr,
      controller: controller,
      spotsList: controller.spotsList,
      searchText: controller.searchText,
    );
  }

  getCommunityView() {
    return SearchGroupList(
      title: LocaleKeys.public38.tr,
      controller: controller,
      topicsList: controller.topicsList,
    );
  }

  getTraderView() {
    return SearchGroupList(
      title: LocaleKeys.public39.tr,
      controller: controller,
      traderList: controller.traderList,
    );
  }

  getPaddingView(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom));
  }
}
