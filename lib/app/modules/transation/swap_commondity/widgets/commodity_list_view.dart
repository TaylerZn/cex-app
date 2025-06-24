import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_commondity/widgets/swap_commodity_item.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/option_empty_view.dart';

import '../../../../models/contract/res/public_info.dart';
import '../../../../widgets/components/transaction/market_title_widget.dart';
import '../../../../widgets/no/no_data.dart';

class CommodityListView extends StatelessWidget {
  const CommodityListView(
      {super.key, required this.contractList, required this.recommendList});

  final List<ContractInfo> contractList;
  final List<ContractInfo> recommendList;

  @override
  Widget build(BuildContext context) {
    if (contractList.isEmpty && recommendList.isNotEmpty) {
      return OptionEmptyView(
        type: OptionType.commodity,
        contractList: recommendList,
      );
    }
    return Column(
      children: [
        const MarketTitleWidget(),
        Expanded(
          child: contractList.isEmpty
              ? noDataWidget(context)
              : ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.zero,
                  itemCount: contractList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SwapCommodityItem(
                      contractInfo: contractList[index],
                    );
                  },
                ),
        )
      ],
    );
  }
}
