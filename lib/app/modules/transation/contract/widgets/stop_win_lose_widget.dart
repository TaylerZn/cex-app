import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/models/price_type.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/suffix_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../widgets/components/transaction/transaction_input_widget.dart';

class StopWinLoseWidget extends StatelessWidget {
  const StopWinLoseWidget(
      {super.key,
      required this.stopWinTextController,
      required this.stopLossTextController,
      required this.stopWinPriceType,
      required this.stopLossPriceType});
  // 止赢
  final TextEditingController stopWinTextController;
  // 止损
  final TextEditingController stopLossTextController;
  // 止盈价格类型
  final Rx<StopWinLosePriceType> stopWinPriceType;
  // 止损价格类型
  final Rx<StopWinLosePriceType> stopLossPriceType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionInputWidget(
          hintText: LocaleKeys.trade82.tr,
          width: double.infinity,
          controller: stopWinTextController,
          suffixWidget: Obx(() {
            return SuffixDownButton(
                title: stopWinPriceType.value.subTitle.tr,
                onTap: () async {
                  final index = await CommonBottomSheet.show(
                      titles: StopWinLosePriceType.values
                          .map((e) => e.title.tr)
                          .toList(),
                      selectedIndex: StopWinLosePriceType.values
                          .indexOf(stopWinPriceType.value));
                  if (index != null) {
                    stopWinPriceType.value = StopWinLosePriceType.values[index];
                  }
                });
          }),
          keyboardType: TextInputType.number,
        ),
        8.verticalSpace,
        TransactionInputWidget(
          hintText: LocaleKeys.trade83.tr,
          width: double.infinity,
          controller: stopLossTextController,
          suffixWidget: Obx(() {
            return SuffixDownButton(
                title: stopLossPriceType.value.subTitle.tr,
                onTap: () async {
                  final index = await CommonBottomSheet.show(
                      titles: StopWinLosePriceType.values
                          .map((e) => e.title.tr)
                          .toList(),
                      selectedIndex: StopWinLosePriceType.values
                          .indexOf(stopLossPriceType.value));
                  if (index != null) {
                    stopLossPriceType.value =
                        StopWinLosePriceType.values[index];
                  }
                });
          }),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
