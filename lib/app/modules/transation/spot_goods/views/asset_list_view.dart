import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/asset_list_controller.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../widgets/list_item/asset_list_item.dart';

class AssetListView extends StatelessWidget {
  const AssetListView({super.key});

  @override
  Widget build(BuildContext context) {
    AssetListController controller = AssetListController.to;

    return Obx(() {
      return CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        key: const PageStorageKey<String>('currentEntrust'),
        slivers:
            controller.currentCoinMap.length + controller.otherCoinMap.length >
                    0
                ? <Widget>[
                    if (controller.currentCoinMap.value.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Text(
                          LocaleKeys.trade172.tr,
                          style: AppTextStyle.f_14_500.color999999,
                        ).marginOnly(top: 16.h, left: 16.w),
                      ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          String coinName =
                              controller.currentCoinMap.keys.elementAt(index);
                          AssetSpotsAllCoinMapModel? value =
                              controller.currentCoinMap[coinName];
                          if (value == null) return 0.verticalSpace;
                          return AssetListItem(
                            coinName: coinName,
                            coinMap: value,
                          );
                        },
                        childCount: controller.currentCoinMap.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        LocaleKeys.trade173.tr,
                        style: AppTextStyle.f_14_500.color999999,
                      ).marginOnly(top: 16.h, left: 16.w),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          String coinName =
                              controller.otherCoinMap.keys.elementAt(index);
                          AssetSpotsAllCoinMapModel? value =
                              controller.otherCoinMap[coinName];
                          if (value == null) return 0.verticalSpace;
                          return AssetListItem(
                            coinName: coinName,
                            coinMap: value,
                          );
                        },
                        childCount: controller.otherCoinMap.length,
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
