import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_contract/controllers/swap_contract_all_controller.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/market_title_widget.dart';

import '../../../../widgets/no/no_data.dart';
import '../widgets/swap_coin_item.dart';

class SwapContractAllView extends StatelessWidget {
  const SwapContractAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        12.verticalSpace,
        const MarketTitleWidget(),
        Expanded(
          child: GetBuilder<SwapContractAllController>(builder: (logic) {
            if (logic.contractList.isEmpty) return noDataWidget(context);
            return ListView.builder(
              physics: const ClampingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.zero,
              itemCount: logic.contractList.length,
              itemBuilder: (BuildContext context, int index) {
                return SwapContractItem(
                  contractInfo: logic.contractList[index],
                );
              },
            );
          }),
        )
      ],
    );
  }
}
