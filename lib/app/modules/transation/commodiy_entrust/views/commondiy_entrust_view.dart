import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/entrust_operate.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../models/contract/res/order_info.dart';
import '../../../../utils/utilities/ui_util.dart';
import '../../../../widgets/dialog/warning_dialog.dart';
import '../../../../widgets/no/no_data.dart';
import '../../contract_entrust/widgets/current_entrust_item.dart';
import '../controllers/commondiy_entrust_controller.dart';

class CommodityEntrustView extends GetView<CommodityEntrustController> {
  const CommodityEntrustView({super.key});

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
                    onOneKeyClose:(){
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
                      OrderInfo? orderInfo =
                          controller.dataList.safe(index);
                      if (orderInfo == null) return 0.verticalSpace;
                      return Obx(
                        () => CurrentEntrustItem(
                          orderInfo: orderInfo,
                          isCommodity: true,
                          onTap: () async {
                            // WarningDialog.show(
                            //     title: LocaleKeys.trade391.tr,
                            //     icon: 'assets/images/trade/notice_warning.svg',
                            //     okTitle: LocaleKeys.public57.tr,
                            //     onOk: () {
                                  controller.onCancelOrder(orderInfo);
                                // },
                                // cancelTitle: LocaleKeys.public2.tr);

                          },
                          amountIndex: CommodityController
                              .to.state.amountUnitIndex.value,
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
                      onOneKeyClose: (){
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
