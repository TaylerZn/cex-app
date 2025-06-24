import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/contract_info/controllers/contract_info_controller.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ContractTradeTimeWidget extends StatelessWidget {
  const ContractTradeTimeWidget({super.key, required this.controller});
  final ContractInfoController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
            children: controller.getInfoList().map((info) {
      return _buildItem(
        '${controller.getTimeName(info.dayOfWeek)} ${controller.isDay(info.dayOfWeek) ? LocaleKeys.trade242.tr : ''}',
        info.value ?? '',
      );
    }).toList())
        .marginSymmetric(horizontal: 16.w);
  }

  Widget _buildItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          title,
          style: AppTextStyle.f_12_400.colorTextTips,
        ),
        Text(
          value,
          style: AppTextStyle.f_12_400.colorTextPrimary,
        ),
      ],
    ).marginOnly(bottom: 16.h);
  }
}
