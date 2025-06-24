import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_list.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../../models/otc/c2c/advert_model.dart';

class PersonalRecordRow extends StatelessWidget {
  final Function? onTap;
  final DataList? data;
  const PersonalRecordRow({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.colorEEEEEE),
          borderRadius: BorderRadius.all(
            Radius.circular(6.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            Row(
              children: [
                MyImage(data?.coinIcon ?? '', width: 16.w, height: 16.h),
                4.w.horizontalSpace,
                Text(data?.coin ?? 'USDT')
              ],
            ),
            11.verticalSpace,
            Container(height: 1, color: AppColor.colorEEEEEE),
            11.verticalSpace,
            Text('${data?.paycoinSymbol ?? '\$'}${data?.price}',
                style: AppTextStyle.f_20_400),
            10.verticalSpace,
            Text('数量:${data?.volume}'),
            6.verticalSpace,
            Text(
                '限额:${data?.paycoinSymbol ?? '\$'}${data?.minTrade?.removeInvalidZero()} - ${data?.paycoinSymbol ?? '\$'}${data?.maxTrade?.removeInvalidZero()}'),
            11.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomerPayview(
                    name: data?.payments?.first.payment ?? '',
                    title: data?.payments?.first.payTitle ?? '',
                    height: 10.h,
                    width: 4.w,
                    style: AppTextStyle.f_10_400),
                MyButton(
                    onTap: () {
                      onTap?.call();
                    },
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    textStyle: AppTextStyle.f_12_400,
                    height: 28.h,
                    text: data?.isPurchase == true ? '出售' : '购买')
              ],
            ),
            16.verticalSpace,
          ],
        ));
  }
}
