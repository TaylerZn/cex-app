// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/contract/res/position_res.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/theme/app_color.dart';
import '../../../global/dataStore/commodity_data_store_controller.dart';
import '../../../global/dataStore/contract_data_store_controller.dart';
import '../../../models/contract/res/price_info.dart';
import '../../../models/contract/res/public_info.dart';
import '../../../modules/transation/commodity/models/contract_type.dart';
import 'cancel_config_bottom_button.dart';

enum PositionShareType {
  profitLossRate(LocaleKeys.trade273, 1),
  amountOfCome(LocaleKeys.trade274, 2);

  final String name;
  final int value;

  const PositionShareType(this.name, this.value);
}

class SharePositionView extends StatefulWidget {
  const SharePositionView(
      {super.key, required this.positionInfo, required this.type});

  final PositionInfo positionInfo;
  final ContractType type;

  @override
  State<SharePositionView> createState() => _SharePositionViewState();

  static show(
      {required PositionInfo positionInfo, required ContractType type}) {
    Get.dialog(
      SharePositionView(
        positionInfo: positionInfo,
        type: type,
      ),
      useSafeArea: false,
    );
  }
}

class _SharePositionViewState extends State<SharePositionView> {
  PositionShareType type = PositionShareType.profitLossRate;
  ScreenshotController controller = ScreenshotController();
  String returnRate = '';
  String unrealizedProfit = '';
  ContractInfo? contractInfo;
  PriceInfo? price;

