import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_commondity/controllers/swap_commodity_all_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_commondity/widgets/commdity_tab_bar.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_commondity/widgets/commodity_stock_tab_widget.dart';

import '../../../../../generated/locales.g.dart';
import '../widgets/commodity_list_view.dart';

class SwapCommodityAllView extends StatelessWidget {
  const SwapCommodityAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SwapCommodityAllController>(
      builder: (logic) {
        return Column(
          children: [
            CommodityTabbar(
              dataArray: logic.tabs,
              controller: logic.tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: logic.tabController,
                children: logic.contractGroupList.asMap().entries.map((e) {
                  ContractGroupList contractGroupList =
                      CommodityDataStoreController.to.contractGroupList[e.key];

                  /// 股票有二级分组
                  if (contractGroupList.kind == 'B_1') {
                    List<ContractInfo> all =
                        contractGroupList.contractList ?? [];
                    List<ContractInfo> usList = contractGroupList.contractList
                            ?.where((element) => element.market == 'STOCK-US')
                            .toList() ??
                        [];
                    List<ContractInfo> hkList = contractGroupList.contractList
                            ?.where((element) => element.market == 'STOCK-HK')
                            .toList() ??
                        [];
                    List<ContractInfo> otherList = contractGroupList
                            .contractList
                            ?.where((element) => !['STOCK-US', 'STOCK-HK']
                                .contains(element.market))
                            .toList() ??
                        [];

                    List<String> tabs = [
                      LocaleKeys.public35.tr,
                      LocaleKeys.markets33.tr,
                      LocaleKeys.markets34.tr,
                    ];
                    if (otherList.isNotEmpty) {
                      tabs.add(
                        LocaleKeys.markets15.tr,
                      );
                    }

                    return DefaultTabController(
                      length: tabs.length,
                      child: Column(
                        children: [
                          CommodityStockTabWidget(dataArray: tabs),
                          Expanded(
                            child: TabBarView(
                              children: [
                                CommodityListView(
                                  contractList: all,
                                  recommendList: const [],
                                ),
                                CommodityListView(
                                  contractList: usList,
                                  recommendList: const [],
                                ),
                                CommodityListView(
                                  contractList: hkList,
                                  recommendList: const [],
                                ),
                                if (otherList.isNotEmpty)
                                  CommodityListView(
                                    contractList: otherList,
                                    recommendList: const [],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return CommodityListView(
                    contractList: e.value,
                    recommendList: const [],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
