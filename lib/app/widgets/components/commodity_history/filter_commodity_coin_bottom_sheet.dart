import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_search_text_field.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_text_style.dart';
import '../../basic/my_image.dart';
import '../transaction/bottom_sheet/bottom_sheet_util.dart';
import '../transaction/bottom_sheet/common_bottom_sheet.dart';
import '../transaction/my_out_line_button.dart';

/// 切换币对
class FilterCommodityCoinBottomSheet extends StatefulWidget {
  const FilterCommodityCoinBottomSheet({super.key, required this.contractInfo});
  final ContractInfo? contractInfo;

  static Future<ContractInfo?> showCoinBottomSheet(
      {required ContractInfo? contractInfo}) async {
    return await showBSheet<ContractInfo?>(
      FilterCommodityCoinBottomSheet(contractInfo: contractInfo),
    );
  }

  @override
  State<FilterCommodityCoinBottomSheet> createState() =>
      _FilterCommodityCoinBottomSheetState();
}

class _FilterCommodityCoinBottomSheetState
    extends State<FilterCommodityCoinBottomSheet> {
  List<ContractInfo> showCoinList = [];

  bool isSearching = false;
  late TextEditingController controller;

  @override
  void initState() {
    showCoinList =
        CommodityDataStoreController.to.contractSymbolHashMap.values.toList();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.trade120.tr,
                style: AppTextStyle.f_20_600.color111111,
              ).marginOnly(bottom: 20.h),
              MySearchTextField(
                height: 32.h,
                textEditingController: controller,
                margin: EdgeInsets.zero,
                backgroundColor: AppColor.colorF5F5F5,
                hintText: LocaleKeys.public10.tr,
              ),
              20.verticalSpace,
              SizedBox(
                height: Get.height * 0.6,
                child: ListView.builder(
                  itemCount: showCoinList.length + (isSearching ? 0 : 1),
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (!isSearching && index == 0) {
                      return bottomSheetBuildTitle(
                          LocaleKeys.trade115.tr, widget.contractInfo == null,
                          () {
                        Get.back();
                      });
                    }
                    int i = isSearching ? index : index - 1;
                    ContractInfo coin = showCoinList[i];
                    bool isSelected = coin == widget.contractInfo;
                    return bottomSheetBuildTitle(
                        coin.contractOtherName, isSelected, () {
                      Get.back(result: coin);
                    });
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
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        color: AppColor.colorF5F5F5,
        borderRadius: BorderRadius.circular(6.r),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          6.horizontalSpace,
          MyImage(
            'assets/images/contract/search_icon.png',
            width: 16.w,
            height: 16.w,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: controller,
              style: TextStyle(fontSize: 12.sp),
              cursorColor: AppColor.color111111,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 6.w),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                disabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: LocaleKeys.public10.tr,
                hintStyle: TextStyle(
                  color: AppColor.colorABABAB,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: isSearching
                    ? IconButton(
                        icon: const Icon(
                          Icons.highlight_remove_rounded,
                          color: AppColor.colorBlack,
                        ),
                        onPressed: () {
                          controller.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
