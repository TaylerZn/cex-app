import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_contract/controllers/swap_contract_option_controller.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/option_empty_view.dart';

import '../../../../models/contract/res/public_info.dart';
import '../../../../widgets/components/transaction/market_title_widget.dart';
import '../widgets/swap_coin_item.dart';

class SwapContractOptionView extends StatelessWidget {
  const SwapContractOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SwapContractOptionController>(builder: (logic) {
      if (logic.contractList.isEmpty) {
        return const OptionEmptyView(type: OptionType.contract);
      }
      return Column(
        children: [
          12.verticalSpace,
          const MarketTitleWidget(),
          Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.zero,
              itemCount: logic.contractList.length,
              itemBuilder: (BuildContext context, int index) {
                ContractInfo? contractInfo = logic.contractList[index];
                return SwapContractItem(
                  contractInfo: contractInfo,
                );
              },
            ),
          )
        ],
      );
    });
  }
}
