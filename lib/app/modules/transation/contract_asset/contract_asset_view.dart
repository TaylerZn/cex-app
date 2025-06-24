import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../assets/assets_contract/controllers/assets_contract_controller.dart';
import '../../assets/assets_contract/widget/asset_contract_item.dart';
import 'contract_no_asset_widget.dart';

class ContractAssetView extends StatelessWidget {
  const ContractAssetView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsContractController());
    return GetBuilder<AssetsContractController>(builder: (controller) {
      return CustomScrollView(
        key: const PageStorageKey<String>('ContractAssetView'),
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          controller.getAssetList(1).isEmpty
              ? SliverToBoxAdapter(
                  child: NoAssetWidget(onTap: () {
                    Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
                      'from': 3,
                      'to': 2,
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
                          accountRes: controller.getAssetList(1)[index],
                        );
                      },
                      childCount: controller.getAssetList(1).length,
                    ),
                  ),
                )
        ],
      );
    });
  }
}
