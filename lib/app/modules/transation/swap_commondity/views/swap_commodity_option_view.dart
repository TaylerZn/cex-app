import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_commondity/widgets/commodity_stock_tab_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';

import '../../../../../generated/locales.g.dart';
import '../controllers/swap_commodity_option_controller.dart';
import '../widgets/commdity_tab_bar.dart';
import '../widgets/commodity_list_view.dart';

class SwapCommodityOptionView extends StatelessWidget {
  const SwapCommodityOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SwapCommodityOptionController>(builder: (logic) {
      return Column(
        children: [
          CommodityTabbar(
            dataArray: logic.tabs,
            controller: logic.tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: logic.tabController,
              children: logic.tabs.asMap().entries.map((e) {
                ContractGroupList contractGroupList =
                    CommodityDataStoreController.to.contractGroupList[e.key];

                List<ContractInfo> contractList =
                    logic.contractList.safe(e.key) ?? [];
                List<ContractInfo> recommendList =
                    logic.recommendContract[e.value] ?? [];

                /// 股票有二级分组
                if (contractGroupList.kind == 'B_1') {
                  List<ContractInfo> all = contractList;
                  List<ContractInfo> recomendAll = recommendList;

                  // 美股
                  List<ContractInfo> usList = contractList
                      .where((element) => element.market == 'STOCK-US')
                      .toList();
                  List<ContractInfo> tempRecommendUsList = contractGroupList
                          .contractList
                          ?.where((element) => element.market == 'STOCK-US')
                          .toList() ??
                      [];
                  List<ContractInfo> recommendUsList = tempRecommendUsList
                      .sublist(0, min(6, tempRecommendUsList.length));

                  // 港股
                  List<ContractInfo> hkList = contractList
                      .where((element) => element.market == 'STOCK-HK')
                      .toList();
                  List<ContractInfo> temprecommendHKList = contractGroupList
                          .contractList
                          ?.where((element) => element.market == 'STOCK-HK')
                          .toList() ??
                      [];
                  List<ContractInfo> recommendHKList = temprecommendHKList
                      .sublist(0, min(6, temprecommendHKList.length));

                  List<ContractInfo> otherList = contractList
                      .where((element) =>
                          !['STOCK-US', 'STOCK-HK'].contains(element.market))
                      .toList();
                  List<ContractInfo> recommendOtherList = contractList
                      .where((element) =>
                          !['STOCK-US', 'STOCK-HK'].contains(element.market))
                      .toList();

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
                                recommendList: recomendAll,
                              ),
                              CommodityListView(
                                contractList: usList,
                                recommendList: recommendUsList,
                              ),
                              CommodityListView(
                                contractList: hkList,
                                recommendList: recommendHKList,
                              ),
                              if (otherList.isNotEmpty)
                                CommodityListView(
                                  contractList: otherList,
                                  recommendList: recommendOtherList,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return CommodityListView(
                  contractList: contractList,
                  recommendList: recommendList,
                );
              }).toList(),

              // .map((e) => CommodityListView(
              //       contractList: logic.contractList.safe(e.key) ?? [],
              //       recommendList: logic.recommendContract[e.value] ?? [],
              //     ))
            ),
          ),
        ],
      );
    });
  }
}
