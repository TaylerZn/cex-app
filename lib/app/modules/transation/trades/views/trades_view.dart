import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/views/contract_view.dart';
import 'package:nt_app_flutter/app/modules/transation/trades/widgets/trades_tab_bar.dart';

import '../../commodity/views/commodity_view.dart';
import '../../immediate_exchange/main/views/immediate_exchange_view.dart';
import '../controllers/trades_controller.dart';

class TradesView extends GetView<TradesController> {
  const TradesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            TradesTabBar(
              onTabChanged: controller.onTabChange,
            ),
            Expanded(
              child: Obx(() => IndexedStack(
                        index: controller.tradeIndextype.value.value - 1,
                        children: const [
                          CommodityView(), //交易 -> 标准合约
                          ContractView(), // 交易 -> 永续合约
                          ImmediateExchangeView(), // 交易 -> 闪兑
                        ],
                      ) // 交易 -> 闪兑
                  // 交易 -> 闪兑
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
