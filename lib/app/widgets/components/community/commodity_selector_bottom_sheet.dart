import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_search_text_field.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_out_line_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CommoditySelectorBottomSheet extends StatefulWidget {
  const CommoditySelectorBottomSheet(
      {super.key, required this.contractInfoList});
  final List<ContractInfo> contractInfoList;

  /// 弹出时需要将已经选择的币对传入，选择时返回选择的币对
  static Future<ContractInfo?> showCoinBottomSheet(
      {required List<ContractInfo> contractInfoList}) async {
    return await showBSheet<ContractInfo?>(
      CommoditySelectorBottomSheet(
        contractInfoList: contractInfoList,
      ),
    );
  }

  @override
  State<CommoditySelectorBottomSheet> createState() =>
      _CommoditySelectorBottomSheetState();
}

class _CommoditySelectorBottomSheetState
    extends State<CommoditySelectorBottomSheet> {
  List<ContractInfo> showCoinList = [];

  bool isSearching = false;
  late TextEditingController controller;

  @override
  void initState() {
    showCoinList =
        CommodityDataStoreController.to.contractSymbolHashMap.values.toList();

    /// 从外部传入的币对，从showCoinList中移除
    for (var element in widget.contractInfoList) {
      showCoinList.removeWhere((e) => e.id == element.id);
    }
    controller = TextEditingController()
      ..addListener(() {
        String keyword = controller.text.trim();
        isSearching = keyword.isNotEmpty;
        if (keyword.isNotEmpty) {
          showCoinList = CommodityDataStoreController
              .to.contractSymbolHashMap.values
              .toList()
              .where((element) => contains(keyword, element))
              .toList();
        } else {
          showCoinList = CommodityDataStoreController
              .to.contractSymbolHashMap.values
              .toList();
        }

        /// 从外部传入的币对，从showCoinList中移除
        for (var element in widget.contractInfoList) {
          showCoinList.removeWhere((e) => e.id == element.id);
        }
        setState(() {});
      });
    super.initState();
  }

  bool contains(String keyword, ContractInfo element) {
    return element.symbol.toLowerCase().contains(keyword.toLowerCase()) ||
        element.contractName.toLowerCase().contains(keyword.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.other1.tr,
                style: AppTextStyle.f_20_600.color111111,
              ).marginOnly(bottom: 20.h),
              _buildSearchTextFiled(),
              20.verticalSpace,
              SizedBox(
                height: Get.height * 0.6,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return 8.verticalSpace;
                  },
                  itemCount: showCoinList.length,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    ContractInfo coin = showCoinList[index];
                    bool isSelected = false;
                    return bottomSheetBuildTitle(
                      coin.firstName + coin.secondName,
                      isSelected,
                      () {
                        Get.back(result: coin);
                      },
                      coin.getContractType,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1.h,
          color: AppColor.colorF5F5F5,
        ).marginSymmetric(vertical: 16.h),
        MyOutLineButton(title: LocaleKeys.public2.tr, onTap: () => Get.back()),
        16.verticalSpace,
      ],
    );
  }

  Widget _buildSearchTextFiled() {
    return MySearchTextField(height: 32.h, textEditingController: controller, margin: EdgeInsets.zero, hintText: LocaleKeys.public10.tr,);
  }
}
