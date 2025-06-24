import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/contract_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/spot_favorite_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../getX/user_Getx.dart';
import 'bottom_sheet_util.dart';

class MoreOptionBottomSheet extends StatefulWidget {
  const MoreOptionBottomSheet({
    super.key,
    required this.onTransfer,
    required this.onTradeRule,
    this.contractInfo,
    this.marketInfoModel,
  });

  final VoidCallback onTransfer;
  final VoidCallback onTradeRule;
  final ContractInfo? contractInfo;
  final MarketInfoModel? marketInfoModel;

  static show(
      {required VoidCallback onTransfer,
      required VoidCallback onTradeRule,
      ContractInfo? contractInfo,
      MarketInfoModel? marketInfoModel}) {
    showBSheet(
      MoreOptionBottomSheet(
        onTransfer: onTransfer,
        onTradeRule: onTradeRule,
        contractInfo: contractInfo,
        marketInfoModel: marketInfoModel,
      ),
    );
  }

  @override
  State<MoreOptionBottomSheet> createState() => _MoreOptionBottomSheetState();
}

class _MoreOptionBottomSheetState extends State<MoreOptionBottomSheet> {
  bool _isOption = false;

  @override
  void initState() {
    if (widget.contractInfo != null) {
      if (widget.contractInfo!.contractType.contains('E')) {
        // 永续合约
        _isOption =
            ContractOptionController.to.isOption(widget.contractInfo!.id);
      } else {
        // 标准合约
        _isOption =
            CommodityOptionController.to.isOption(widget.contractInfo!.id);
      }
    } else if (widget.marketInfoModel != null) {
      // 现货
      _isOption =
          SpotOptionController.to.isOption(widget.marketInfoModel!.symbol);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Text(
          LocaleKeys.trade225.tr,
          style: TextStyle(
            color: AppColor.color111111,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ).marginOnly(left: 16.w),
        20.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCircleBtn(
                'assets/images/contract/transfer.svg', LocaleKeys.trade226.tr,
                () {
              if (UserGetx.to.goIsLogin()) {
                if (widget.contractInfo != null) {
                  if (UserGetx.to.goIsOpenContract()) {
                    widget.onTransfer();
                  }
                } else {
                  widget.onTransfer();
                }
              }
            }),
            _buildCircleBtn(
                'assets/images/contract/withdraw.svg', LocaleKeys.trade227.tr,
                () async {
              if (UserGetx.to.goIsLogin() &&
                  widget.contractInfo != null &&
                  UserGetx.to.goIsOpenContract()) {
                //跳转到资产充值页面
                Get.toNamed(Routes.CURRENCY_SELECT,
                    arguments: {'type': AssetsCurrencySelectEnumn.depoit});
              }
            }),
            _buildCircleBtn(
                _isOption
                    ? 'assets/images/contract/star.svg'
                    : 'assets/images/contract/no_star.svg',
                LocaleKeys.markets26.tr, () async {
              if (UserGetx.to.goIsLogin()) {
                if (widget.contractInfo != null) {
                  if (UserGetx.to.goIsOpenContract()) {
                    if (widget.contractInfo!.contractType.contains('E')) {
                      final res = await ContractOptionController.to
                          .updateContractOption([widget.contractInfo!.id]);
                      _isOption = ContractOptionController.to
                          .isOption(widget.contractInfo!.id);
                      setState(() {});
                    } else {
                      final res = await CommodityOptionController.to
                          .updateContractOption([widget.contractInfo!.id]);
                      _isOption = CommodityOptionController.to
                          .isOption(widget.contractInfo!.id);
                      setState(() {});
                    }
                  }
                } else {
                  if (widget.marketInfoModel != null) {
                    final res = await SpotOptionController.to
                        .updateSpotOption([widget.marketInfoModel!.symbol]);
                    _isOption = SpotOptionController.to
                        .isOption(widget.marketInfoModel!.symbol);
                    setState(() {});
                  }
                }
              }
            }),
            // _buildCircleBtn(
            //     'assets/images/contract/tutorial.svg', '交易规则', onTradeRule),
          ],
        ).marginSymmetric(horizontal: 12.w),
        25.verticalSpace,
        const Divider(),
        MyButton(
          text: LocaleKeys.trade210.tr,
          border: Border.all(color: AppColor.colorBorderGutter, width: 1),
          height: 48.h,
          backgroundColor: Colors.transparent,
          color: AppColor.color111111,
          onTap: () {
            Get.back();
          },
        ).marginAll(16.w),
      ],
    );
  }

  _buildCircleBtn(String icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.w),
              border: Border.all(color: AppColor.colorF5F5F5, width: 1.w),
            ),
            alignment: Alignment.center,
            width: 50.w,
            height: 50.w,
            child: MyImage(
              icon,
              width: 24.w,
            ),
          ),
          5.verticalSpace,
          Text(
            title,
            style: TextStyle(
              color: AppColor.color333333,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
