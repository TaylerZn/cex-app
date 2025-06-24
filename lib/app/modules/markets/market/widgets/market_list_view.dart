import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/markets/market/controllers/markets_index_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_model.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_listview.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_empty.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/markets_top_view.dart';

class MarketList extends StatelessWidget {
  const MarketList(
      {super.key, this.thirdModel, this.secondModel, required this.firstModel, required this.controller, this.fourModel});

  final MarketsFirstModel firstModel;
  final MarketsSecondModel? secondModel;
  final MarketsThirdModel? thirdModel;
  final MarketsFourModel? fourModel;
  final MarketsIndexController controller;

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    if (firstModel.firsttype == MarketFirstType.optional) {
      return fourModel != null
          ? Obx(() => fourModel!.showOptional.value
              ? MarketListEmpty(
                  type: secondModel!.secondType,
                  tagKey: fourModel!.fourTag,
                  shrinkWrap: false,
                  callback: (arr) {
                    controller.addOptional(arr, secondModel!.secondType);
                  },
                )
              : Column(
                  children: <Widget>[
                    MarketFiveTabbar(
                      top: 12,
                      model: secondModel!.fourModel,
                      callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, thirdModel, fourModel, p0, p1),
                    ),
                    Expanded(
                        child: MarketStandardContractListView(
                      refreshVC: fourModel!.refreshVC,
                      tagKey: fourModel!.fourTag,
                      shrinkWrap: false,
                    ))
                  ],
                ))
          : thirdModel != null
              ? Obx(() => thirdModel!.showOptional.value
                  ? MarketListEmpty(
                      type: secondModel!.secondType,
                      tagKey: thirdModel!.thridTag,
                      shrinkWrap: false,
                      callback: (arr) {
                        controller.addOptional(arr, secondModel!.secondType);
                      },
                    )
                  : Column(
                      children: <Widget>[
                        MarketFiveTabbar(
                          top: 4,
                          model: secondModel!.fourModel,
                          callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, thirdModel, null, p0, p1),
                        ),
                        Expanded(
                            child: MarketStandardContractListView(
                          refreshVC: thirdModel!.refreshVC,
                          tagKey: thirdModel!.thridTag,
                          shrinkWrap: false,
                        ))
                      ],
                    ))
              : Obx(() => secondModel!.secondShowOptional.value
                  ? MarketListEmpty(
                      type: secondModel!.secondType,
                      tagKey: secondModel!.secondTag,
                      shrinkWrap: false,
                      callback: (arr) {
                        controller.addOptional(arr, secondModel!.secondType);
                      },
                    )
                  : secondModel!.secondType == MarketSecondType.perpetualContract
                      ? Column(
                          children: <Widget>[
                            MarketFiveTabbar(
                              model: secondModel!.fourModel,
                              callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, null, null, p0, p1),
                            ),
                            Expanded(
                                child: MarketContractListView(
                              refreshVC: secondModel!.refreshVC,
                              tagKey: secondModel!.secondTag,
                              shrinkWrap: false,
                            ))
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            MarketFiveTabbar(
                              model: secondModel!.fourModel,
                              callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, null, null, p0, p1),
                            ),
                            Expanded(
                                child: MarketSpotListView(
                              refreshVC: secondModel!.refreshVC,
                              tagKey: secondModel!.secondTag,
                              shrinkWrap: false,
                            ))
                          ],
                        ));
    } else {
      if (thirdModel != null) {
        if (fourModel != null) {
          return Column(
            children: <Widget>[
              MarketFiveTabbar(
                top: 12,
                model: secondModel!.fourModel,
                callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, thirdModel, fourModel, p0, p1),
              ),
              Expanded(
                  child: MarketStandardContractListView(
                refreshVC: fourModel!.refreshVC,
                tagKey: fourModel!.fourTag,
                shrinkWrap: false,
              ))
            ],
          );
        } else {
          return Column(
            children: <Widget>[
              MarketFiveTabbar(
                top: 12,
                model: secondModel!.fourModel,
                callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, thirdModel, null, p0, p1),
              ),
              Expanded(
                  child: MarketStandardContractListView(
                refreshVC: thirdModel!.refreshVC,
                tagKey: thirdModel!.thridTag,
                shrinkWrap: false,
              ))
            ],
          );
        }
      } else {
        switch (secondModel!.secondType) {
          case MarketSecondType.perpetualContract:
            return Column(
              children: <Widget>[
                MarketFiveTabbar(
                  model: secondModel!.fourModel,
                  callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, null, null, p0, p1),
                ),
                Expanded(
                    child: MarketContractListView(
                  refreshVC: secondModel!.refreshVC,
                  tagKey: secondModel!.secondTag,
                  shrinkWrap: false,
                ))
              ],
            );

          default:
            return Column(
              children: <Widget>[
                MarketFiveTabbar(
                  model: secondModel!.fourModel,
                  callback: (p0, p1) => controller.filterTicker(firstModel, secondModel!, null, null, p0, p1),
                ),
                Expanded(
                    child: MarketSpotListView(
                  refreshVC: secondModel!.refreshVC,
                  tagKey: secondModel!.secondTag,
                  shrinkWrap: false,
                ))
              ],
            );
        }
      }
    }
  }
}
