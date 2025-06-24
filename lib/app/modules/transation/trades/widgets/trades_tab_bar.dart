import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../controllers/trades_controller.dart';

class TradesTabBar extends GetView<TradesController> {
  const TradesTabBar({super.key, required this.onTabChanged});

  final ValueChanged<TradeIndexType> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: TradeIndexType.values.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 16.w,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                TradeIndexType tradeIndexType = TradeIndexType.values[index];
                return InkWell(
                  onTap: () {
                    onTabChanged(tradeIndexType);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 44.h,
                        alignment: Alignment.center,
                        child: Obx(() {
                          return Text(
                            TradeIndexType.values[index].title.tr,
                            style: AppTextStyle.f_16_600.copyWith(
                                color: controller.tradeIndextype.value ==
                                        tradeIndexType
                                    ? AppColor.colorBlack
                                    : AppColor.color999999),
                          );
                        }),
                      ),
                      if (index == 0)
                        Positioned(
                          right: -7,
                          top: 10,
                          child: MyImage(
                            'assets/images/trade/hot.svg',
                            width: 15.w,
                            height: 10.w,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.WEAL_INDEX);
            },
            child: Lottie.asset(
              'assets/json/gift_we.json',
              fit: BoxFit.fill,
              width: 26.w,
              height: 30.w,
            ),
          ),
        ],
      ),
    );
  }
}
