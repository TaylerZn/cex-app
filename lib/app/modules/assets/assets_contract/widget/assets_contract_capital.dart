import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/assets/assets_contract.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsContractCapital extends StatelessWidget {
  const AssetsContractCapital({super.key, required this.list});

  final List<AccountList> list;

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return getCell(list[index]);
            },
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 100.h),
            child: noDataWidget(context, wigetHeight: 600.h),
          );
  }

  Widget getCell(AccountList e) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              MyImage(
                'currency/usdt'.svgAssets(),
                width: 24.r,
              ),
              SizedBox(width: 8.w),
              Text(e.symbol, style: AppTextStyle.f_15_500.color111111),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getColumnWidget(
                    LocaleKeys.assets14.tr, e.accountBalance.toString()),
                getColumnWidget(LocaleKeys.assets15.tr, e.unRealizedAmount),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getColumnWidget(LocaleKeys.assets20.tr, e.marginAmount),
                getColumnWidget(
                    LocaleKeys.assets21.tr, e.canUseAmount.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getColumnWidget(String titile, String des,
      {CrossAxisAlignment alignment = CrossAxisAlignment.start}) {
    return Expanded(
        child: Column(
      crossAxisAlignment: alignment,
      children: [
        Text(titile, style: AppTextStyle.f_11_400.colorA3A3A3),
        SizedBox(height: 9.h),
        Text(des, style: AppTextStyle.f_14_500.color111111),
      ],
    ));
  }
}
