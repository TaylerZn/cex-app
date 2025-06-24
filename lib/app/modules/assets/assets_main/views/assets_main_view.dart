import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_tabs.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';

import '../../../assets/assets_main/controllers/assets_main_controller.dart';

class AssetsMainView extends GetView<AssetsMainController> {
  const AssetsMainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 44.w,
        title: AssetsTabs(
          tabColor: Colors.transparent,
          list: controller.tabs,
          controller: controller.tabController,
          gap: 16.w,
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: TabBarView(
          controller: controller.tabController,
          children: controller.views
              .map((e) => KeepAliveWrapper(
                    child: e,
                  ))
              .toList()),
    );
  }
}
