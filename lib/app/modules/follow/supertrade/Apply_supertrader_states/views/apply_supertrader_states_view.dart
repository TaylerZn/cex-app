import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/Apply_supertrader_states/widgets/apply_states_bottom.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/Apply_supertrader_states/widgets/apply_states_top.dart';

import '../controllers/apply_supertrader_states_controller.dart';

class ApplySupertraderStatesView extends GetView<ApplySupertraderStatesController> {
  const ApplySupertraderStatesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0B0C0F),
        body: GetBuilder(
            init: controller,
            builder: (c) {
              return Stack(children: [
                CustomScrollView(
                  slivers: <Widget>[
                    ApplySuperTradeStatesTop(
                      controller: controller,
                    ),
                  ],
                ),
                ApplySupertradeStatesBottomButton(controller: controller)
              ]);
            }));
  }
}
