import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_operate_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_entrust/controllers/contract_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_entrust/widgets/current_entrust_item.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../widgets/dialog/warning_dialog.dart';
import '../../../../widgets/no/no_data.dart';
import '../../widgets/entrust_operate.dart';

class CurrentEntrustView extends GetView<ContractEntrustController> {
  const CurrentEntrustView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        key: const PageStorageKey<String>('currentEntrust'),
        slivers: controller.count.value > 0
            ? <Widget>[
                SliverToBoxAdapter(
                  child: EntrustOperate(
                    isHideOther: controller.isHideOther.value,
                    onHideOther: controller.onHideOther,
                    onOneKeyClose: () {
                      WarningDialog.show(
                          title: LocaleKeys.trade391.tr,
                          icon: 'assets/images/trade/notice_warning.svg',
                          okTitle: LocaleKeys.public57.tr,
                          onOk: () {
                            controller.onOneKeyClose();
                          },
                          cancelTitle: LocaleKeys.public2.tr);
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      OrderInfo? orderInfo = controller.dataList.safe(index);
                      if (orderInfo == null) return 0.verticalSpace;
                      return Obx(
                        () => CurrentEntrustItem(
                          orderInfo: orderInfo,
                          amountIndex: ContractOperateController
                              .to.amountUnitIndex.value,
                          isCommodity: false,
                          onTap: () {
                            controller.onCancelOrder(orderInfo);
                          },
                        ),
                      );
                    },
                    childCount: controller.dataList.value.length ?? 0,
                  ),
                ),
              ]
            : <Widget>[
                  SliverToBoxAdapter(
                    child: EntrustOperate(
                      isHideOther: controller.isHideOther.value,
                      onHideOther: controller.onHideOther,
                      onOneKeyClose: () {
                        WarningDialog.show(
                            title: LocaleKeys.trade391.tr,
                            icon: 'assets/images/trade/notice_warning.svg',
                            okTitle: LocaleKeys.public57.tr,
                            onOk: () {
                              controller.onOneKeyClose();
                            },
                            cancelTitle: LocaleKeys.public2.tr);
                      },
                    ),
                  ),
                SliverToBoxAdapter(
                  child: noDataWidget(context).marginOnly(top: 30.h),
                ),
              ],
      );
    });
  }
}
