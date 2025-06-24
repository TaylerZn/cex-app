import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class NoticeDialog extends StatelessWidget {
  final String currency;
  final  String? withdrawMax;
  final  num? withdrawMaxDay;
  const NoticeDialog({super.key,this.withdrawMax,this.withdrawMaxDay, this.currency = 'USDT'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: 280.w,
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpaceFromWidth,
            Text(LocaleKeys.assets174.tr, style: AppTextStyle.f_16_600),
            12.verticalSpaceFromWidth,
            Text(LocaleKeys.assets211.tr, style: AppTextStyle.f_13_400.color4D4D4D), //24小时提现额度：
            8.verticalSpaceFromWidth,
            Text(
              '${withdrawMax}/${withdrawMaxDay} $currency',
              style: AppTextStyle.f_16_500.color111111,
            ),
            20.verticalSpaceFromWidth,
            MyButton(
              borderRadius: BorderRadius.all(Radius.circular(60.r)),
              text: LocaleKeys.public57.tr,
              textStyle: AppTextStyle.f_14_600,
              height: 36.w,
              onTap: () async {
                Get.back();
              },
            ),
            20.verticalSpaceFromWidth,
          ],
        ),
      ),
    );
  }
}
