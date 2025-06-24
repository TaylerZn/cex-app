import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/controllers/swap_spot_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/views/swap_spot_all_view.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/views/swap_spot_option_view.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_search_text_field.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../widgets/basic/my_tab_underline_widget.dart';

class SwapSpotBottomSheet extends StatelessWidget {
  const SwapSpotBottomSheet({super.key});

  static Future<MarketInfoModel?> show() async {
    return await showBSheet<MarketInfoModel>(const SwapSpotBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SwapSpotController>(
      init: SwapSpotController(),
      builder: (logic) {
        return DefaultTabController(
          length: logic.tabs.length,
          initialIndex: logic.tabs.length - 1,
          child: SizedBox(
            height: Get.height - Get.mediaQuery.padding.top - 40.h,
            child: Column(
              children: [
                8.verticalSpace,
                Container(
                  width: 50.w,
                  height: 4.h,
                  decoration: ShapeDecoration(
                    color: AppColor.colorBackgroundDisabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ),
                12.verticalSpace,
                MySearchTextField(
                  textEditingController: logic.textEditingController,
                  height: 36.w,
                  hintText: LocaleKeys.public11.tr,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                3.verticalSpace,
                Expanded(child: _tabView(logic)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _tabView(SwapSpotController controller) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 40.h,
          alignment: Alignment.centerLeft,
          child: TabBar(
              isScrollable: true,
              indicator: MyUnderlineTabIndicator(
                borderSide: const BorderSide(
                  width: 2,
                  color: AppColor.color111111,
                ),
                lineWidth: 24.w,
              ),
              labelColor: AppColor.color111111,
              unselectedLabelColor: AppColor.colorABABAB,
              labelStyle: AppTextStyle.f_14_500,
              unselectedLabelStyle: AppTextStyle.f_14_500,
              tabs: controller.tabs
                  .map(
                    (e) => Tab(
                      text: e,
                    ),
                  )
                  .toList()),
        ),
        Divider(
          height: 1.h,
          color: AppColor.colorF5F5F5,
        ),
        Expanded(
          child: TabBarView(
            children: [
              if (UserGetx.to.isLogin) const SwapSpotOptionView(),
              const SwapSpotAllView(),
              // SimulateContractListView(),
            ],
          ),
        ),
      ],
    );
  }
}
