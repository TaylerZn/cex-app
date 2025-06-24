import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_cell_model.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_shimmer.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_sliver.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MarketStandardContractListView extends StatelessWidget {
  const MarketStandardContractListView(
      {super.key,
      required this.tagKey,
      this.shrinkWrap = false,
      this.refreshVC,
      this.isBuilder = true,
      this.isOptional = false});

  final String tagKey;
  final bool shrinkWrap;
  final RefreshController? refreshVC;
  final bool isBuilder;
  final bool isOptional;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketsCellModel>(
      builder: (cellModel) {
        return cellModel.commodityList != null
            ? cellModel.commodityList!.isNotEmpty
                ? refreshVC == null
                    ? getListView(cellModel)
                    : SmartRefresher(
                        controller: refreshVC!,
                        enablePullDown: true,
                        onRefresh: () async {
                          await MarketDataManager.instance.getData(type: MarketSecondType.standardContract);
                          refreshVC!.refreshToIdle();
                          refreshVC!.loadComplete();
                        },
                        child: getListView(cellModel))
                : isBuilder
                    ? CustomScrollView(slivers: [
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: EdgeInsets.only(top: 100.h),
                          child: noDataWidget(context, text: LocaleKeys.public8.tr),
                        ))
                      ])
                    : noDataWidget(context, text: LocaleKeys.public8.tr)
            : const MarketShimmer();
      },
      tag: tagKey,
    );
  }

  getListView(MarketsCellModel cellModel) {
    return CustomScrollView(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
      slivers: [
        StandardContractSliver(commodityList: cellModel.commodityList!, isBuilder: isBuilder),
        HomeMarketMoreButton(shrinkWrap: shrinkWrap, isOptional: isOptional, length: cellModel.commodityList!.length)
      ],
    );
  }
}

class MarketContractListView extends StatelessWidget {
  const MarketContractListView(
      {super.key, required this.tagKey, this.shrinkWrap = false, this.refreshVC, this.isBuilder = true});

  final String tagKey;
  final bool shrinkWrap;
  final RefreshController? refreshVC;
  final bool isBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketsCellModel>(
      builder: (cellModel) {
        return cellModel.contractList != null
            ? cellModel.contractList!.isNotEmpty
                ? refreshVC == null
                    ? getListView(cellModel.contractList!)
                    : SmartRefresher(
                        controller: refreshVC!,
                        enablePullDown: true,
                        onRefresh: () async {
                          await MarketDataManager.instance.getData(type: MarketSecondType.perpetualContract);
                          refreshVC!.refreshToIdle();
                          refreshVC!.loadComplete();
                        },
                        child: getListView(cellModel.contractList!))
                : CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: noDataWidget(context, text: LocaleKeys.public8.tr),
                    ))
                  ])
            : const MarketShimmer();
      },
      tag: tagKey,
    );
  }

  getListView(List<ContractInfo> contractList) {
    return CustomScrollView(
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
        slivers: [
          ContractSliver(contractList: contractList, isBuilder: isBuilder),
          HomeMarketMoreButton(
            shrinkWrap: shrinkWrap,
            length: contractList.length,
          )
        ]);
  }
}

class MarketSpotListView extends StatelessWidget {
  const MarketSpotListView({super.key, required this.tagKey, this.shrinkWrap = false, this.refreshVC, this.isBuilder = true});

  final String tagKey;
  final bool shrinkWrap;
  final RefreshController? refreshVC;
  final bool isBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketsCellModel>(
      builder: (cellModel) {
        return cellModel.marketList != null
            ? cellModel.marketList!.isNotEmpty
                ? refreshVC == null
                    ? getListView(cellModel)
                    : SmartRefresher(
                        controller: refreshVC!,
                        enablePullDown: true,
                        onRefresh: () async {
                          await MarketDataManager.instance.getData(type: MarketSecondType.spot);
                          refreshVC!.refreshToIdle();
                          refreshVC!.loadComplete();
                        },
                        child: getListView(cellModel))
                : CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: noDataWidget(context, text: LocaleKeys.public8.tr),
                    ))
                  ])
            : const MarketShimmer();
      },
      tag: tagKey,
    );
  }

  getListView(MarketsCellModel cellModel) {
    return CustomScrollView(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
      slivers: [
        SpotSliver(marketList: cellModel.marketList!, isBuilder: isBuilder),
        HomeMarketMoreButton(shrinkWrap: shrinkWrap, length: cellModel.marketList!.length),
      ],
    );
  }
}

class HomeMarketMoreButton extends StatelessWidget {
  const HomeMarketMoreButton({super.key, required this.shrinkWrap, this.isOptional = false, required this.length});

  final bool shrinkWrap;
  final bool isOptional;
  final int length;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: shrinkWrap && length > 3
          ? GestureDetector(
              onTap: () {
                MarketDataManager.instance.changeMarketIndex(marketIndex: isOptional ? 0 : 1);
              },
              child: Container(
                height: 36.w,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w, bottom: 0),
                decoration: BoxDecoration(
                  color: AppColor.colorBackgroundSecondary,
                  borderRadius: BorderRadius.circular(60.r),
                ),
                child: Text(LocaleKeys.community91.tr, textAlign: TextAlign.right, style: AppTextStyle.f_14_400.colorTextTips),
              ),
            )
          : const SizedBox(),
    );
  }
}
