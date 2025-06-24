import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/controllers/customer_toc_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_advert.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerTocListView extends StatelessWidget {
  const CustomerTocListView({super.key, required this.controller, required this.type});
  final CustomerTocController controller;
  final C2cType type;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshVcArr[type.index],
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async {
        await controller.getData(isPullDown: true);
        controller.refreshVcArr[type.index].refreshToIdle();
        controller.refreshVcArr[type.index].loadComplete();
      },
      onLoading: () async {
        if (controller.dataArray[type.index].value.haveMore) {
          controller.dataArray[type.index].value.page++;
          await controller.getData();
          controller.refreshVcArr[type.index].loadComplete();
        } else {
          controller.refreshVcArr[type.index].loadNoData();
        }
      },
      child: CustomScrollView(
        key: PageStorageKey<String>(type.value),
        slivers: <Widget>[
          Obx(() => controller.dataArray[type.index].value.records?.isNotEmpty == true
              ? SliverPadding(
                  padding: EdgeInsets.only(top: 16.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      return CustomerTocListCell(
                          controller: controller, model: controller.dataArray[type.index].value.records![index], index: index);
                    }, childCount: controller.dataArray[type.index].value.records?.length),
                  ),
                )
              : FollowOrdersLoading(
                  isError: controller.dataArray[type.index].value.isError,
                  onTap: () {
                    controller.getData(isPullDown: true);
                  }))
        ],
      ),
    );
  }
}

class CustomerTocListCell extends StatelessWidget {
  const CustomerTocListCell({super.key, required this.model, required this.controller, required this.index});
  final CustomerAdvertModel model;
  final CustomerTocController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    var rowTop = Row(
      children: [
        //
        GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PERSONAL_PROFILE, arguments: {'uid': model.userId});
            },
            child: Container(
              width: 18.w,
              height: 18.w,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: AppColor.color333333,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(model.icon, style: AppTextStyle.f_11_500.colorWhite),
            )),
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PERSONAL_PROFILE, arguments: {'uid': model.userId});
                },
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 180.w,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 2.w),
                      child: Text(model.usernameStr, style: AppTextStyle.f_14_400.color111111.ellipsis),
                    )),
              ),
              MyImage(
                'otc/c2c/c2c_auth'.svgAssets(),
                width: 14.w,
                height: 14.w,
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(LocaleKeys.c2c193.tr, style: AppTextStyle.f_9_400.color999999),
            Text(model.dealStr, style: AppTextStyle.f_10_500.color4D4D4D),
          ],
        ).marginOnly(left: 10.w)
      ],
    );

    var midView = Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: model.paySymbolStr, style: AppTextStyle.f_12_400.color111111),
                  TextSpan(text: model.totalPriceStr, style: AppTextStyle.f_20_500.color111111),
                ],
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(LocaleKeys.c2c194.tr, style: AppTextStyle.f_12_400.color999999),
            SizedBox(width: 10.w),
            Text(model.volumeStr, style: AppTextStyle.f_12_500.color333333),
          ],
        ).marginOnly(top: 10.h, bottom: 6.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(LocaleKeys.c2c195.tr, style: AppTextStyle.f_12_400.color999999),
            SizedBox(width: 10.w),
            Text(model.limitStr, style: AppTextStyle.f_12_500.color333333),
          ],
        ),
      ],
    );

    var button = MyButton(
        text: model.buttomTitle,
        textStyle: AppTextStyle.f_12_600,
        backgroundColor: model.isEnable ? AppColor.color111111 : AppColor.colorABABAB,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        onTap: () async {
          if (model.isEnable) {
            controller.checkState(
                id: (model.id ?? -1).toString(),
                coin: model.payCoin ?? '',
                isBuy: model.isBuy,
                coinSymbol: model.paySymbol ?? '');
          }
        });
    return GestureDetector(
        onTap: () {
          if (model.isEnable) {
            controller.checkState(
                id: (model.id ?? -1).toString(),
                coin: model.payCoin ?? '',
                isBuy: model.isBuy,
                coinSymbol: model.paySymbol ?? '');
          }
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
          padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 12.h),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(width: 1, color: AppColor.colorEEEEEE)),
          child: Column(
            children: <Widget>[
              index == 0 ? AppGuideView(order: 3, guideType: AppGuideType.c2c, child: rowTop) : rowTop,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Container(height: 1.0, color: AppColor.colorEEEEEE),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: index == 0 ? AppGuideView(order: 4, guideType: AppGuideType.c2c, child: midView) : midView),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CustomerTocListCellBottom(array: model.payments),
                  index == 0 ? AppGuideView(order: 5, guideType: AppGuideType.c2c, child: button) : button
                ],
              )
            ],
          ),
        ));
  }
}

class CustomerTocListCellBottom extends StatelessWidget {
  const CustomerTocListCellBottom({super.key, required this.array});
  final List<PaymentModel>? array;

  @override
  Widget build(BuildContext context) {
    return array == null
        ? const SizedBox()
        : Expanded(
            child: Wrap(children: getWidget(array!)),
          );
  }

  List<Widget> getWidget(List<PaymentModel> array) {
    List<Widget> widgetArr = [];
    for (var i = 0; i < array.length; i++) {
      var w = Padding(
          padding: EdgeInsets.only(right: 16.w, bottom: 4.h),
          child: CustomerPayview(
            colorKey: array[i].key ?? '',
            name: array[i].title ?? '',
          ));
      widgetArr.add(w);
    }
    return widgetArr;
  }
}

class CustomerPayview extends StatelessWidget {
  final String? title;
  CustomerPayview({super.key, this.colorKey = '', this.title, required this.name, this.style, this.width, this.height});
  final String colorKey;
  final String name;

  final TextStyle? style;
  final double? width;
  final double? height;

  final Map<String, Color> colorArr = {
    "otc.payment.alipay": const Color(0XFF50A1FF), // "支付寶",
    "otc.payment.wxpay": const Color(0XFF15B628), //  "微信",
    "otc.payment.paytm": const Color(0xFF0B2D6E), //  "Paytm",
    "otc.payment.upi": const Color(0xFF6D6E72), //  "UPI",
    "otc.payment.domestic.bank.transfer": const Color(0xFF53A755), //  "銀行卡",
    "otc.payment.paypal": const Color(0xFF3B85E1), //  "PayPal",
    "otc.payment.paynow": const Color(0xFF175FF8), //  "PayNow",
    "otc.payment.qiwi": const Color(0xFFEE9235), //  "QIWI",
    "otc.payment.interac": const Color(0xFFF4BC4D), //  "Interac",
    "otc.payment.western.union": const Color(0xFF365578), //  "西聯匯款",
    "otc.payment.swift": const Color(0XFF50A1FF), //  "SWIFT",
    "otc.payment.imps": const Color(0xFFF5791F), //  "IMPS",
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width ?? 3,
          height: height ?? 9,
          margin: EdgeInsets.only(right: 2.w, top: 2.w),
          decoration: ShapeDecoration(
            color: colorArr[name] ?? const Color(0xFFFFCE1F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(44),
            ),
          ),
        ),
        Text(title ?? name, style: style ?? AppTextStyle.f_10_400.copyWith(color: AppColor.color0C0D0F))
      ],
    );
  }
}
