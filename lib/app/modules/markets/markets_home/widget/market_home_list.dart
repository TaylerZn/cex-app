import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_listview.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_empty.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/markets_top_view.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_home/controllers/markets_home_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_home/model/market_home_model.dart';

class MarketHomeList extends StatelessWidget {
  const MarketHomeList({super.key, this.thirdModel, this.secondModel, required this.firstModel, required this.controller});
  final MarketsHomeFirstModel firstModel;
  final MarketsHomeSecondModel? secondModel;
  final MarketsHomeThirdModel? thirdModel;
  final MarketsHomeController controller;
  @override
  Widget build(BuildContext context) {
    if (firstModel.firsttype == MarketHomeFirstType.optional) {
      if (thirdModel != null) {
        return Obx(() => thirdModel!.showOptional.value
            ? Column(
                children: <Widget>[
                  MarketHomeFourTabbar(
                    model: secondModel!,
                    hiddenSort: true,
                  ),
                  Expanded(
                      child: MarketListEmpty(
                    type: secondModel!.secondType,
                    tagKey: thirdModel!.thridTag,
                    shrinkWrap: true,
                    callback: (arr) {
                      controller.addOptional(arr, secondModel!.secondType);
                    },
                  ))
                ],
              )
            : Column(
                children: <Widget>[
                  MarketHomeFourTabbar(
                    model: secondModel!,
                  ),
                  Expanded(
                      child: MarketStandardContractListView(
                    tagKey: thirdModel!.thridTag,
                    shrinkWrap: true,
                    isOptional: true,
                  ))
                ],
              ));
      } else {
        return Obx(() => secondModel!.secondShowOptional.value
            ? MarketListEmpty(
                type: secondModel!.secondType,
                tagKey: secondModel!.secondTag,
                shrinkWrap: true,
                callback: (arr) {
                  controller.addOptional(arr, secondModel!.secondType);
                },
              )
            : getView(secondModel!.secondTag));
      }
    } else {
      return getView(thirdModel != null ? thirdModel!.thridTag : secondModel!.secondTag);
    }
  }

  Widget getView(String tag, {bool isBuilder = true}) {
    switch (secondModel!.secondType) {
      case MarketSecondType.perpetualContract:
        return Column(
          children: <Widget>[
            MarketHomeFourTabbar(
              model: secondModel!,
              callback: (p0, p1) => null,
            ),
            Expanded(child: MarketContractListView(tagKey: tag, shrinkWrap: true, isBuilder: isBuilder))
          ],
        );
      case MarketSecondType.spot:
        return Column(
          children: <Widget>[
            MarketHomeFourTabbar(
              model: secondModel!,
              callback: (p0, p1) => null,
            ),
            Expanded(child: MarketSpotListView(tagKey: tag, shrinkWrap: true, isBuilder: isBuilder))
          ],
        );

      case MarketSecondType.standardContractOnly:
        return Column(
          children: <Widget>[
            MarketFiveTabbar(
              model: secondModel!.fourModel,
              callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, null, p0, p1),
            ),
            Expanded(child: MarketStandardContractListView(tagKey: tag, shrinkWrap: true, isBuilder: isBuilder))
          ],
        );

      default:
        return Column(
          children: <Widget>[
            MarketHomeFourTabbar(
              model: secondModel!,
              callback: (p0, p1) => null,
            ),
            Expanded(child: MarketStandardContractListView(tagKey: tag, shrinkWrap: true, isBuilder: isBuilder))
          ],
        );
    }
  }
}
