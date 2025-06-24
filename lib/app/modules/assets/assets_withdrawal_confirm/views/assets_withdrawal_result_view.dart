import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_withdrawal_confirm/controllers/assets_withdrawal_result_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsWithdrawalResultView
    extends GetView<AssetsWithdrawalResultController> {
  const AssetsWithdrawalResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsWithdrawalResultController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            leading: const MyPageBackWidget(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(
                24.w, 16.h, 24.w, MediaQuery.of(context).padding.bottom),
            child: MyButton(
                height: 48.h,
                text: LocaleKeys.assets130.tr,
                color: AppColor.colorWhite,
                backgroundColor: AppColor.color111111,
                borderRadius: BorderRadius.all(Radius.circular(60.r)),
                onTap: () async {
                  controller.jumpToTheHistory();
                }),
          ));
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24.h),
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          MyImage(
            height: 64.h,
            width: 64.w,
            'assets/sand_clock'.svgAssets(),
          ),
          24.verticalSpaceFromWidth,
          Text(
            LocaleKeys.assets131.tr,
            style: AppTextStyle.f_16_400.color4D4D4D,
          ),
          Text(
            '${Decimal.parse(controller.amount)} ${controller.currency}',
            style: AppTextStyle.f_28_600.color111111,
          ),
          24.verticalSpaceFromWidth,
          Container(
            margin: EdgeInsets.only(left: 85.w, right: 85.w),
            child: Text(
              textAlign: TextAlign.center,
              LocaleKeys.assets132.tr,
              style: AppTextStyle.f_12_400.color999999,
            ),
          ),
        ],
      ),
    );
  }
}
