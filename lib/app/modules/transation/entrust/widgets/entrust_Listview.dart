import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_entrust/widgets/current_entrust_item.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/controllers/entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_enum.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_flow_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_historical_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_filter.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/number_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//

class EntrustListView extends StatelessWidget {
  EntrustListView({super.key, required this.transactionModel, required this.controller});
  final TransactionModel transactionModel;
  final EntrustController controller;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: transactionModel.refreshVC,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async {
        await controller.getData(isPullDown: true);
        transactionModel.refreshVC.refreshToIdle();
        transactionModel.refreshVC.loadComplete();
      },
      onLoading: () async {
        if (transactionModel.data.value.haveMore) {
          transactionModel.data.value.page++;
          await controller.getData();
          transactionModel.refreshVC.loadComplete();
        } else {
          transactionModel.refreshVC.loadNoData();
        }
      },
      child: CustomScrollView(
        slivers: <Widget>[
          transactionModel.filterModelArray != null
              ? EntrustFilter(model: transactionModel, controller: controller)
              : SliverToBoxAdapter(child: SizedBox(height: 20.w)),
          (transactionModel.type == BehaviorType.currentEntrust || transactionModel.type == BehaviorType.historyEntrust)
              ? Obx(() => transactionModel.orderData.value.size < 0
                  ? const FollowOrdersLoading()
                  : transactionModel.orderData.value.data.isEmpty
                      ? const FollowOrdersLoading(isError: false)
                      : SliverList(
                          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                            return getCell(transactionModel.orderData.value.data[index], currentIndex: index);
                          }, childCount: transactionModel.orderData.value.data.length),
                        ))
              : Obx(() => transactionModel.data.value.orderList?.isNotEmpty == true
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                        return getCell(transactionModel.data.value.orderList![index], currentIndex: index);
                      }, childCount: transactionModel.data.value.orderList!.length),
                    )
                  : FollowOrdersLoading(
                      isError: transactionModel.data.value.isError,
                      onTap: () {
                        controller.getData(isPullDown: true);
                      }))
        ],
      ),
    );
  }

  Widget getCell(model, {int currentIndex = 0}) {
    switch (transactionModel.type) {
      case BehaviorType.currentEntrust: //当前委托
        return getCurrentEntrust(model, currentIndex: currentIndex);
      case BehaviorType.historyEntrust: //历史委托
        return getHistoryEntrust(model);
      case BehaviorType.locationHistory: //仓位历史
        // return getLocationHistory(model);
        return const SizedBox();
      case BehaviorType.historicalTrans: //历史成交
        return getHistoricalTrans(model);
      case BehaviorType.flowFunds: //资金流水
        return getFlowFunds(model);
      case BehaviorType.capitalCost: //资金费用
        // return getCapitalCost(model);
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget getCurrentEntrust(OrderInfo model, {int currentIndex = 0}) {
    return CurrentEntrustItem(
      orderInfo: model,
      isCommodity: false,
      onTap: () {
        controller.cancelOrder(orderId: model.id, contractId: model.contractId, currentIndex: currentIndex);
      },
    );
  }

  final leftStyle = TextStyle(
    fontSize: 13.sp,
    color: AppColor.color666666,
    fontWeight: FontWeight.w400,
  );
  final rightStyle = TextStyle(
    fontSize: 13.sp,
    color: AppColor.color111111,
    fontWeight: FontWeight.w500,
  );
  // Widget getHistoryEnddddddtrust(TransactionHistoryEntrustModel model) {}

  Widget getHistoryEntrust(OrderInfo model) {
    Color sideColor = model.side == 'SELL' ? AppColor.colorDanger : AppColor.colorSuccess;

    // String get name => '$contractOtherName 永续';
    // String get time => DateUtil.formatDateMs(ctime.toInt());
    // String get priceStr => avgPrice.toStringAsFixed(pricePrecision.toInt());
    List<String> tagArray = [
      model.type == 1 ? LocaleKeys.trade44.tr : LocaleKeys.trade28.tr,
      model.getOpenSide(model.open, model.side)
    ];
    // String get statusStr => getStatusStr(status);
    // var dealVolumeStr = model.dealVolume.toString();
    var avgPriceStr = model.getmConvert(model.avgPrice);
    var priceStr = model.getmConvert(model.price);
    var type = model.symbol.contains('-') == true ? model.symbol.split('-').first : '';

    var closePositionStatus = model.open == 'CLOSE' ? LocaleKeys.trade98.tr : LocaleKeys.trade99.tr;

    ContractInfo? contractInfo = ContractDataStoreController.to.getContractInfoByContractId(model.contractId);
    contractInfo ??= CommodityDataStoreController.to.getContractInfoByContractId(model.contractId);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.symbol, style: AppTextStyle.f_15_500.color111111),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                    margin: EdgeInsets.only(left: 6.w),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColor.colorF5F5F5),
                    child: Text(LocaleKeys.trade7.tr, style: AppTextStyle.f_10_500.color4D4D4D),
                  ),
                  const Spacer(),
                  Text(DateUtil.formatDateMs(model.ctime.toInt()), style: AppTextStyle.f_11_400.color999999),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              getTag(tagArray, sideColor)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h, top: 18.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${LocaleKeys.trade27.tr} ($type)', style: leftStyle),
                // Text('$dealVolumeStr/$dealVolumeStr', style: rightStyle),

                // Text(
                //     '${model.dealVolume.toDecimal() * (contractInfo?.multiplier.toDecimal() ?? 1.toDecimal())}/${model.volume.toDecimal() * (contractInfo?.multiplier.toDecimal() ?? 1.toDecimal())}',
                //     style: rightStyle),
                Builder(builder: (context) {
                  // 市价需要 数量 = volume / 触发价
                  // 其他的数量 = volume * 面值
                  String dealVolume = '';
                  String volume = '';
                  Decimal tiggerPrice = Decimal.one;
                  if (model.type == 2 && model.triggerType != 0 && model.triggerPrice != null) {
                    tiggerPrice = model.triggerPrice.toString().toDecimal();
                    dealVolume = (model.dealVolume.toDecimal() / tiggerPrice).toDecimal(scaleOnInfinitePrecision: 4).toString();
                    volume = (model.volume.toDecimal() / tiggerPrice).toDecimal(scaleOnInfinitePrecision: 4).toString();
                  } else {
                    dealVolume =
                        (model.dealVolume.toDecimal() * (contractInfo?.multiplier.toDecimal() ?? 1.toDecimal())).toString();
                    volume = (model.volume.toDecimal() * (contractInfo?.multiplier.toDecimal() ?? 1.toDecimal())).toString();
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(dealVolume, style: rightStyle),
                      Text('/$volume', style: rightStyle),
                    ],
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade34.tr, style: leftStyle),
                Text('$avgPriceStr/$priceStr', style: rightStyle),
              ],
            ),
          ),
          model.triggerType != 0
              ? Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(LocaleKeys.trade160.tr, style: leftStyle),
                      Text('${LocaleKeys.follow179.tr}${model.gt ? '≥' : '≤'} ${model.triggerPrice}', style: rightStyle),
                    ],
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade45.tr, style: leftStyle),
                Text(closePositionStatus, style: rightStyle),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(LocaleKeys.trade43.tr, style: leftStyle),
              Text(model.getStatusStr(model.status),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.upColor,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget getHistoricalTrans(TransactionHistoricalTransModel model) {
    ContractInfo? contractInfo = ContractDataStoreController.to.getContractInfoByContractId(model.contractId ?? 0);

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20.h),
      padding: EdgeInsets.only(bottom: 20.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColor.color111111,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(
                      height: 6.h,
                    ),
                    getTag([model.openSide], model.sideColor),
                  ],
                ),
                Text(model.time,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColor.color999999,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade34.tr, style: leftStyle),
                Text(model.priceStr, style: rightStyle),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${LocaleKeys.trade27.tr} (${model.type})', style: leftStyle),
                Text(
                    NumberUtil.mConvert(
                      (model.volume ?? 0) * (contractInfo?.multiplier ?? 1),
                      count: contractInfo?.multiplier.numDecimalPlaces() ?? 2,
                    ),
                    style: rightStyle),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${LocaleKeys.trade51.tr} (USDT)', style: leftStyle),
                Text(model.feeStr, style: rightStyle),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade50.tr, style: leftStyle),
                Text(model.role, style: rightStyle),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${LocaleKeys.trade171.tr} (USDT) ', style: leftStyle),
              Text(model.realizedAmountStr, style: AppTextStyle.f_13_500.copyWith(color: model.realizedAmountColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget getFlowFunds(TransactionFlowFundsModel model) {
    // ContractInfo? contractInfo = ContractDataStoreController.to.getContractInfoByContractId(model.contractId);
    // contractInfo ??= CommodityDataStoreController.to.getContractInfoByContractId(model.contractId);

    // Text(
    //     '${model.dealVolume.toDecimal() * (contractInfo?.multiplier.toDecimal() ?? 1.toDecimal())}/${model.volume.toDecimal() * (contractInfo?.multiplier.toDecimal() ?? 1.toDecimal())}',
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(model.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w500,
                  )),
              Text(model.time,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColor.color999999,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade53.tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.color666666,
                      fontWeight: FontWeight.w400,
                    )),
                Text(model.typeStr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.color111111,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade2.tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.color666666,
                      fontWeight: FontWeight.w400,
                    )),
                Text(model.contractNameStr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.color111111,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(LocaleKeys.trade54.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.color666666,
                    fontWeight: FontWeight.w400,
                  )),
              Text(model.amountStr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTag(List<String> array, Color color) {
    return Row(
      children: array
          .map((e) => Container(
                padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
                margin: EdgeInsets.only(right: 6.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: color.withOpacity(0.1)),
                child: Text(e,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: color,
                      fontWeight: FontWeight.w400,
                    )),
              ))
          .toList(),
    );
  }

  // Widget getCapitalCost(TransactionCapitalCost model) {
  //   return Container(
  //     margin: EdgeInsets.only(left: 16, right: 16, bottom: 20.h),
  //     padding: EdgeInsets.only(bottom: 20.h),
  //     decoration: const BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
  //       ),
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Text('USDT',
  //                 style: TextStyle(
  //                   fontSize: 15.sp,
  //                   color: AppColor.color111111,
  //                   fontWeight: FontWeight.w500,
  //                 )),
  //             Text('2022-12-22 3:32:32',
  //                 style: TextStyle(
  //                   fontSize: 11.sp,
  //                   color: AppColor.color999999,
  //                   fontWeight: FontWeight.w400,
  //                 )),
  //           ],
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text('合约',
  //                   style: TextStyle(
  //                     fontSize: 13.sp,
  //                     color: AppColor.color666666,
  //                     fontWeight: FontWeight.w400,
  //                   )),
  //               Text('BTC/USDT 永续',
  //                   style: TextStyle(
  //                     fontSize: 13.sp,
  //                     color: AppColor.color111111,
  //                     fontWeight: FontWeight.w500,
  //                   )),
  //             ],
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Text('总额',
  //                 style: TextStyle(
  //                   fontSize: 13.sp,
  //                   color: AppColor.color666666,
  //                   fontWeight: FontWeight.w400,
  //                 )),
  //             Text('-0.1048 ',
  //                 style: TextStyle(
  //                   fontSize: 13.sp,
  //                   color: AppColor.color111111,
  //                   fontWeight: FontWeight.w500,
  //                 )),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget getLocationHistory(TransactionLocationHistory model) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 20.h),
  //     padding: EdgeInsets.only(left: 16, right: 16, bottom: 20.h),
  //     decoration: const BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
  //       ),
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Padding(
  //           padding: EdgeInsets.only(bottom: 16.h),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 3.h),
  //                         margin: EdgeInsets.only(right: 6.w),
  //                         decoration:
  //                             BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColor.downColor.withOpacity(0.1)),
  //                         child: Text('卖 ',
  //                             style: TextStyle(
  //                               fontSize: 11.sp,
  //                               color: AppColor.downColor,
  //                               fontWeight: FontWeight.w400,
  //                             )),
  //                       ),
  //                       Text('BTC/USDT 永续',
  //                           style: TextStyle(
  //                             fontSize: 14.sp,
  //                             color: AppColor.color111111,
  //                             fontWeight: FontWeight.w500,
  //                           )),
  //                       Container(
  //                         padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 3.5.h),
  //                         margin: EdgeInsets.only(left: 6.w),
  //                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColor.colorF5F5F5),
  //                         child: Text('全仓15X',
  //                             style: TextStyle(
  //                               fontSize: 10.sp,
  //                               color: AppColor.color333333,
  //                               fontWeight: FontWeight.w500,
  //                             )),
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 3.5.h),
  //                     margin: EdgeInsets.only(right: 12.w),
  //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColor.colorF5F5F5),
  //                     child: Text('全仓15X',
  //                         style: TextStyle(
  //                           fontSize: 10.sp,
  //                           color: AppColor.color333333,
  //                           fontWeight: FontWeight.w500,
  //                         )),
  //                   ),
  //                   const Icon(
  //                     Icons.share,
  //                     size: 12,
  //                     color: AppColor.color111111,
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(bottom: 16.h),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('平仓盈亏 ',
  //                       style: TextStyle(
  //                         fontSize: 11.sp,
  //                         color: AppColor.color999999,
  //                         fontWeight: FontWeight.w400,
  //                       )),
  //                   SizedBox(height: 9.h),
  //                   Text('12.92',
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                         color: AppColor.downColor,
  //                         fontWeight: FontWeight.w700,
  //                       )),
  //                 ],
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('未实现盈亏',
  //                       style: TextStyle(
  //                         fontSize: 11.sp,
  //                         color: AppColor.color999999,
  //                         fontWeight: FontWeight.w400,
  //                       )),
  //                   SizedBox(height: 9.h),
  //                   Text('1.09',
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                         color: AppColor.downColor,
  //                         fontWeight: FontWeight.w700,
  //                       )),
  //                 ],
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Text('已平仓量',
  //                       style: TextStyle(
  //                         fontSize: 11.sp,
  //                         color: AppColor.color999999,
  //                         fontWeight: FontWeight.w400,
  //                       )),
  //                   SizedBox(height: 9.h),
  //                   Text('12.92',
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                         color: AppColor.color111111,
  //                         fontWeight: FontWeight.w700,
  //                       )),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(bottom: 18.h),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('开仓价格',
  //                       style: TextStyle(
  //                         fontSize: 11.sp,
  //                         color: AppColor.color999999,
  //                         fontWeight: FontWeight.w400,
  //                       )),
  //                   SizedBox(height: 2.h),
  //                   Text('0.0057',
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                         color: AppColor.color4D4D4D,
  //                         fontWeight: FontWeight.w500,
  //                       )),
  //                 ],
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('平仓均价',
  //                       style: TextStyle(
  //                         fontSize: 11.sp,
  //                         color: AppColor.color999999,
  //                         fontWeight: FontWeight.w400,
  //                       )),
  //                   SizedBox(height: 2.h),
  //                   Text('147.1  ',
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                         color: AppColor.color4D4D4D,
  //                         fontWeight: FontWeight.w500,
  //                       )),
  //                 ],
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Text('最大持仓量',
  //                       style: TextStyle(
  //                         fontSize: 11.sp,
  //                         color: AppColor.color999999,
  //                         fontWeight: FontWeight.w400,
  //                       )),
  //                   SizedBox(height: 2.h),
  //                   Text('0.0425BTC',
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                         color: AppColor.color111111,
  //                         fontWeight: FontWeight.w500,
  //                       )),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(bottom: 12.h),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text('开仓时间',
  //                   style: TextStyle(
  //                     fontSize: 11.sp,
  //                     color: AppColor.color999999,
  //                     fontWeight: FontWeight.w400,
  //                   )),
  //               Text('2024-02-20 19:33:06',
  //                   style: TextStyle(
  //                     fontSize: 11.sp,
  //                     color: AppColor.color111111,
  //                     fontWeight: FontWeight.w500,
  //                   )),
  //             ],
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Text('全部平仓时间',
  //                 style: TextStyle(
  //                   fontSize: 11.sp,
  //                   color: AppColor.color999999,
  //                   fontWeight: FontWeight.w400,
  //                 )),
  //             Text('--',
  //                 style: TextStyle(
  //                   fontSize: 11.sp,
  //                   color: AppColor.color111111,
  //                   fontWeight: FontWeight.w500,
  //                 )),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
