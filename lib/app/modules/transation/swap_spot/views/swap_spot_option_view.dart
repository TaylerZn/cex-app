import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/controllers/swap_spot_option_controller.dart';

import 'package:nt_app_flutter/app/modules/transation/swap_spot/widgets/swap_spot_item.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/option_empty_view.dart';

import '../../../../widgets/components/transaction/market_title_widget.dart';

class SwapSpotOptionView extends StatelessWidget {
  const SwapSpotOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SwapSpotOptionController>(builder: (logic) {
      if (logic.marketList.isEmpty) {
        return const OptionEmptyView(type: OptionType.spot);
      }
      return Column(
        children: [
          const MarketTitleWidget(),
          Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.zero,
              itemCount: logic.marketList.length,
              itemBuilder: (BuildContext context, int index) {
                MarketInfoModel? model = logic.marketList[index];
                return SwapSpotItem(
                  marketInfoModel: model,
                );
              },
            ),
          )
        ],
      );
    });
  }
}
