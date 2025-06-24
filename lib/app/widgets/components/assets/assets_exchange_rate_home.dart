import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsExchangeRateHome extends StatelessWidget {
  const AssetsExchangeRateHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsGetx>(builder: (assetsGetx) {
      return InkWell(
          onTap: () async {
            await showExchangeRateSheetView();
            AssetsGetx.to.update();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(assetsGetx.rateCoin, style: AppTextStyle.f_12_500.color4D4D4D),
              SizedBox(
                width: 1.w,
              ),
              MyImage(
                'my/assets_exchange_rate'.svgAssets(),
                width: 7.w,
                color: AppColor.color666666,
              )
            ],
          ));
    });
  }
}

showExchangeRateSheetView() {
  showModalBottomSheet(
    context: Get.context!,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 21.h),
            GetBuilder<AssetsGetx>(builder: (assetsGetx) {
              return Container(
                  constraints: BoxConstraints(maxHeight: 260.h),
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: assetsGetx.rateList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          assetsGetx.rateCurrentIndex = index;
                          assetsGetx.update();
                          assetsGetx.getRefresh();
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: index == assetsGetx.rateCurrentIndex ? AppColor.colorF5F5F5 : Colors.transparent),
                          child: DecoratedBox(
                            decoration: const BoxDecoration(color: Colors.transparent),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${assetsGetx.rateList[index].langCoin}',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColor.color111111,
                                      fontWeight: FontWeight.w600,
                                    )),
                                index == assetsGetx.rateCurrentIndex ? const Icon(Icons.check) : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ));
            }),
            const Divider(),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: MyButton.borderWhiteBg(
                text: LocaleKeys.public2.tr,
                color: AppColor.color111111,
                height: 48.w,
                borderRadius: BorderRadius.circular(100.r),
                textStyle: AppTextStyle.f_16_600,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom)
          ],
        ),
      );
    },
  );
  // MediaQuery.of(context).padding.bottom
}
