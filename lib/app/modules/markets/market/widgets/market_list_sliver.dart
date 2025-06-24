import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_action.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ContractSliver extends StatelessWidget {
  const ContractSliver(
      {super.key, required this.contractList, this.isBuilder = true});

  final List<ContractInfo> contractList;
  final bool isBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (BuildContext c, int i) {
        return ContractSliverCell(
            contractModel: contractList[i], isBuilder: isBuilder);
      },
      itemCount: contractList.length,
    );
  }
}

class ContractSliverCell extends StatelessWidget {
  const ContractSliverCell(
      {super.key,
      required this.contractModel,
      this.saarchName,
      this.isBuilder = true});

  final ContractInfo contractModel;
  final String? saarchName;
  final bool isBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContractDataStoreController>(
        id: isBuilder ? contractModel.subSymbol : null,
        builder: (contractVC) {
          var model =
              contractVC.getContractInfoBySubSymbol(contractModel.subSymbol) ??
                  contractModel;
          return MarketAction(
              contract: model,
              callBack: (int value) {
                MarketDataManager.instance.saveFavouriteTicker(
                    [model.id.toString()],
                    type: MarketSecondType.perpetualContract);
              },
              actions: [
                MarketDataManager.instance.getTitleWithSymbol(
                    model.id.toString(),
                    type: MarketSecondType.perpetualContract)
              ],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                child: Row(
                  children: <Widget>[
                    MarketIcon(iconName: model.base.toUpperCase(), width: 24.w)
                        .marginOnly(right: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          saarchName?.isNotEmpty == true
                              ? Row(
                                  children: <Widget>[
                                    SearchTextWidget(
                                        name: model.firstName,
                                        searchText: saarchName,
                                        style:
                                            AppTextStyle.f_13_500.color111111),
                                    SearchTextWidget(
                                        name: model.secondName,
                                        searchText: saarchName,
                                        style:
                                            AppTextStyle.f_14_500.color999999),
                                    4.horizontalSpace,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.colorF1F1F1,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        LocaleKeys.trade7.tr,
                                        style:
                                            AppTextStyle.f_10_500.color4D4D4D,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: model.firstName,
                                              style: AppTextStyle
                                                  .f_14_600.colorTextPrimary),
                                          TextSpan(
                                              text: model.secondName,
                                              style: AppTextStyle
                                                  .f_12_400.colorTextTips),
                                        ],
                                      ),
                                    ),
                                    4.horizontalSpace,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.colorBackgroundTertiary,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        LocaleKeys.trade7.tr,
                                        style: AppTextStyle
                                            .f_10_500.colorTextTertiary,
                                      ),
                                    )
                                  ],
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(model.volStr,
                                style: AppTextStyle
                                    .f_11_400.colorTextTips.ellipsis),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(model.priceStr,
                            textAlign: TextAlign.right,
                            style: AppTextStyle.f_15_600.colorTextPrimary),
                        Padding(
                          padding: EdgeInsets.only(top: 2.w),
                          child: Text(model.desPriceStr,
                              textAlign: TextAlign.right,
                              style: AppTextStyle.f_11_400.colorTextTips),
                        )
                      ],
                    ),
                    Container(
                      width: 70.w,
                      height: 32.w,
                      margin: EdgeInsets.only(left: 12.w),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: model.backColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.w)),
                      ),
                      child: Text(model.roseStr,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.f_14_500.colorAlwaysWhite),
                    )
                  ],
                ),
              ));
        });
  }
}

class SpotSliver extends StatelessWidget {
  const SpotSliver(
      {super.key, required this.marketList, this.isBuilder = true});

  final List<MarketInfoModel> marketList;
  final bool isBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (BuildContext c, int i) {
        return SpotSliverCell(
            marketInfoModel: marketList[i], isBuilder: isBuilder);
      },
      itemCount: marketList.length,
    );
  }
}

class SpotSliverCell extends StatelessWidget {
  const SpotSliverCell(
      {super.key,
      required this.marketInfoModel,
      this.saarchName,
      this.isBuilder = true});

