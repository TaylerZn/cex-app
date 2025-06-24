import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/models/contract_type.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../models/contract/res/change_position_amount_info.dart';
import '../../../../models/contract/res/position_res.dart';
import '../../../../models/contract/res/public_info.dart';
import '../cancel_config_bottom_button.dart';
import 'bottom_sheet_util.dart';

enum AdjustType {
  add(LocaleKeys.trade262, 1),
  sub(LocaleKeys.trade263, 2);

  final String name;
  final int type;

  const AdjustType(this.name, this.type);
}

class AdjustMarginBottomSheet extends StatefulWidget {
  const AdjustMarginBottomSheet(
      {super.key,
      required this.positionInfo,
      required this.contractInfo,
      required this.contractType});

  final PositionInfo positionInfo;
  final ContractInfo contractInfo;
  final ContractType contractType;

  @override
  State<AdjustMarginBottomSheet> createState() =>
      _AdjustMarginBottomSheetState();

  static show(
      {required PositionInfo positionInfo,
      required ContractInfo contractInfo,
      required ContractType contractType}) {
    showBSheet(
      AdjustMarginBottomSheet(
        positionInfo: positionInfo,
        contractInfo: contractInfo,
        contractType: contractType,
      ),
    );
  }
}

class _AdjustMarginBottomSheetState extends State<AdjustMarginBottomSheet> {
  AdjustType adjustType = AdjustType.add;

  late TextEditingController textEditingController;
  late FocusNode focusNode;
  RxString amount = '0'.obs;
  late Worker worker;
  ChangePositionAmountInfo? amountInfo;

  @override
  void initState() {
    _queryPositionMargin();
    worker = debounce<String>(amount, (callback) {
      _queryPositionMargin();
    }, time: const Duration(milliseconds: 500));
    textEditingController = TextEditingController()
      ..addListener(() {
        amount.value = textEditingController.text.trim();
      });
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    worker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String maxAmount = '--';
    String reducePrice = '--';
    if (amountInfo != null) {
      reducePrice = (amountInfo!.reducePrice ?? '0').toNum().toPrecision(
          widget.contractInfo.coinResultVo?.symbolPricePrecision.toInt() ?? 4);
      if (adjustType == AdjustType.add) {
        maxAmount = (amountInfo!.canAdd ?? '0').toNum().toPrecision(
            widget.contractInfo.coinResultVo?.marginCoinPrecision.toInt() ?? 4);
      } else {
        maxAmount = (amountInfo!.canReduce ?? '0').toNum().toPrecision(
            widget.contractInfo.coinResultVo?.marginCoinPrecision.toInt() ?? 4);
      }
    }

    return AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.only(
          bottom: max(
              MediaQuery.of(context).viewInsets.bottom -
                  80.h -
                  Get.mediaQuery.padding.bottom -
                  120.h,
              0),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Text(
                    LocaleKeys.trade264.tr,
                    style: TextStyle(
                      color: AppColor.color111111,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  20.verticalSpace,
                  Text(LocaleKeys.trade27.tr),
                  8.verticalSpace,
                  _buildAmount(),
                  30.verticalSpace,
                  _buildTitleDesc(LocaleKeys.trade265.tr,
                      '${(amountInfo?.holdAmount ?? '0').toPrecision(widget.contractInfo.coinResultVo?.marginCoinPrecision.toInt() ?? 4)} USDT'),
                  12.verticalSpace,
                  _buildTitleDesc(
                      adjustType == AdjustType.add
                          ? LocaleKeys.trade266.tr
                          : LocaleKeys.trade282.tr,
                      '$maxAmount USDT'),
                  12.verticalSpace,
                  _buildTitleDesc(LocaleKeys.trade267.tr, '$reducePrice USDT'),
                ],
              ).marginSymmetric(horizontal: 16.w),
              30.verticalSpace,
              Divider(
                height: 1.h,
                color: AppColor.colorF5F5F5,
              ),
              16.verticalSpace,
              CancelConfirmBottomButton(onCancel: () {
                Get.back();
              }, onConfirm: () {
                _adjustMargin();
              }).marginSymmetric(horizontal: 16.w),
              16.verticalSpace,
            ],

      ),
    );
  }

  _queryPositionMargin() async {
    try {
      String am = amount.value.isEmpty ? '0' : amount.value;
      if (widget.contractType == ContractType.E) {
        final res = await ContractApi.instance()
            .queryChangePositionAmount(widget.positionInfo.id.toString(), am);
        setState(() {
          amountInfo = res;
        });
      } else {
        final res = await CommodityApi.instance()
            .queryChangePositionAmount(widget.positionInfo.id.toString(), am);
        setState(() {
          amountInfo = res;
        });
      }
    } catch (e) {
      AppLogUtil.i(e.toString());
    }
  }

  _adjustMargin() async {
    try {
      if (widget.contractType == ContractType.E) {
        final res = await ContractApi.instance().changePositionMargin(
            widget.positionInfo.id.toString(),
            (adjustType == AdjustType.add ? '' : '-') + amount.value);
      } else {
        final res = await CommodityApi.instance().changePositionMargin(
            widget.positionInfo.id.toString(),
            (adjustType == AdjustType.add ? '' : '-') + amount.value);
      }
      Get.back();
    } on DioException catch (e) {
      UIUtil.showError(e.message);
    }
  }

  _onSelectMax() {
    if (adjustType == AdjustType.add) {
      textEditingController.text = amountInfo?.canAdd ?? '';
    } else {
      textEditingController.text = amountInfo?.canReduce ?? '';
    }
  }

  _buildTitleDesc(String title, String desc, [Color? color]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.f_13_400.color666666,
        ),
        Text(
          desc,
          textAlign: TextAlign.right,
          style: AppTextStyle.f_13_500
              .copyWith(color: color ?? AppColor.color111111),
        )
      ],
    );
  }

  Widget _buildAmount() {
    return Container(
      height: 44.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.colorF5F5F5,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPopup(
            contentPadding: EdgeInsets.zero,
            showArrow: false,
            barrierColor: Colors.transparent,
            content: Container(
              width: 82.w,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: AdjustType.values
                    .map(
                      (e) => _buildItem(e.name.tr, adjustType == e, () {
                        setState(() {
                          adjustType = e;
                        });
                        Get.back();
                      }),
                    )
                    .toList(),
              ),
            ),
            child: _selector(),
          ),
          12.horizontalSpace,
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              cursorColor: AppColor.color111111,
              controller: textEditingController,
              focusNode: focusNode,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
              ],
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.color111111,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: '',
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.colorABABAB,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: _onSelectMax,
            child: Text(
              'MAX',
              style: AppTextStyle.f_14_600.colorFFD429,
            ),
          ),
          12.horizontalSpace,
          Text(
            'USDT',
            style: AppTextStyle.f_14_600.color666666,
          ),
          12.horizontalSpace,
        ],
      ),
    );
  }

  Widget _selector() {
    return SizedBox(
      height: 44.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          12.horizontalSpace,
          Text(
            adjustType.name.tr,
            style: AppTextStyle.f_16_600.color111111,
          ),
          12.horizontalSpace,
          Icon(
            Icons.keyboard_arrow_down_sharp,
            size: 12.sp,
            color: AppColor.color666666,
          ),
          12.horizontalSpace,
          Container(
            height: 12,
            width: 1,
            color: AppColor.colorDDDDDD,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 40.h,
        padding: EdgeInsets.only(left: 12.w),
        child: Text(title, style: AppTextStyle.f_16_600.color111111),
      ),
    );
  }
}
