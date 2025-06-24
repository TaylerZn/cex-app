import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_asset/contract_no_asset_widget.dart';

import '../../../routes/app_pages.dart';
import '../../assets/assets_contract/controllers/assets_contract_controller.dart';
import '../../assets/assets_contract/widget/asset_contract_item.dart';

class CommodityAssetView extends StatelessWidget {
  const CommodityAssetView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsContractController());
    return GetBuilder<AssetsContractController>(builder: (controller) {
      return CustomScrollView(
        key: const PageStorageKey<String>('CommodityAssetView'),
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          controller.getAssetList(0).isEmpty
              ? SliverToBoxAdapter(
                  child: NoAssetWidget(onTap: () {
                    Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
                      'from': 3,
                      'to': 1,
                    });
                  }),
                )
              : SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return AssetContractItem(
                          accountRes: controller.getAssetList(0)[index],
                        );
                      },
                      childCount: controller.getAssetList(0).length,
                    ),
                  ),
                )
        ],
      );
    });
  }
}
