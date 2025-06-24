import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_open_time.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/contract_info/widgets/contract_level_margin_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../controllers/contract_info_controller.dart';
import '../widgets/contract_capital_widget.dart';
import '../widgets/contract_des_widget.dart';
import '../widgets/contract_param_view.dart';
import '../widgets/contract_trade_time_widget.dart';

class ContractInfoView extends StatelessWidget {
  const ContractInfoView(
      {super.key,
      required this.contractInfo,
      required this.openTime,
      required this.maxLevel});

  final ContractInfo? contractInfo;
  final CommodityOpenTime? openTime;
  final int maxLevel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContractInfoController>(
        init: ContractInfoController(contractInfo, openTime),
        builder: (controller) {
          return Column(
            children: [
              _buildTab(controller).marginSymmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              Expanded(child: _buildContent(controller))
            ],
          );
        });
  }

  Widget _buildContent(ContractInfoController controller) {
    return IndexedStack(
      index: controller.tabIndex,
      children: [
        if ([0, 1, 5].contains(contractInfo?.kind))
          ContractDesWidget(
            contractInfo: controller.contractInfo,
            key: ValueKey('des${contractInfo?.id}'),
          ),
        ContractParamWidget(
          contractInfo: controller.contractInfo,
          key: ValueKey('param${contractInfo?.id}'),
          maxLevel: maxLevel,
        ),
        ContractLevelMarginWidget(
          contractInfo: controller.contractInfo,
          key: ValueKey('level${contractInfo?.id}'),
        ),
        ContractCapitalWidget(
          contractInfo: controller.contractInfo,
          key: ValueKey('capital${contractInfo?.id}'),
        ),
        ContractTradeTimeWidget(
          controller: controller,
          key: ValueKey('tradeTime${contractInfo?.id}'),
        ),
      ],
    );
  }

  Widget _buildTab(ContractInfoController controller) {
    List list = [0, 1, 5];
    int index = list.contains(contractInfo?.kind) ? 0 : 1;

    return TabBar(
        controller: controller.tabController,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicator: const BoxDecoration(),
        onTap: (index) {
          controller.changeTabIndex(index);
        },
        tabs: [
          if (index == 0)
            _buildBtn(
              LocaleKeys.trade422.tr,
              controller.tabIndex == 0,
            ),
          _buildBtn(
            LocaleKeys.trade86.tr,
            controller.tabIndex == 1 - index,
          ),
          _buildBtn(
            LocaleKeys.trade423.tr,
            controller.tabIndex == 2 - index,
          ),
          _buildBtn(
            LocaleKeys.trade87.tr,
            controller.tabIndex == 3 - index,
          ),
          contractInfo!.contractType != "E"
              ? _buildBtn(
                  LocaleKeys.trade234.tr,
                  controller.tabIndex == 4 - index,
                )
              : 0.verticalSpace,
        ]);

    // return SizedBox(
    //   width: Get.width,
    //   child: SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           if(index == 0) _buildBtn(LocaleKeys.trade422.tr, controller.tabIndex == 0, () {
    //             controller.changeTabIndex(0);
    //           }),
    //           _buildBtn(LocaleKeys.trade86.tr, controller.tabIndex == 1 - index, () {
    //             controller.changeTabIndex(1 - index);
    //           }),
    //           _buildBtn(LocaleKeys.trade423.tr, controller.tabIndex == 2 - index, () {
    //             controller.changeTabIndex(2 - index);
    //           }),
    //           _buildBtn(LocaleKeys.trade87.tr, controller.tabIndex == 3 - index, () {
    //             controller.changeTabIndex(3 - index);
    //           }),
    //           contractInfo!.contractType != "E"
    //               ? _buildBtn(LocaleKeys.trade234.tr, controller.tabIndex == 4 - index,
    //                   () {
    //                   controller.changeTabIndex(4- index);
    //                 })
    //               : 0.verticalSpace,
    //         ],
    //       )),
    // );
  }

  Widget _buildBtn(String title, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 6.h,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60.r),
        color: isSelected
            ? AppColor.colorBackgroundTertiary
            : AppColor.colorAlwaysWhite,
        border: Border.all(
          color: isSelected ? AppColor.transparent : AppColor.colorBorderGutter,
          width: 1,
        ),
      ),
      child: Text(
        title,
        style: isSelected
            ? AppTextStyle.f_12_500.color111111
            : AppTextStyle.f_12_500.colorABABAB,
      ),
    ).marginOnly(right: 10.w);
  }
}