  @override
  void initState() {
    super.initState();
    if (widget.type == ContractType.E) {
      contractInfo = ContractDataStoreController.to
          .getContractInfoByContractId(widget.positionInfo.contractId);
      price = ContractDataStoreController.to.priceMap[contractInfo!.symbol];
    } else {
      contractInfo = CommodityDataStoreController.to
          .getContractInfoByContractId(widget.positionInfo.contractId);
      price = CommodityDataStoreController.to.priceMap[contractInfo!.symbol];
    }

    // 未实现盈亏
    // 多仓（BUY）：未实现盈亏 = 持仓数量*面值*汇率 * （当前标记价格-开仓均价）
    // 空仓（SELL）：未实现盈亏 = 持仓数量*面值*汇率 *（开仓均价-当前标记价格）
    // 回报率 = 未实现盈亏 / 保证金 * 100 (*100 是因为有%)
    num tagPrice = widget.positionInfo.indexPrice;
    if (price != null) {
      tagPrice = price!.tagPrice;
    }

    if (widget.positionInfo.orderSide == 'BUY') {
      unrealizedProfit = (widget.positionInfo.canCloseVolume.toDecimal() *
              (contractInfo?.multiplier ?? 1).toDecimal() *
              (tagPrice.toDecimal() -
                  widget.positionInfo.openAvgPrice.toDecimal()))
          .toString()
          .toNum()
          .toPrecision(
              contractInfo?.coinResultVo?.marginCoinPrecision.toInt() ?? 4);
    } else {
      unrealizedProfit = (widget.positionInfo.canCloseVolume.toDecimal() *
              (contractInfo?.multiplier ?? 1).toDecimal() *
              (widget.positionInfo.openAvgPrice.toDecimal() -
                  tagPrice.toDecimal()))
          .toPrecision(
              contractInfo?.coinResultVo?.marginCoinPrecision.toInt() ?? 4);
    }
    if (widget.positionInfo.holdAmount == 0) {
      returnRate = '--';
    } else {
      returnRate =
          ((unrealizedProfit.toNum() / widget.positionInfo.holdAmount) * 100)
              .toNum()
              .toPrecision(2);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Screenshot(
              controller: controller,
              child: _buildContent(),
            ),
          ),
        ),
        _buildBottom(),
      ],
    );
  }

  Widget _buildContent() {
    ContractInfo? contractInfo;
    if (widget.type == ContractType.E) {
      contractInfo = ContractDataStoreController.to
          .getContractInfoByContractId(widget.positionInfo.contractId);
    } else {
      contractInfo = CommodityDataStoreController.to
          .getContractInfoByContractId(widget.positionInfo.contractId);
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColor.colorBlack,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      width: 313.w,
      height: 294.h,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: MyImage(
              'assets/images/contract/position_share_img.svg',
              width: 313.w,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 69.h,
              width: 313.w,
              color: AppColor.color1A1A1A,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  20.horizontalSpace,
                  UserAvatar(
                    UserGetx.to.user?.info?.profilePictureUrl,
                    width: 36.w,
                    height: 36.w,
                  ),
                  6.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(
                          UserGetx.to.userName ?? '',
                          style: AppTextStyle.f_14_400.colorWhite,
                          maxLines: 1,
                          minFontSize: 10,
                        ),
                        Text(
                          DateUtil.formatDate(DateTime.now(),
                              format: 'MM-dd HH:mm'),
                          style: AppTextStyle.f_12_400.color7E7E7E,
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        UserGetx.to.user?.info?.inviteCode ?? '',
                        style: AppTextStyle.f_14_400.colorWhite,
                      ),
                      Text(
                        LocaleKeys.trade283.tr,
                        style: AppTextStyle.f_12_400.color999999,
                      )
                    ],
                  ),
                  10.horizontalSpace,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: QrImageView(
                      data: UserGetx.to.user?.info?.inviteUrl ?? '',
                      version: QrVersions.auto,
                      size: 36.w,
                      backgroundColor: AppColor.colorWhite,
                      padding: const EdgeInsets.all(2),
                    ),
                  ),
                  20.horizontalSpace,
                ],
              ),
            ),
          ),
          Positioned(
            left: 20.h,
            top: 64.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${contractInfo?.firstName}${contractInfo?.secondName} ${widget.type == ContractType.E ? LocaleKeys.trade7.tr : LocaleKeys.trade6.tr}",
                      style: AppTextStyle.f_14_400.colorWhite,
                    ),
                    Container(
                      width: 1,
                      height: 10,
                      color: AppColor.colorWhite,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                    Text(
                      widget.positionInfo.orderSide == 'SELL'
                          ? LocaleKeys.trade103.tr
                          : LocaleKeys.trade104.tr,
                      style: AppTextStyle.f_14_400.copyWith(
                        color: widget.positionInfo.orderSide == 'SELL'
                            ? AppColor.downColor
                            : AppColor.upColor,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 10,
                      color: AppColor.colorWhite,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                    Text(
                      '${widget.positionInfo.leverageLevel}X',
                      style: AppTextStyle.f_14_400.colorWhite,
                    ),
                  ],
                ),
                10.verticalSpace,
                type == PositionShareType.profitLossRate
                    ? Text(
                        '${returnRate.toNum() > 0 ? '+' : ''}$returnRate%',
                        style: AppTextStyle.f_38_600.copyWith(
                          color: returnRate.toNum() > 0
                              ? AppColor.upColor
                              : AppColor.downColor,
                        ),
                      )
                    : Text(
                        '${unrealizedProfit.toNum() > 0 ? '+' : ''}$unrealizedProfit ${contractInfo?.quote ?? 'USDT'}',
                        style: AppTextStyle.f_38_600.copyWith(
                          color: unrealizedProfit.toNum() > 0
                              ? AppColor.upColor
                              : AppColor.downColor,
                        ),
                      ),
                16.verticalSpace,
                _titleAndDes(
                    LocaleKeys.trade166.tr,
                    widget.positionInfo.openAvgPrice.toPrecision(contractInfo
                            ?.coinResultVo?.symbolPricePrecision
                            .toInt() ??
                        6)),
                8.verticalSpace,
                _titleAndDes(
                    LocaleKeys.trade275.tr,
                    contractInfo?.close.toPrecision(contractInfo
                                ?.coinResultVo?.symbolPricePrecision
                                .toInt() ??
                            6) ??
                        '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleAndDes(String title, String dec) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.f_12_400.color999999,
        ),
        8.horizontalSpace,
        Text(
          dec,
          style: AppTextStyle.f_12_400.colorCCCCCC,
        ),
      ],
    );
  }

  Widget _buildBottom() {
    return Container(
      decoration: BoxDecoration(
        // 顶部圆角
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        color: AppColor.bgColorLight,
      ),
      padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              19.verticalSpace,
              Text(
                LocaleKeys.trade276.tr,
                style: AppTextStyle.f_20_600.color333333,
              ),
              19.verticalSpace,
              Row(
                children: [
                  _buildbtn(PositionShareType.profitLossRate,
                      type == PositionShareType.profitLossRate, () {
                    setState(() {
                      type = PositionShareType.profitLossRate;
                    });
                  }),
                  44.horizontalSpace,
                  _buildbtn(PositionShareType.amountOfCome,
                      type == PositionShareType.amountOfCome, () {
                    setState(() {
                      type = PositionShareType.amountOfCome;
                    });
                  })
                ],
              ),
            ],
          ).marginSymmetric(horizontal: 16.w),
          16.verticalSpace,
          Divider(
            height: 1.h,
            color: AppColor.colorF5F5F5,
          ),
          16.verticalSpace,
          CancelConfirmBottomButton(onCancel: () {
            Get.back();
          }, onConfirm: () {
            _onShare();
          }).marginSymmetric(horizontal: 16.w),
          Get.mediaQuery.padding.bottom.verticalSpace,
        ],
      ),
    );
  }

  Future<void> _onShare() async {
    controller
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);
        Share.shareXFiles(
          [XFile(imagePath.path)],
        );
      }
    });
  }

  Widget _buildbtn(
      PositionShareType type, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyImage(
            isSelected
                ? 'assets/images/contract/icon_check.svg'
                : 'assets/images/contract/icon_check_nor.svg',
            width: 14.w,
          ),
          2.horizontalSpace,
          Text(type.name.tr, style: AppTextStyle.f_14_500.color111111),
        ],
      ),
    );
  }
}
