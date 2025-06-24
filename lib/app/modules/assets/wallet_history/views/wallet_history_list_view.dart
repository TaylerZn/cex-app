import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/assets/assets_convert_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spot_trade_history.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/controllers/wallet_history_list_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_enum.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_model.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/widgets/wallet_history_filter.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/spots/spots_trade_make.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletHistoryListView extends GetView<WalletHistoryListController> {
  final WalletHistoryType currentType;
  final WalletHistoryFilterModel model;
  // 接收参数的构造函数
  const WalletHistoryListView({
    super.key,
    required this.currentType,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    if (model.isFirst.value) {
      controller.getListData(currentType, model);
    }
    if (currentType == WalletHistoryType.bonus) {
      return buildWalletHistoryList(filterViewType: WalletHistoryFilterViewType.timePicker);
    } else if (currentType == WalletHistoryType.conver) {
      return buildWalletHistoryList(filterViewType: WalletHistoryFilterViewType.allBtnFilterPicker); //全部btn + 筛选btn
    } else {
      return buildWalletHistoryList(filterViewType: WalletHistoryFilterViewType.filterPicker);
    }
  }

  Widget buildWalletHistoryList({
    WalletHistoryFilterViewType filterViewType = WalletHistoryFilterViewType.filterPicker,
  }) {
    return GetBuilder<WalletHistoryListController>(builder: (controller) {
      return Column(
        children: [
          WalletHistoryFilter(
              model: model,
              viewType: filterViewType,
              onChangeTap: () async {
                controller.page = 1;
                model.isFirst.value = true;
                model.loadingController.value.setLoading();
                await controller.getListData(currentType, model);
              }),
          Expanded(child: Obx(() {
            return SmartRefresher(
                controller: model.refreshVc,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  controller.page = 1;
                  model.isFirst.value = true;
                  await controller.getListData(currentType, model);
                  model.refreshVc.refreshToIdle();
                },
                onLoading: () async {
                  if (controller.haveMore) {
                    controller.page++;
                    await controller.getListData(currentType, model);
                    model.refreshVc.loadComplete();
                  } else {
                    model.refreshVc.loadNoData();
                  }
                },
                child: MyPageLoading(
                    controller: model.loadingController.value,
                    body: WaterfallFlow.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 0.w,
                          mainAxisSpacing: 0.w,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.getListByType(currentType).length,
                        itemBuilder: (context, index) {
                          return getCell(index);
                        })));
          }))
        ],
      );
    });
  }

  Widget getCell(int index) {
    final data = controller.getListByType(currentType)[index];
    switch (currentType) {
      case WalletHistoryType.topUp:
      case WalletHistoryType.withdrawal:
        AssetsHistoryRecordItem item = data;
        return InkWell(
            onTap: () {
              //    Get.toNamed(Routes.WITHDRAW_DETAIL,arguments: {'data':item});
            },
            child: Container(
              //margin: const EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("${item.coinSymbol ?? '--'}", style: AppTextStyle.f_14_500.color111111),
                        Text("${item.amount ?? '--'}", style: AppTextStyle.f_14_500.color111111),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(item.createdAtTime != null ? MyTimeUtil.timestampToStr(item.createdAtTime) : '',
                          style: AppTextStyle.f_10_400.colorTextDescription),
                      16.horizontalSpace,
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          getStatusWidget(item.status),
                          4.horizontalSpace,
                          Flexible(
                            child: Text((item.statusText ?? '--').stringSplit(),
                                style: AppTextStyle.f_11_400.colorTextDescription),
                          )
                        ],
                      ))
                    ],
                  ),
                ],
              ),
            ));

      case WalletHistoryType.spotTrading:
        SpotsTradeHistoryListModel item = data;
        return SpotsTradeMakeView(item: item);
      case WalletHistoryType.conver:
        AssetsConvertRecordItem item = data;
        return _getConverCell(item);
      case WalletHistoryType.bonus:
        AssetsHistoryRecordItem item = data;
        return Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 调整对齐方式
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.assets55.tr, //"币种",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.color999999,
                            fontWeight: FontWeight.w500,
                          )),
                      Text("${item.coinSymbol ?? '--'}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.color111111,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(LocaleKeys.assets79.tr, //"数量",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.color999999,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(item.amount != null ? '+${item.amount}' : '--',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColor.colorSuccess, // 数量为绿色
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(LocaleKeys.assets135.tr, //"发布时间",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.color999999,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(item.createdAtTime != null ? MyTimeUtil.timestampToStr(item.createdAtTime) : '',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.color999999,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(LocaleKeys.assets136.tr, //"发布账户",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.color999999,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(item.statusTextMapping,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.color999999,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              item.bonusType.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(LocaleKeys.trade53.tr, //"发布账户",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.color999999,
                              fontWeight: FontWeight.w500,
                            )),
                        Text(item.bonusType,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.color999999,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ).paddingOnly(top: 10.w)
                  : const SizedBox(),
            ],
          ),
        );
      default:
        AssetsHistoryRecordItem item = data;
        return Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.symmetric(vertical: 20.h),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(item.transferType == null ? "" : item.transferType.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor.color111111,
                          fontWeight: FontWeight.w500,
                        )),
                    Text('${item.amount ?? '0.0'} ${item.coinSymbol ?? '-- '}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.color999999,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      item.createdAtTime != null
                          ? item.createdAtTime is String
                              ? item.createdAtTime //后台返回是string,会是一个日期
                              : MyTimeUtil.timestampToStr(item.createdAtTime)
                          : '',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.color999999,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ],
          ),
        );
    }
  }

  Widget getTag() {
    List<String> array = [LocaleKeys.assets121.tr, LocaleKeys.assets122.tr];

    return Row(
      children: array
          .map((e) => Container(
                padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
                margin: EdgeInsets.only(right: 6.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColor.downColor.withOpacity(0.1)),
                child: Text(e,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.downColor,
                      fontWeight: FontWeight.w400,
                    )),
              ))
          .toList(),
    );
  }

  Widget getStatusWidget(int status) {
    Color? color;
    // 0 未确认，1 已完成，2 异常
    switch (status) {
      case 0:
        color = AppColor.colorAbnormal;
        break;
      case 1:
        color = AppColor.colorSuccess;
        break;
      case 2:
        color = AppColor.colorDanger;
        break;
      default:
        color = null;
    }

    return color != null
        ? Container(
            width: 4.w,
            height: 4.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          )
        : 0.horizontalSpace;
  }

  Widget _getConverCell(AssetsConvertRecordItem item) {
    return Container(
      // height: 152.h,
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      padding: EdgeInsets.only(top: 17.h, bottom: 3.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${item.leftVolume ?? '--'} ${item.leftCoin ?? '--'}",
                style: AppTextStyle.f_16_500.color111111,
                maxLines: 1,
              ),
            ),
            // Spacer(),
            MyImage(
              'trade/convert_arrow_icon'.svgAssets(),
              width: 16.w,
              height: 16.w,
            ),
            // Spacer(),
            Expanded(
              child: Text(
                "${item.rightVolume ?? '--'} ${item.rightCoin ?? '--'}",
                style: AppTextStyle.f_16_500.color111111,
                textAlign: TextAlign.right, // 确保文本右对齐
                maxLines: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              LocaleKeys.trade308.tr, //兑换率
              style: AppTextStyle.f_12_500.color999999,
            ),
            Text(
              "${item.coverRate}",
              style: AppTextStyle.f_12_500.color999999,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              LocaleKeys.trade327.tr, //支付方式
              style: AppTextStyle.f_12_500.color999999,
            ),
            Text(
              LocaleKeys.trade306.tr, //现货账户
              style: AppTextStyle.f_12_500.color999999,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              LocaleKeys.trade307.tr, //交易手续费
              style: AppTextStyle.f_12_500.color999999,
            ),
            Text(
              LocaleKeys.trade293.tr, //0手续费
              style: AppTextStyle.f_12_500.colorSuccess,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              item.ctime == null ? " " : MyTimeUtil.timestampToStr(item.ctime! ?? 0),
              style: AppTextStyle.f_12_400.color999999,
            ),
            // Text(
            //   item.status == "1"
            //       ? LocaleKeys.public12.tr //成功
            //       : LocaleKeys.public13.tr, //失败
            //   style: item.status == "1"
            //       ? AppTextStyle.small_400.colorSuccess
            //       : AppTextStyle.small_400.color999999,
            // ),
            item.status == "2" //失败
                ? Text(
                    LocaleKeys.public13.tr, //失败
                    style: AppTextStyle.f_12_400.color999999,
                  )
                : item.status == "1" // 成功
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: ShapeDecoration(
                              color: AppColor.colorSuccess,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(41),
                              ),
                            ),
                          ),
                          Text(
                            LocaleKeys.public12.tr, //成功
                            style: AppTextStyle.f_12_400.color999999,
                          ),
                        ],
                      )
                    : 0.horizontalSpace,
          ],
        ),
        SizedBox(height: 20.h),
        Divider(height: 1, color: AppColor.colorEEEEEE),
      ]),
    );
  }
}
