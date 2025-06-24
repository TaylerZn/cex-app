import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_enum.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/views/wallet_history_list_view.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_tabbar.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'package:nt_app_flutter/app/modules/assets/wallet_history/controllers/wallet_history_controller.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';

//

class WalletHistoryView extends GetView<WalletHistoryController> {
  const WalletHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: Text(LocaleKeys.assets123.tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w),
            child: EntrustTabbar(
              dataArray: controller.tabs.map((e) => e.value).toList(),
              controller: controller.tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: controller.tabs.asMap().entries.map((entry) {
                final int index = entry.key;
                final WalletHistoryType type = entry.value;
                return KeepAliveWrapper(child: WalletHistoryListView(currentType: type, model: controller.modelList[index]));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
