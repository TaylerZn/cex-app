import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/controllers/swap_spot_all_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/widgets/swap_spot_item.dart';

import '../../../../widgets/components/transaction/market_title_widget.dart';

class SwapSpotAllView extends StatelessWidget {
  const SwapSpotAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MarketTitleWidget(),
        Expanded(
          child: GetBuilder<SwapSpotAllController>(builder: (logic) {
            return ListView.builder(
              physics: const ClampingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.zero,
              itemCount: logic.marketInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                return SwapSpotItem(
                  marketInfoModel: logic.marketInfoList[index],
                );
              },
            );
          }),
        )
      ],
    );
  }
}
