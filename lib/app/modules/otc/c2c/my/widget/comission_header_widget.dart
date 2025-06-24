import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/sales_comission/controllers/sales_comission_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ComissionHeaderWidget extends StatelessWidget {
  final bool sales;
  ComissionHeaderWidget({super.key, this.sales = true});
  final controller = Get.find<SalesComissionController>();

  @override
  Widget build(BuildContext context) {
    CustomerCoinModel? model = OtcConfigUtils()
        .coinModel
        ?.records
        ?.firstWhereOrNull((element) => element.coinSymbol == 'USDT');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 45.h,
      decoration: BoxDecoration(
          color: AppColor.colorF5F5F5,
          borderRadius: BorderRadius.all(Radius.circular(6.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(controller.type == 0 ? LocaleKeys.b2c8.tr : LocaleKeys.b2c4.tr,
              style: controller.type == 0
                  ? AppTextStyle.f_14_500.upColor
                  : AppTextStyle.f_14_500.downColor),
          Row(
            children: [
              ObjectUtil.isNotEmpty(model?.icon)
                  ? MyImage(model!.icon!, width: 18.w, height: 18.h)
                  : SizedBox(),
              4.horizontalSpace,
              Text('USDT', style: AppTextStyle.f_14_500)
            ],
          )
        ],
      ),
    );
  }
}
