import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_appbar_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../widgets/basic/my_image.dart';
import '../controllers/withdraw_detail_controller.dart';

class WithdrawDetailView extends GetView<WithdrawDetailController> {
  WithdrawDetailView({Key? key, this.item}) : super(key: key);
  AssetsHistoryRecordItem? item;

  @override
  Widget build(BuildContext context) {
    item = Get.arguments?['data'];
    return Scaffold(
      appBar: MyAppBar(myTitle: '提现详情'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            24.verticalSpaceFromWidth,
            MyImage(item?.status == 2
                ? 'assets/with_suc'.svgAssets()
                : 'assets/with_pending'.svgAssets()),
            12.verticalSpaceFromWidth,
            Text(item?.status == 2 ? '已完成' : '提币中',
                style: AppTextStyle.f_13_500.colorTextDisabled),
            Text('-${item?.amount} ${item?.coinSymbol}',
                style: AppTextStyle.f_28_600.colorTextPrimary),
            12.verticalSpaceFromWidth,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
              decoration: BoxDecoration(
                  color: AppColor.colorBackgroundSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(8.r))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyImage('assets/yel_notice'.svgAssets()).marginOnly(top: 4.w),
                  10.horizontalSpace,
                  Expanded(
                      child: Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: '从BITCOCO 转出的加密货币，请联系收款平台索取您的交易收据。',
                        style: AppTextStyle.f_12_400.colorTextDescription),
                    TextSpan(
                        text: '为什么我的提现未到账？',
                        style: AppTextStyle.f_12_400.tradingYel)
                  ])))
                ],
              ),
            ),
            16.verticalSpaceFromWidth,
            buildItem('转账网络', '${item?.mainnet ?? '-'}'),
            24.verticalSpaceFromWidth,
            buildItem(LocaleKeys.assets89.tr, '${item?.addressTo ?? '-'}',
                showCopy: true),
            24.verticalSpaceFromWidth,
            // TODO: 1111
            buildItem('交易哈希', 'asdlasmdlasmdkasmdkasdmkasmdkasdmaksdmk',
                showCopy: true),
            24.verticalSpaceFromWidth,
            buildItem('提币数量', '${item?.amount ?? '-'} ${item?.coinSymbol}'),
            24.verticalSpaceFromWidth,
            buildItem('网络费用', '${item?.fee ?? '-'} ${item?.coinSymbol}'),
            24.verticalSpaceFromWidth,
            buildItem('提现账户', '${item?.account ?? '-'}'),
            24.verticalSpaceFromWidth,
            buildItem('日期', '${item?.createTime ?? '-'}'),
          ],
        ),
      ),
    );
  }

  Widget buildItem(String title, String value, {bool showCopy = false}) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.f_13_400.colorTextDescription),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 229.w),
                child: Text(value,
                    textAlign: TextAlign.end,
                    style: AppTextStyle.f_13_500.colorTextPrimary),
              ),
              Visibility(
                  visible: showCopy,
                  child: Container(
                    margin: EdgeInsets.only(left: 8.w),
                    child: InkWell(
                        onTap: () {
                          CopyUtil.copyText(value);
                        },
                        child: MyImage('assets/copy'.svgAssets())),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
