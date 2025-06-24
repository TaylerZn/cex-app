import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_cell_model.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_shimmer.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MarketListEmpty extends StatelessWidget {
  const MarketListEmpty(
      {super.key,
      required this.tagKey,
      this.type = MarketSecondType.standardContract,
      required this.callback,
      required this.shrinkWrap});
  final String tagKey;
  final MarketSecondType type;
  final bool shrinkWrap;
  final Function(List<RxBool>) callback;
  // final List<RxBool> selectArr = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketsCellModel>(
      builder: (cellModel) {
        var array = type == MarketSecondType.perpetualContract
            ? cellModel.contractList
                ?.map((e) => {
                      'name': e.firstName + e.secondName,
                      'price': e.priceStr,
                      'rate': e.roseStr,
                      'color': e.backColor,
                      'secondName': '',
                      'selected': e.selected,
                      'subSymbol': e.subSymbol
                    })
                .toList()
            : type == MarketSecondType.spot
                ? cellModel.marketList
                    ?.map((e) => {
                          'name': e.firstName,
                          'secondName': e.secondName,
                          'price': e.priceStr,
                          'rate': e.roseStr,
                          'color': e.backColor,
                          'selected': e.selected,
                          'subSymbol': e.symbol
                        })
                    .toList()
                : cellModel.commodityList
                    ?.map((e) => {
                          'name': e.firstName + e.secondName,
                          'price': e.priceStr,
                          'rate': e.roseStr,
                          'color': e.backColor,
                          'secondName': '',
                          'selected': e.selected,
                          'subSymbol': e.subSymbol
                        })
                    .toList();

        return array != null
            ? array.isNotEmpty
                ? MarketListEmptyCollectionView(
                    array: array,
                    // selectArr: selectArr,
                    shrinkWrap: shrinkWrap,
                    callback: callback,
                  )
                : CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.only(top: shrinkWrap ? 0 : 100.h),
                      child: noDataWidget(context, text: LocaleKeys.public8.tr),
                    ))
                  ])
            : const MarketShimmer();
      },
      tag: tagKey,
    );
  }
}

class MarketListEmptyCollectionView extends StatelessWidget {
  const MarketListEmptyCollectionView({super.key, required this.array, required this.callback, required this.shrinkWrap});
  final List<Map<String, Object>>? array;
  final Function(List<RxBool>) callback;
  // final List<RxBool> selectArr;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> dataArray = array != null
        ? array!.length > 6
            ? array!.sublist(0, 6)
            : array!
        : [];
    // List<RxBool> selectArr = [];
    // for (var element in dataArray) {
    //   RxBool select = element['selected'] as RxBool;
    //   selectArr.add(select);
    // }

    var unSelected = false.obs;

    return CustomScrollView(
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
            child: Center(
                child: Text(
              LocaleKeys.markets25.tr,
              style: AppTextStyle.f_16_500.color4D4D4D,
            )),
          ),
        ),
        SliverToBoxAdapter(
          child: WaterfallFlow.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: dataArray.length,
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.w,
            ),
            itemBuilder: (context, index) {
              var model = dataArray[index];
              RxBool select = model['selected'] as RxBool;
              String subSymbol = model['subSymbol'] as String;

              return GetBuilder<CommodityDataStoreController>(
                  id: subSymbol,
                  builder: (contractVC) {
                    var infoSymbol = contractVC.getContractInfoBySubSymbol(subSymbol);

                    if (infoSymbol != null) {
                      model['price'] = infoSymbol.priceStr;
                      model['rate'] = infoSymbol.roseStr;
                      model['color'] = infoSymbol.backColor;
                    }

                    return Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: ShapeDecoration(
                          color: AppColor.colorF4F4F4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
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
                                      TextSpan(text: model['name'] as String, style: AppTextStyle.f_12_500.color111111),
                                      TextSpan(text: model['secondName'] as String, style: AppTextStyle.f_12_500.color999999),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: Text(model['price'] as String,
                                      textAlign: TextAlign.center, style: AppTextStyle.f_16_600.color111111),
                                ),
                                Text(model['rate'] as String,
                                    style: AppTextStyle.f_12_500.copyWith(
                                      color: dataArray[index]['color'] as Color,
                                    ))
                              ],
                            ),
                            Obx(() => GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    select.value = !select.value;

                                    unSelected.value = dataArray
                                        .map((e) => e['selected'] as RxBool)
                                        .toList()
                                        .every((element) => element.value == false);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: MyImage(
                                      'contract/${select.value ? 'market_select' : 'market_unSelect'}'.svgAssets(),
                                    ),
                                  ),
                                ))
                          ],
                        ));
                  });
            },
          ),
        ),
        SliverToBoxAdapter(
            child: Obx(() => MyButton(
                  backgroundColor: unSelected.value ? AppColor.colorCCCCCC : AppColor.color111111,
                  onTap: () {
                    if (unSelected.value) return;

                    // List<RxBool> selectArr = [];
                    // for (var element in dataArray) {
                    //   RxBool select = element['selected'] as RxBool;
                    //   selectArr.add(select);
                    // }

                    callback(dataArray.map((e) => e['selected'] as RxBool).toList());
                  },
                  height: 40.h,
                  text: LocaleKeys.markets26.tr,
                ).marginOnly(left: 24.w, right: 24.w, top: 30.h))),
      ],
    );
  }
}
