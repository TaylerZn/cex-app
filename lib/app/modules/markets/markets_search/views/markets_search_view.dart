import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_search/widgets/markets_search_list.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_search/widgets/markets_top_view.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_tabbar.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';

import '../controllers/markets_search_controller.dart';

class MarketsSearchView extends GetView<MarketsSearchController> {
  const MarketsSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorWhite,
        appBar: getMarketsTopView(controller),
        body: Obx(() => controller.isSearch.value > 0
            ? Column(
                children: [
                  EntrustTabbar(
                    dataArray: controller.tabs.map((e) => e.value).toList(),
                    controller: controller.tabController,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: controller.searchResArr.map((array) {
                        return Builder(
                          builder: (BuildContext context) {
                            return KeepAliveWrapper(
                                child: MarketsSearchList(
                              array: array,
                            ));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            : MarketsSearchEmptyView(controller: controller)));
  }
}
