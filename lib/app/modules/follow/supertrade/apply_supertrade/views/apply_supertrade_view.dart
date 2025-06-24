import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/widgets/apply_supertrade_bottom.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/widgets/apply_supertrade_mid.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/widgets/apply_supertrade_top.dart';
import '../controllers/apply_supertrade_controller.dart';

//

class ApplySupertradeView extends GetView<ApplySupertradeController> {
  const ApplySupertradeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
            init: controller,
            builder: (c) {
              return controller.btnStr.isNotEmpty
                  ? Stack(children: [
                      CustomScrollView(
                        slivers: <Widget>[
                          ApplySuperTradeTop(messageArray: controller.messageArray),
                          ApplySupertradeMid(
                            controller: controller,
                          ),
                          ApplySupertradeBottom(
                            helpArray: controller.helpArray,
                          )
                        ],
                      ),
                      ApplySupertradeBottomButton(controller: controller)
                    ])
                  : const FollowOrdersLoading(isSliver: false);
            }));
  }
}
