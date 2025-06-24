import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/b2c/order_history/controllers/order_history_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/b2c/order_history/widgets/order_history_item.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class B2cOrderHistoryView extends GetView<B2cOrderHistoryController> {
  const B2cOrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<B2cOrderHistoryController>(
            init: B2cOrderHistoryController(),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  leading: const MyPageBackWidget(),
                  title: Text(LocaleKeys.b2c12.tr),
                  centerTitle: true,
                ),
                body: controller.pageObx(
                  (state) {
                    return SmartRefresher(
                      controller: controller.refreshController,
                      onRefresh: () => controller.refreshData(true),
                      onLoading: controller.loadMoreData,
                      enablePullUp: true,
                      enablePullDown: true,
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: state?.length ?? 0,
                        itemBuilder: (context, index) {
                          return B2cOrderHistoryItem(
                            item: state![index],
                          );
                        },
                      ),
                    );
                  },
                  onRetryRefresh: () => controller.refreshData(false),
                ),
              );
            }));
  }
}
