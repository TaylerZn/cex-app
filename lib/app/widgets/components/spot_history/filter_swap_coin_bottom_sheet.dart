import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_text_style.dart';
import '../../../models/contract/res/public_info_market.dart';
import '../../basic/my_image.dart';
import '../transaction/bottom_sheet/bottom_sheet_util.dart';
import '../transaction/bottom_sheet/common_bottom_sheet.dart';
import '../transaction/my_out_line_button.dart';

/// 切换币对
class FilterSwapCoinBottomSheet extends StatefulWidget {
  const FilterSwapCoinBottomSheet({super.key, required this.markeInfo});
  final MarketInfoModel? markeInfo;

  static Future<MarketInfoModel?> showCoinBottomSheet(
      {required MarketInfoModel? marketInfo}) async {
    return await showBSheet<MarketInfoModel?>(
      FilterSwapCoinBottomSheet(markeInfo: marketInfo),
    );
  }

  @override
  State<FilterSwapCoinBottomSheet> createState() =>
      _FilterSwapCoinBottomSheetState();
}

class _FilterSwapCoinBottomSheetState extends State<FilterSwapCoinBottomSheet> {
  List<MarketInfoModel> showCoinList = [];

  bool showClear = false;
  late TextEditingController controller;

  @override
  void initState() {
    showCoinList = SpotDataStoreController.to.spotList;
    controller = TextEditingController()
      ..addListener(() {
        String keyword = controller.text.trim();
        showClear = keyword.isNotEmpty;
        if (keyword.isNotEmpty) {
          showCoinList = SpotDataStoreController.to.spotList
              .where((element) => contains(keyword, element))
              .toList();
        } else {
          showCoinList = SpotDataStoreController.to.spotList;
        }
        setState(() {});
      });
    super.initState();
  }

  bool contains(String keyword, MarketInfoModel element) {
    return element.symbol.toLowerCase().contains(keyword.toLowerCase()) ||
        element.showName.toLowerCase().contains(keyword.toLowerCase());
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
              _buildSearchTextFiled(),
              20.verticalSpace,
              SizedBox(
                height: Get.height * 0.6,
                child: ListView.builder(
                  itemCount: showCoinList.length + (showClear ? 0 : 1),
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (!showClear && index == 0) {
                      return bottomSheetBuildTitle(
                          LocaleKeys.trade115.tr, widget.markeInfo == null, () {
                        Get.back();
                      });
                    }
                    int i = showClear ? index : index - 1;
                    MarketInfoModel coin = showCoinList[i];
                    bool isSelected = coin == widget.markeInfo;
                    return bottomSheetBuildTitle(coin.showName, isSelected, () {
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
                suffixIcon: showClear
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
