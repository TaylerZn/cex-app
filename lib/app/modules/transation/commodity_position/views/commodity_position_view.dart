import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/models/contract_type.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/postion_operate.dart';

import '../../../../routes/app_pages.dart';
import '../../contract_asset/contract_no_asset_widget.dart';
import '../../contract_postion/widgets/contract_postion_item.dart';
import '../controllers/commodity_position_controller.dart';

class CommodityPositionView extends GetView<CommodityPositionController> {
  const CommodityPositionView({super.key});

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
                      return Obx(
                        () => ContractPositionItem(
                          positionInfo: controller.positionList[index],
                          contractType: ContractType.B,
                          amountIndex: CommodityController
                              .to.state.amountUnitIndex.value,
                        ),
                      );
                    },
                    childCount: controller.positionList.length,
                  ),
                ),
              ],
      );
    });
  }
}
