import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/merchant/widgets/merchant_apply_list.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';

import '../controllers/merchant_apply_controller.dart';

class MerchantApplyView extends GetView<MerchantApplyController> {
  const MerchantApplyView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (c) {
          return Scaffold(
              backgroundColor: const Color(0xFF111111),
              appBar: AppBar(
                leading: const MyPageBackWidget(backColor: AppColor.colorWhite),
                backgroundColor: const Color(0xFF111111),
              ),
              body: CustomScrollView(
                slivers: <Widget>[
                  MerchantApplyTop(controller: controller),
                ],
              ),
              bottomNavigationBar: MerchantApplyBottomView(controller: controller));
        });
  }
}
