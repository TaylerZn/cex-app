import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/otc/b2c.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/b2c/order_history_res.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:styled_text/styled_text.dart';

class B2cOrderHistoryItem extends StatelessWidget {
  const B2cOrderHistoryItem({super.key, required this.item});
  final B2cOrderHistoryListModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(width: 1.0, color: AppColor.colorEEEEEE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              StyledText(
                text:
                    '<b>${item.orderSide == 'BUY' ? LocaleKeys.b2c8.tr : LocaleKeys.b2c9.tr}  </b>${item.coinSymbol ?? '--'}',
                style: AppTextStyle.f_14_500.color111111,
                tags: {
                  'b': StyledTextTag(
                      style: AppTextStyle.f_14_500.copyWith(
                          color: item.orderSide == 'BUY'
                              ? AppColor.upColor
                              : AppColor.downColor)),
                },
              ),
              Expanded(
                  child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  typeRightWidget(item),
                ],
              ))
            ],
          ),
          16.verticalSpace,
          const Divider(height: 1, color: AppColor.colorEEEEEE),
          16.verticalSpace,
          getRow(LocaleKeys.b2c13.tr,
              '${item.orderSide == 'BUY' ? item.amount ?? '--' : item.transactionAmount} ${item.orderSide == 'BUY' ? item.fiatCoin ?? '--' : item.coinSymbol ?? '--'}',
              rightTextyle: AppTextStyle.f_14_600.color333333),
          getRow(LocaleKeys.b2c14.tr,
              '${item.price ?? '--'} ${item.priceUnit ?? '--'}'),
          getRow(LocaleKeys.b2c15.tr,
              '${item.orderSide == 'BUY' ? item.transactionAmount : item.amount ?? '--'} ${item.orderSide == 'BUY' ? item.coinSymbol ?? '--' : item.fiatCoin ?? '--'}'),
          getRow(LocaleKeys.b2c16.tr, item.orderId ?? '--',
              rightWidget: InkWell(
                onTap: () {
                  CopyUtil.copyText(item.orderId ?? '--');
                },
                child: Row(
                  children: [
                    4.horizontalSpace,
                    Text(
                      LocaleKeys.public6.tr,
                      style: AppTextStyle.f_12_400.color0075FF,
                    )
                  ],
                ),
              )),
          item.statusType == B2cOrderHistoryListTypeEnumn.finish
              ? getRow(LocaleKeys.b2c17.tr, item.cardType ?? '--')
              : const SizedBox(),
          getRow(LocaleKeys.b2c18.tr, item.transferType ?? '--'),
          getRow(LocaleKeys.b2c19.tr,
              '${item.fee ?? '--'} ${item.feeUnit ?? '--'}'),
          item.statusType == B2cOrderHistoryListTypeEnumn.finish
              ? getRow('txhash', null,
                  rightWidget: InkWell(
                    child: Text(
                      item.thirdTransHash == null
                          ? '--'
                          : item.thirdTransHash!.walletAddress(),
                      style: AppTextStyle.f_12_400.color0075FF,
                    ),
                  ))
              : const SizedBox(),
          getRow(
            LocaleKeys.b2c20.tr,
            item.createTime != null
                ? MyTimeUtil.timestampToStr(item.createTime!)
                : '--',
          ),
        ],
      ),
    );
  }

  Widget getRow(String left, String? right,
      {TextStyle? rightTextyle, Widget? rightWidget}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 140.w,
            child: Text(left, style: AppTextStyle.f_12_400.color666666),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              right != null
                  ? Text(right,
                      style: rightTextyle ?? AppTextStyle.f_12_400.color333333)
                  : 0.verticalSpace,
              rightWidget ?? 0.verticalSpace
            ],
          ))
        ],
      ),
    );
  }

  Widget typeRightWidget(B2cOrderHistoryListModel item) {
    // prePayment, //代付款
    // alreadyPaid, //已付款
    // waitingForPayment, //等待打款
    // finish, //完成
    // fail, //失败
    if (item.status != null) {
      switch (item.statusType) {
        case B2cOrderHistoryListTypeEnumn.prePayment:
        case B2cOrderHistoryListTypeEnumn.waitingForPayment:
          return item.orderSide == "BUY"
              ? Row(
                  children: [
                    Text(
                      LocaleKeys.b2c21.tr,
                      style: AppTextStyle.f_12_500.colorABABAB,
                    ),
                    // 4.horizontalSpace,
                    // MyCountdownTimer(
                    //   endTime: 1720710187,
                    //   onCountdownComplete: () {
                    //     //时间截止以后执行操作
                    //   },
                    // ),
                  ],
                )
              : Text(
                  LocaleKeys.b2c22.tr,
                  style: AppTextStyle.f_12_500.colorABABAB,
                );
        case B2cOrderHistoryListTypeEnumn.alreadyPaid:
          return InkWell(
            onTap: () {
              UIUtil.showConfirm(LocaleKeys.b2c32.tr,
                  content: LocaleKeys.b2c33.tr,
                  cancelText: LocaleKeys.b2c34.tr, cancelHandler: () {
                Get.back();
                Get.toNamed(Routes.WEBVIEW,
                    arguments: {'url': LinksGetx.to.onlineServiceProtocal});
              }, confirmText: LocaleKeys.b2c35.tr);
            },
            child: Row(
              children: [
                MyImage(
                  'default/tip'.svgAssets(),
                  color: AppColor.color999999,
                  width: 14.w,
                ),
                4.horizontalSpace,
                AbsorbPointer(
                    absorbing: true, // 设置为 true 来阻止子级接收点击事件
                    child: MyDottedText(
                      LocaleKeys.b2c23.tr,
                      style: AppTextStyle.f_12_500.colorBBBBBB,
                    ))
              ],
            ),
          );

        case B2cOrderHistoryListTypeEnumn.finish:
          return Text(
            LocaleKeys.b2c24.tr,
            style: AppTextStyle.f_12_500.color333333,
          );
        case B2cOrderHistoryListTypeEnumn.fail:
          return Text(
            LocaleKeys.b2c25.tr,
            style: AppTextStyle.f_12_500.colorABABAB,
          );
        default:
          return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }
}