  final MarketInfoModel marketInfoModel;
  final String? saarchName;
  final bool isBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpotDataStoreController>(
      id: isBuilder ? marketInfoModel.symbol : null,
      builder: (spotVC) {
        var model = spotVC.getMarketInfoBySymbol(marketInfoModel.symbol) ??
            marketInfoModel;
        return MarketAction(
          marketInfo: model,
          callBack: (int value) {
            MarketDataManager.instance.saveFavouriteTicker([model.symbol],
                type: MarketSecondType.spot);
          },
          actions: [
            MarketDataManager.instance
                .getTitleWithSymbol(model.symbol, type: MarketSecondType.spot)
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
            child: Row(
              children: <Widget>[
                MarketIcon(iconName: marketInfoModel.firstName.toUpperCase())
                    .marginOnly(right: 8.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      saarchName?.isNotEmpty == true
                          ? Row(
                              children: <Widget>[
                                SearchTextWidget(
                                    name: model.firstName,
                                    searchText: saarchName,
                                    style: AppTextStyle.f_13_500.color111111),
                                SearchTextWidget(
                                    name: model.secondName,
                                    searchText: saarchName,
                                    style: AppTextStyle.f_14_500.color999999),
                              ],
                            )
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: model.firstName,
                                      style: AppTextStyle.f_13_500.color111111),
                                  TextSpan(
                                      text: model.secondName,
                                      style: AppTextStyle.f_14_500.color999999),
                                ],
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(model.volStr,
                            style: AppTextStyle.f_11_400.color666666),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(model.priceStr,
                        textAlign: TextAlign.right,
                        style: AppTextStyle.f_14_500.color111111),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(model.desPriceStr,
                          textAlign: TextAlign.right,
                          style: AppTextStyle.f_11_400.color999999),
                    )
                  ],
                ),
                Container(
                  width: 76.w,
                  height: 28.w,
                  margin: EdgeInsets.only(left: 12.w),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: model.backColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(model.roseStr,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.f_14_500.colorWhite),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class StandardContractSliver extends StatelessWidget {
  const StandardContractSliver(
      {super.key, required this.commodityList, this.isBuilder = true});

  final List<ContractInfo> commodityList;
  final bool isBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (BuildContext c, int i) {
        return StandardContractSliverCell(
            commodityModel: commodityList[i], isBuilder: isBuilder);
      },
      itemCount: commodityList.length,
    );
  }
}

class StandardContractSliverCell extends StatelessWidget {
  const StandardContractSliverCell(
      {super.key,
      required this.commodityModel,
      this.saarchName,
      this.isBuilder = true});

  final ContractInfo commodityModel;
  final String? saarchName;
  final bool isBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommodityDataStoreController>(
        id: isBuilder ? commodityModel.subSymbol : null,
        builder: (contractVC) {
          var model =
              contractVC.getContractInfoBySubSymbol(commodityModel.subSymbol) ??
                  commodityModel;
          return MarketAction(
              standardContract: model,
              callBack: (int value) {
                MarketDataManager.instance.saveFavouriteTicker(
                    [model.id.toString()],
                    type: MarketSecondType.standardContract);
              },
              actions: [
                MarketDataManager.instance.getTitleWithSymbol(
                    model.id.toString(),
                    type: MarketSecondType.standardContract)
              ],
              child: Container(
                height: 54.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: <Widget>[
                    MarketIcon(width: 24, iconName: model.base.toUpperCase())
                        .marginOnly(right: 8.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          saarchName?.isNotEmpty == true
                              ? Row(
                                  children: <Widget>[
                                    SearchTextWidget(
                                        name: model.firstName,
                                        searchText: saarchName,
                                        style:
                                            AppTextStyle.f_13_500.color111111),
                                    SearchTextWidget(
                                        name: model.secondName,
                                        searchText: saarchName,
                                        style:
                                            AppTextStyle.f_14_500.color999999),
                                    4.horizontalSpace,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.colorF1F1F1,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        LocaleKeys.trade6.tr,
                                        style:
                                            AppTextStyle.f_10_500.color4D4D4D,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(model.firstName,
                                        style:
                                            AppTextStyle.f_14_600.color111111),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(model.secondName,
                                          style: AppTextStyle
                                              .f_12_400.color999999),
                                    ),
                                    4.horizontalSpace,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.colorF1F1F1,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        LocaleKeys.trade6.tr,
                                        style:
                                            AppTextStyle.f_10_500.color4D4D4D,
                                      ),
                                    )
                                  ],
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(model.volStr,
                                style: AppTextStyle
                                    .f_11_400.colorTextTips.ellipsis),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(model.priceStr,
                            textAlign: TextAlign.right,
                            style: AppTextStyle.f_15_600.colorTextPrimary),
                        Padding(
                          padding: EdgeInsets.only(top: 2.w),
                          child: Text(model.desPriceStr,
                              textAlign: TextAlign.right,
                              style: AppTextStyle.f_11_400.color999999),
                        )
                      ],
                    ),
                    Container(
                      width: 70.w,
                      height: 32.w,
                      margin: EdgeInsets.only(left: 12.w),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: model.backColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r)),
                      ),
                      child: Text(model.roseStr,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.f_14_500.colorAlwaysWhite),
                    )
                  ],
                ),
              ));
        });
  }
}

class SearchTextWidget extends StatelessWidget {
  const SearchTextWidget(
      {super.key, this.searchText, required this.name, required this.style});

  final String? searchText;
  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    String text = name;

    if (searchText != null) {
      List<TextSpan> textSpans = [];
      String lowerCaseText = text.toLowerCase();
      String lowerCaseSearchText = searchText!.toLowerCase();

      int index = lowerCaseText.indexOf(lowerCaseSearchText);
      while (index != -1) {
        textSpans.add(
          TextSpan(text: text.substring(0, index), style: style),
        );
        textSpans.add(
          TextSpan(
            text: text.substring(index, index + searchText!.length),
            style: TextStyle(
                color: style.color, backgroundColor: const Color(0XFFFFF2BF)),
          ),
        );
        text = text.substring(index + searchText!.length);
        lowerCaseText = lowerCaseText.substring(index + searchText!.length);
        index = lowerCaseText.indexOf(lowerCaseSearchText);
      }
      if (text.isNotEmpty) {
        textSpans.add(
          TextSpan(text: text, style: style),
        );
      }

      return RichText(
        text: TextSpan(
          children: textSpans,
        ),
      );
    } else {
      return RichText(
        text: TextSpan(children: [TextSpan(text: name, style: style)]),
      );
    }
  }
}
