import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/models/contract_type.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_operate_controller.dart';

import '../../../../routes/app_pages.dart';
import '../../contract_asset/contract_no_asset_widget.dart';
import '../../widgets/postion_operate.dart';
import '../controllers/contract_position_controller.dart';
import '../widgets/contract_postion_item.dart';

class ContractPositionView extends GetView<ContractPositionController> {
  const ContractPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScrollView(
        key: const PageStorageKey<String>('holdPosition'),
        physics: const ClampingScrollPhysics(),
        slivers: controller.positionList.isEmpty
            ? <Widget>[
                if (!controller.isEmpty.value)
                  SliverToBoxAdapter(
                    child: PositionOperate(
                      isHideOther: controller.isHideOther.value,
                      onHideOther: controller.onHideOther,
                      onOneKeyClose: controller.onOneKeyClose,
                    ),
                  ),
                SliverToBoxAdapter(
                  child: NoAssetWidget(
                    onTap: () {
                      Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
                        'from': 3,
                        'to': 1,
                      });
                    },
                  ),
                )
              ]
            : <Widget>[
                SliverToBoxAdapter(
                  child: PositionOperate(
                    isHideOther: controller.isHideOther.value,
                    onHideOther: controller.onHideOther,
                    onOneKeyClose: controller.onOneKeyClose,
                  ),
                ),
                 SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Obx(() => ContractPositionItem(
                              positionInfo: controller.positionList[index],
                              contractType: ContractType.E,
                              amountIndex: ContractOperateController
                                  .to.amountUnitIndex.value,
                            ));
                      },
                      childCount: controller.positionList.length,
                    ),
                  ),
              ],
      );
    });
  }
}
