import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/contract_favorite_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../global/favorite/spot_favorite_controller.dart';
import '../../../models/contract/res/public_info.dart';
import '../../../utils/bus/event_type.dart';
import '../../basic/my_button.dart';
import '../../basic/my_image.dart';

enum OptionType {
  spot,
  contract,
  commodity,
}

class OptionEmptyView extends StatelessWidget {
  const OptionEmptyView({super.key, required this.type, this.contractList});

  final OptionType type;
  final List<ContractInfo>? contractList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OptionEmptyController>(
        init: OptionEmptyController(type, contractList ?? []),
        global: false,
        builder: (logic) {
          return Column(
            children: [
              40.verticalSpace,
              Text(
                LocaleKeys.markets25.tr,
                textAlign: TextAlign.center,
                style: AppTextStyle.f_16_500.color4D4D4D,
              ),
              30.verticalSpace,
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: [
                  if (type == OptionType.spot)
                    ...logic.recommendSpotList.map((e) {
                      return GetBuilder<SpotDataStoreController>(
                          id: e.symbol,
                          builder: (controller) {
                            MarketInfoModel info = SpotDataStoreController.to
                                    .getMarketInfoBySymbol(e.symbol) ??
                                e;
                            return buildOptionItem(
                                info.firstName,
                                info.secondName,
                                info.priceStr,
                                info.roseStr,
                                info.backColor,
                                logic.addSpotList.contains(e.symbol), () {
                              if (logic.addSpotList.contains(e.symbol)) {
                                logic.addSpotList.remove(e.symbol);
                              } else {
                                logic.addSpotList.add(e.symbol);
                              }
                              logic.update();
                            });
                          });
                    }),
                  if (type == OptionType.contract)
                    ...logic.recommendContractList.map((e) {
                      return GetBuilder<ContractDataStoreController>(
                          id: e.subSymbol,
                          builder: (controller) {
                            ContractInfo info = ContractDataStoreController.to
                                    .getContractInfoByContractId(e.id) ??
                                e;
                            return buildOptionItem(
                                info.firstName,
                                info.secondName,
                                info.priceStr,
                                info.roseStr,
                                info.backColor,
                                logic.addContractList.contains(e.id), () {
                              if (logic.addContractList.contains(e.id)) {
                                logic.addContractList.remove(e.id);
                              } else {
                                logic.addContractList.add(e.id);
                              }
                              logic.update();
                            });
                          });
                    }),
                  if (type == OptionType.commodity)
                    ...logic.recommendCommodityList.map((e) {
                      return GetBuilder<CommodityDataStoreController>(
                          id: e.subSymbol,
                          builder: (controller) {
                            ContractInfo info = CommodityDataStoreController.to
                                    .getContractInfoByContractId(e.id) ??
                                e;
                            return buildOptionItem(
                                info.firstName,
                                info.secondName,
                                info.priceStr,
                                info.roseStr,
                                info.backColor,
                                logic.addCommodityList.contains(e.id), () {
                              if (logic.addCommodityList.contains(e.id)) {
                                logic.addCommodityList.remove(e.id);
                              } else {
                                logic.addCommodityList.add(e.id);
                              }
                              logic.update();
                            });
                          });
                    }),
                ],
              ),
              30.verticalSpace,
              MyButton(
                backgroundColor: logic.unSelected
                    ? AppColor.colorCCCCCC
                    : AppColor.color111111,
                onTap: () {
                  if (logic.unSelected) return;
                  logic.addOption();
                },
                height: 40.h,
                text: LocaleKeys.markets26.tr,
              ).marginSymmetric(horizontal: 24, vertical: 30.h)
            ],
          );
        });
  }

  Widget buildOptionItem(String first, String second, String price, String rose,
      Color roseColor, bool isSelected, VoidCallback callback) {
    double w = ((Get.width - 32.w - 10.w) * 0.5).floorToDouble();
    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        width: w,
        height: 88.h,
        padding: EdgeInsets.all(16.w),
        decoration: ShapeDecoration(
          color: AppColor.colorF4F4F4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: first,
                          style: AppTextStyle.f_12_500.color111111),
                      TextSpan(
                          text: second,
                          style: AppTextStyle.f_12_500.color999999),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Text(price,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.f_16_600.color111111),
                ),
                Text(rose,
                    style: AppTextStyle.f_12_500.copyWith(
                      color: roseColor,
                    ))
              ],
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: callback,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: MyImage(
                  'contract/${isSelected ? 'market_select' : 'market_unSelect'}'
                      .svgAssets(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OptionEmptyController extends GetxController {
  OptionType type;

  List<ContractInfo> recommendContractList = [];
  List<ContractInfo> recommendCommodityList = [];
  List<MarketInfoModel> recommendSpotList = [];

  Set<num> addContractList = {};
  Set<num> addCommodityList = {};
  Set<String> addSpotList = {};

  OptionEmptyController(
    this.type,
    this.recommendCommodityList,
  ) {
    addCommodityList = recommendCommodityList.map((e) => e.id).toSet();
  }

  @override
  void onInit() {
    super.onInit();
    if (type == OptionType.contract) {
      for (var element in ContractOptionController.to.recommendContractList) {
        ContractInfo? info =
            ContractDataStoreController.to.getContractInfoByContractId(element);
        if (info != null) {
          recommendContractList.add(info);
          addContractList.add(info.id);
        }
      }
    }
    if (type == OptionType.spot) {
      for (var element in SpotOptionController.to.recommendContractList) {
        MarketInfoModel? info =
            SpotDataStoreController.to.getMarketInfoBySymbol(element);
        if (info != null) {
          recommendSpotList.add(info);
          addSpotList.add(info.symbol);
        }
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> addOption() async {
    switch (type) {
      case OptionType.spot:
        await SpotOptionController.to.updateSpotOption(addSpotList.toList());
        Bus.getInstance().emit(EventType.refreshSpotOption, null);
        break;
      case OptionType.contract:
        await ContractOptionController.to
            .updateContractOption(addContractList.toList());
        Bus.getInstance().emit(EventType.refreshContractOption, null);
        break;
      case OptionType.commodity:
        await CommodityOptionController.to.updateContractOption(
            addCommodityList.map((e) => e.toInt()).toList());
        Bus.getInstance().emit(EventType.refreshCommodityOption, null);
        break;
    }
  }

  bool get unSelected {
    switch (type) {
      case OptionType.spot:
        return addSpotList.isEmpty;
      case OptionType.contract:
        return addContractList.isEmpty;
      case OptionType.commodity:
        return addCommodityList.isEmpty;
    }
  }
}
