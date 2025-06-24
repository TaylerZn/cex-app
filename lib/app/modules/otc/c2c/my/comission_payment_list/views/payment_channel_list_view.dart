import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_public_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_list.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../../routes/app_pages.dart';

class PaymentChannelListView extends StatelessWidget {
  const PaymentChannelListView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isReceiver = Get.arguments?['isReceiver'] ?? false;

    return Scaffold(
      appBar: AppBar(
        leading: MyPageBackWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isReceiver ? LocaleKeys.c2c37.tr : LocaleKeys.c2c49.tr,
                style: AppTextStyle.f_24_600),
            4.verticalSpace,
            Text(isReceiver ? LocaleKeys.c2c317.tr : LocaleKeys.c2c50.tr),
            30.h.verticalSpace,
            Expanded(
                child: ListView.builder(
                    itemCount:
                        OtcConfigUtils().publicInfo?.payments?.length ?? 0,
                    itemBuilder: (context, index) {
                      CountryNumberInfo? info =
                          OtcConfigUtils().publicInfo?.payments?[index];
                      return InkWell(
                        onTap: () {
                          OtcConfigUtils().selectedInfo = info;
                          Get.offAndToNamed(Routes.COMISSION_CARD_FILL);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.h),
                          child: CustomerPayview(
                            height: 10.h,
                            width: 4.w,
                            style: AppTextStyle.f_16_600,
                            name: info?.key ?? '',
                            title: ' ${info?.title}',
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
