import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/contract_leverage.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ContractLevelMarginWidget extends StatefulWidget {
  const ContractLevelMarginWidget({super.key, required this.contractInfo});

  final ContractInfo? contractInfo;

  @override
  State<ContractLevelMarginWidget> createState() =>
      _ContractLevelMarginWidgetState();
}

class _ContractLevelMarginWidgetState extends State<ContractLevelMarginWidget> {
  ContractLeverage? _contractLeverage;

  @override
  void initState() {
    super.initState();
    if (widget.contractInfo == null) {
      return;
    }
    _fetchData();
  }

  _fetchData() async {
    try {
      EasyLoading.show();
      final res = await CommodityApi.instance()
          .getLadderInfo(widget.contractInfo!.id.toString());
      if (mounted) {
        setState(() {
          _contractLeverage = res;
        });
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_contractLeverage == null) {
      return Container();
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: _contractLeverage!.leverList!.length,
      itemBuilder: (BuildContext context, int index) {
        final list = _contractLeverage!.leverList![index];
        return LevelItem(list: list);
      },
    );
  }
}

class LevelItem extends StatelessWidget {
  const LevelItem({super.key, required this.list});

  final LeverList list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${LocaleKeys.trade393.tr}${list.level}',
            style: AppTextStyle.f_15_500.colorTextPrimary,
          ),
          10.verticalSpaceFromWidth,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.w,
            children: [
              _item(LocaleKeys.trade394.tr,
                  '${NumberUtil.getPrice(list.minPositionValue ?? 0, 0)}-${NumberUtil.getPrice(list.maxPositionValue ?? 0, 0)}'),
              _item(LocaleKeys.trade395.tr, '${list.maxLever}x'),
              _item(LocaleKeys.trade396.tr, '${(list.minMarginRate ?? 0) * 100} %'),
            ],
          )
        ],
      ),
    );
  }

  Widget _item(String title, String value) {
    return Container(
      width: 167.w,
      height: 52.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.colorBackgroundSecondary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyDottedText(
            title,
            isCenter: false,
            style: AppTextStyle.f_11_400.colorTextTips,
          ),
          6.verticalSpaceFromWidth,
          Text(
            value,
            style: AppTextStyle.f_13_500.colorTextPrimary,
          ),
        ],
      ),
    );
  }
}
