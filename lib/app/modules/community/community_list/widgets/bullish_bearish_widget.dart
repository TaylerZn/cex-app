import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'dart:math';

class BullishBearishWidget extends StatelessWidget {
  int? bullishPercentage = 50; // 看涨
  int? bearishPercentage = 50; // 看跌
  var hasClicked = false.obs; // Reactive state to track clicks
  var isBullish = false.obs;
  bool voted;
  final VoidCallback onBullishTap;
  final VoidCallback onBearishTap;

  BullishBearishWidget(
      {required this.onBullishTap,
        required this.onBearishTap,
        this.voted = false,
        this.bullishPercentage,
        this.bearishPercentage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double availableWidth = screenWidth - 32.w - 3.w;
    if (bullishPercentage == 0 && bearishPercentage == 0) {
      bearishPercentage = bullishPercentage = 50;
    }

    int total = (bearishPercentage ?? 50)  + (bullishPercentage ?? 50);
    //end
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                voted ? LocaleKeys.community54.tr : LocaleKeys.community51.tr,
                style: AppTextStyle.f_13_500.colorTextPrimary,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 12.w),
            child: SizedBox(
              height: 36.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bearish section
                  SizedBox(
                    height: 36.w,
                    width: 28.5.w + (308.w -57.w) * (bearishPercentage ?? 50) / total,
                    child: InkWell(
                      onTap: () {
                        if (voted) return;
                        onBearishTap.call();
                      },
                      child: Stack(
                        children: [
                          // 使用三段式还是原始资源根据voted值判断
                          _buildImage(
                            left: true,
                            percentage: (bearishPercentage ?? 50 )/total ,
                            voted: voted,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              voted
                                  ? '$bearishPercentage%'
                                  : LocaleKeys.community53.tr, //'看跌',
                              style: voted
                                  ? AppTextStyle.f_14_600.colorFunctionSell
                                  : AppTextStyle.f_14_600.colorAlwaysWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bullish section
                  SizedBox(
                    height: 36.w,
                    width:  28.5.w + (308.w -57.w) * (bullishPercentage ?? 50) / total ,
                    child: InkWell(
                      onTap: () {
                        if (voted) return;
                        onBullishTap.call();
                      },
                      child: SizedBox(
                        height: 36.w,
                        width: 28.5.w + (308.w -57.w) * (bullishPercentage ?? 50) / total,
                        child: Stack(
                          children: [
                            // 使用三段式还是原始资源根据voted值判断
                            _buildImage(
                              left: false,
                              percentage: (bullishPercentage ?? 50)/total,
                              voted: voted,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                voted
                                    ? '$bullishPercentage%'
                                    : LocaleKeys.community52.tr, //'看涨',
                                style: voted
                                    ? AppTextStyle.f_14_600.colorFunctionBuy
                                    : AppTextStyle.f_14_600.colorAlwaysWhite,
                                textAlign: TextAlign.center, // 居中对齐文字
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建图片的逻辑
  Widget _buildImage({
    required bool left,
    required double percentage,
    required bool voted,
  }) {
    // 未投票时使用原来的整图资源
    if (!voted) {
      String assetPath = left
          ? 'community/red_bg_left'
          : 'community/red_bg_right';
      return MyImage(
        '$assetPath'.svgAssets(),
        width: 155.5.w,
        height: 36.w,
        fit: BoxFit.fill,
      );
    }

    // 已投票时使用三段式的拼接图片
    String basePath = left
        ? 'community/red_bg_left_selected'
        : 'community/red_bg_right_selected';

    return Row(
      children: [
        // 固定的左侧或者右侧（第1段）
        MyImage(
          '${basePath}_1'.pngAssets(),
          width: left ? 18.5.w : 10.w, // 左右两端固定宽度
          height: 36.w,
          fit: BoxFit.fill,
        ),
        // 中间部分可拉伸（第2段）
        Expanded(
          child: MyImage(
            '${basePath}_2'.pngAssets(),
            width: max(((308.w -57.w)  * percentage) , 0), // 计算中间可变部分的宽度，确保不为负数
            height: 36.w,
            fit: BoxFit.fill,
          ),
        ),
        // 固定的右侧或者左侧（第3段）
        MyImage(
          '${basePath}_3'.pngAssets(),
          width: left ? 10.w : 18.5.w, // 左右两端固定宽度
          height: 36.w,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}


