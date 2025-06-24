import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_Listview.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_tabbar.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../controllers/entrust_controller.dart';

//

class EntrustView extends GetView<EntrustController> {
  const EntrustView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: Text(LocaleKeys.trade148.tr),
        centerTitle: true,
        backgroundColor: AppColor.colorWhite,
        // actions: [
        //   Obx(() => controller.showExport.value
        //       ? GestureDetector(
        //           onTap: () {
        //             controller.showExportView();
        //           },
        //           child: Container(
        //             alignment: Alignment.center,
        //             padding: EdgeInsets.symmetric(horizontal: 16.w),
        //             child: MyImage(
        //               'trade/entrust_top_right'.svgAssets(),
        //               width: 22.w,
        //             ),
        //           ),
        //         )
        //       : const SizedBox())
        // ],
      ),
      body: Column(
        children: [
          Obx(() => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: EntrustTabbar(
                  dataArray: controller.tabBarArray.value,
                  controller: controller.tabController,
                ),
              )),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: controller.tabs.map((model) {
                return Builder(
                  builder: (BuildContext context) {
                    return KeepAliveWrapper(
                      child: EntrustListView(
                        transactionModel: model,
                        controller: controller,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
