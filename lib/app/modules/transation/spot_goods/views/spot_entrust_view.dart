import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/spot_goods/spot_order_res.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_entrust_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';

import '../../../../widgets/no/no_data.dart';
import '../../spot_history/current_entrust/widgets/spot_current_entrust_wiget.dart';
import '../../widgets/entrust_operate.dart';

class SpotEntrustView extends GetView<SpotEntrustController> {
  const SpotEntrustView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        key: const PageStorageKey<String>('currentEntrust'),
        slivers: controller.dataList.isNotEmpty
            ? <Widget>[
                SliverToBoxAdapter(
                  child: EntrustOperate(
                    isHideOther: controller.isHideOther.value,
                    onHideOther: controller.onHideOther,
                    onOneKeyClose: controller.onOneKeyClose,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        SpotOrderInfo? orderInfo =
                            controller.dataList.safe(index);
                        if (orderInfo == null) return 0.verticalSpace;
                        return SpotCurrentEntrustItem(
                          orderInfo: orderInfo,
                        );
                      },
                      childCount: controller.dataList.length,
                    ),
                  ),
                ),
              ]
            : <Widget>[
                SliverToBoxAdapter(
                  child: noDataWidget(context).marginOnly(top: 30.h),
                ),
              ],
      );
    });
  }
}
