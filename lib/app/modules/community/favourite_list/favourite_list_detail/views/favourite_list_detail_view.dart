import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/index.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/favourite_list_detail_controller.dart';

class FavouriteListDetailView extends GetView<FavouriteListDetailController> {
  String? tagKey = '';
  FavouriteListDetailView({this.tagKey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteListDetailController>(
        init: FavouriteListDetailController(tag: tagKey ?? ''),
        tag: tagKey,
        builder: (controller) {
          controller = Get.find<FavouriteListDetailController>(
              tag: tagKey); //.login(user);
          return controller.pageObx(
            (state) {
              return SmartRefresher(
                controller: controller.refreshController,
                onRefresh: () => controller.refreshData(false),
                onLoading: controller.loadMoreData,
                enablePullUp: true,
                enablePullDown: true,
                child: ListView.builder(
                  itemCount: state?.length ?? 0,
                  itemBuilder: (context, index) {
                 //   return Container(color: Colors.red, height: 100, margin: EdgeInsets.only(bottom: 10));
                    return KeepAliveWrapper(child: CommunityItemRow(item: state?[index],onRefresh: (action,model){
                      controller.refreshData(false);
                    }));
                  },
                ),
              );
            },
            onRetryRefresh: () => controller.refreshData(false),
          );
        });
  }
}
