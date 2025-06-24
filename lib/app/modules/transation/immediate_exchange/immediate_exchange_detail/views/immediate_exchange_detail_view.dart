import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_main/controllers/assets_main_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/immediate_exchange_detail_controller.dart';

class ImmediateExchangeDetailView
    extends GetView<ImmediateExchangeDetailController> {
  ImmediateExchangeDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImmediateExchangeDetailController());
    FocusScope.of(context).unfocus();
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: Text(LocaleKeys.trade325.tr),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 64.h),
          Center(
            child: MyImage('trade/convert_success'.svgAssets(),
                width: 84.w, height: 84.h),
          ),
          SizedBox(height: 19.h),
          Center(
            child: Text(
                '+' +
                    '${controller.orderModel?.rightVolume ?? '--'}' +
                    ' ' +
                    '${controller.orderModel?.rightCoin ?? '--'}', //controller.model?.exchangeAmount ?? '',
                style: AppTextStyle.f_20_500.color111111),
          ),
          SizedBox(height: 31.h),
          _buildItem(
            LocaleKeys.trade303.tr, //类型
            LocaleKeys.trade304.tr, //TOODO :  市价
          ),
          _buildItem(
              LocaleKeys.trade305.tr, //支付渠道
              LocaleKeys.trade306.tr), //现货账户
          _buildItem(
              LocaleKeys.trade311.tr, //兑换
              '${controller.orderModel?.leftVolume} ${controller.orderModel?.leftCoin}'), // 100 USDT
          _buildItem(
              LocaleKeys.trade307.tr, //交易手续费
              LocaleKeys.trade293.tr), //0手续费
          _buildItem(
              LocaleKeys.trade308.tr, //兑换率
              '1 ${controller.orderModel?.leftCoin} ≈ ${controller.orderModel?.rate} ${controller.orderModel?.rightCoin}'), //1 USDT = 1 BNB
          _buildItem(
              LocaleKeys.trade312.tr, //下单时间
              MyTimeUtil.timestampToStr(
                  controller.orderModel?.ctime ?? 0)), //2021-09-09 12:00:00
          Spacer(),
          Container(
            height: 120.h,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    RouteUtil.goTo('/immediate-exchange');
                  },
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: AppColor.colorFFFFFF,
                      border: Border.all(
                        color: AppColor.color111111,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.trade313.tr, //完成
                        style: AppTextStyle.f_16_600.color111111,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                InkWell(
                  onTap: () {
                    debugPrint('查看资产');
                    AssetsMainController.navigateToSpot();
                  },
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: AppColor.color111111,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.trade314.tr, //查看资产
                        style: AppTextStyle.f_20_500.colorFFFFFF,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ).marginOnly(left: 16.w, right: 16.w),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          title,
          style: AppTextStyle.f_13_400.color666666,
        ),
        Text(
          value,
          style: AppTextStyle.f_13_400.color111111,
        ),
      ],
    ).marginOnly(bottom: 12.h, left: 16.w, right: 16.w);
  }
}
