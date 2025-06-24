import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../assets/assets_main/controllers/assets_main_controller.dart';

class OrderStateWidget extends StatefulWidget {
  const OrderStateWidget({super.key, required this.orderState});

  final CustomerOrderDetailModel? orderState;

  @override
  State<OrderStateWidget> createState() => _OrderStateWidgetState();
}

class _OrderStateWidgetState extends State<OrderStateWidget> {
  RxInt remainingTime = 0.obs;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.orderState?.status == 1 || widget.orderState?.status == 2) {
      remainingTime.value = (widget.orderState?.limitTime.toInt() ?? 0) ~/ 1000;
      // 我是买家，并已支付，等待 xxx 收到USDT
      if ((widget.orderState?.isBUy ?? false) &&
          widget.orderState?.status == 2) {
        remainingTime.value =
            (widget.orderState?.remainTime.toInt() ?? 0) ~/ 1000;
      }
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingTime <= 0) {
          timer.cancel();
        } else {
          remainingTime.value--;
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.orderState == null || (widget.orderState?.status ?? 0) > 5) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.bgColorLight,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.orderState?.getStateStr() ?? '',
                  style: AppTextStyle.f_14_600.color111111,
                ),
                6.verticalSpace,
                Obx(() {
                  // 计算分秒
                  String remainTimeStr = remainingTime.value.toString();
                  if (widget.orderState?.status == 1 ||
                      widget.orderState?.status == 2) {
                    int minute = remainingTime.value ~/ 60;
                    int second = remainingTime.value % 60;
                    remainTimeStr =
                        '${minute.toString().padLeft(2, '0')}${LocaleKeys.c2c309.tr}${second.toString().padLeft(2, '0')}${LocaleKeys.c2c310.tr}';
                  }
                  return Text(
                    getDes(remainTimeStr),
                    style: AppTextStyle.f_14_400.color666666,
                  );
                }),
              ],
            ),
          ),

          /// 买家去支付
          if (widget.orderState?.status == 1 &&
              (widget.orderState?.isBUy ?? false))
            MyButton(
              width: 63.w,
              height: 28.h,
              text: LocaleKeys.c2c305.tr,
              onTap: () {
                if (widget.orderState == null) return;
                OtcConfigUtils.goOrderDetail(
                    status: widget.orderState!.status ?? 0,
                    orderId: widget.orderState!.id ?? 0,
                    isBuy: widget.orderState!.isBUy);
              },
              textStyle: AppTextStyle.f_13_500.colorF53F57,
              backgroundColor: AppColor.bgColorDark,
              borderRadius: BorderRadius.circular(6.r),
            ),

          /// 卖家去确认
          if (widget.orderState?.status == 2 &&
              !(widget.orderState?.isBUy ?? false))
            MyButton(
              width: 63.w,
              height: 28.h,
              text: LocaleKeys.c2c306.tr,
              onTap: () {
                if (widget.orderState == null) return;
                OtcConfigUtils.goOrderDetail(
                    status: widget.orderState!.status ?? 0,
                    orderId: widget.orderState!.id ?? 0,
                    isBuy: widget.orderState!.isBUy);
              },
              textStyle: AppTextStyle.f_13_500.colorF53F57,
              backgroundColor: AppColor.bgColorDark,
              borderRadius: BorderRadius.circular(6.r),
            ),

          /// 卖家查看资产
          if (widget.orderState?.status == 3 &&
              !(widget.orderState?.isBUy ?? false))
            MyButton(
              height: 28.h,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              textStyle: AppTextStyle.f_13_500,
              color: AppColor.color0C0D0F,
              text: LocaleKeys.c2c307.tr,
              backgroundColor: AppColor.bgColorLight,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: AppColor.colorBlack),
              onTap: () {
                AssetsMainController.navigateToFunding();
              },
            ),
        ],
      ),
    );
  }

  String getDes(String remainTimeStr) {
    if (widget.orderState == null) return '';
    int status = widget.orderState!.status ?? 0;

    /// 订单状态 待支付1 已支付2 交易成功3 取消4 申诉5 打币中6 异常订单7 申诉处理完成 8 申诉取消 9
    if (widget.orderState!.isBUy) {
      if (status == 1) {
        return '${LocaleKeys.c2c308.tr} $remainTimeStr';
      } else if (status == 2) {
        return '${LocaleKeys.c2c240.tr} $remainTimeStr ${LocaleKeys.c2c241.tr}USDT';
      } else if (status == 3) {
        return '${LocaleKeys.c2c248.tr}${widget.orderState!.volumeStr}';
      } else if (status == 4) {
        /// 订单取消
        if (widget.orderState?.cancelStatus == 1) {
          return LocaleKeys.c2c313.tr;
        }
        if (widget.orderState?.cancelStatus == 2) {
          return LocaleKeys.c2c314.tr;
        }
        if (widget.orderState?.cancelStatus == 3) {
          return LocaleKeys.c2c315.tr;
        }
        return LocaleKeys.c2c287.tr;
      } else if (status == 5) {
        return LocaleKeys.c2c255.tr;
      } else {
        return '';
      }
    } else {
      if (status == 1) {
        return '${LocaleKeys.c2c308.tr} $remainTimeStr';
      } else if (status == 2) {
        // return '${LocaleKeys.c2c275.tr}${widget.orderState?.volume}USDT';
        return '${LocaleKeys.c2c308.tr} $remainTimeStr';
      } else if (status == 3) {
        return '${LocaleKeys.c2c275.tr}${widget.orderState!.volumeStr}';
      } else if (status == 4) {
        /// 订单取消
        if (widget.orderState?.cancelStatus == 1) {
          return LocaleKeys.c2c313.tr;
        }
        if (widget.orderState?.cancelStatus == 2) {
          return LocaleKeys.c2c314.tr;
        }
        if (widget.orderState?.cancelStatus == 3) {
          return LocaleKeys.c2c315.tr;
        }
        return LocaleKeys.c2c287.tr;
      } else if (status == 5) {
        return LocaleKeys.c2c255.tr;
      } else {
        return '';
      }
    }
  }
}
