import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/advert_exchange_rate.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_public_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/select.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../utils/utilities/input_util.dart';
import '../sales_comission/controllers/sales_comission_controller.dart';

class CommissionPriceWidget extends StatefulWidget {
  const CommissionPriceWidget({super.key});

  @override
  State<CommissionPriceWidget> createState() => _CommissionPriceWidgetState();
}

class _CommissionPriceWidgetState extends State<CommissionPriceWidget> {
  final controller = Get.find<SalesComissionController>();
  late ValueNotifier<String> exchangeRate = ValueNotifier('0.0');
  Timer? checkTimer;
  AdvertExchangeRate? advertExchangeRate;
  int decimalPoint = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
    checkTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      loadData();
    });
  }

  Future<void> loadData() async {
    advertExchangeRate = await OtcApi.instance().exchangeRate(
        fiatCoin: OtcConfigUtils().payCoin.value, cryptoCoin: 'USDT');
    exchangeRate.value = advertExchangeRate?.buyValue ?? '';
    int index = exchangeRate.value.indexOf('.');

    OtcConfigUtils().exchangeRate = advertExchangeRate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            controller.isPurchaseMode
                ? LocaleKeys.c2c170.tr
                : LocaleKeys.c2c30.tr,
            style: AppTextStyle.f_15_500),
        SizedBox(height: 4.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
              border: Border.all(color: AppColor.colorF5F5F5)),
          child: Row(
            children: [
              Expanded(
                  child: MyTextFieldWidget(
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      inputFormatters: [
                        DecimalTextInputFormatter(
                            decimalRange: OtcConfigUtils().decimalPoint,
                            activatedNegativeValues: false)
                      ],
                      enabledBorderColor: Colors.transparent,
                      hintText: controller.isPurchaseMode
                          ? LocaleKeys.c2c186.tr
                          : LocaleKeys.c2c31.tr,
                      isTopText: false,
                      focusedBorderColor: Colors.transparent,
                      onChanged: (value) {
                        controller.formFill.price = value;
                      })),
              SizedBox(width: 16.w),
              SizedBox(
                  width: 100.w,
                  child: MySelect(
                      textStyle: AppTextStyle.f_13_500.color666666,
                      checkIndex: false,
                      border: Border(),
                      list: OtcConfigUtils()
                              .publicInfo
                              ?.paycoins
                              ?.map((e) => e.title ?? '')
                              .toList() ??
                          [],
                      hint: '',
                      value: controller.formFill.paycoin ?? 'USD',
                      onChanged: (value) {
                        dynamic list = OtcConfigUtils().publicInfo?.paycoins;
                        CountryNumberInfo? info = OtcConfigUtils()
                            .publicInfo
                            ?.paycoins?[int.parse(value!)];
                        OtcConfigUtils().payCoin.value = info?.key ?? '';
                        OtcConfigUtils().payTitle.value = info?.title ?? '';
                        decimalPoint = OtcConfigUtils().decimalPoint;
                        controller.formFill.paycoin = info?.key;
                        setState(() {});
                      })),
            ],
          ),
        ),
        ValueListenableBuilder(
            valueListenable: exchangeRate,
            builder: (_, value, __) => Row(
                  children: [
                    Text('${LocaleKeys.c2c171.tr}:',
                        style: AppTextStyle.f_12_400.colorTips),
                    Text('\$${value}', style: AppTextStyle.f_12_400)
                  ],
                ))
      ],
    );
  }

  @override
  void dispose() {
    checkTimer?.cancel();
    checkTimer = null;
    // TODO: implement dispose
    super.dispose();
  }
}
