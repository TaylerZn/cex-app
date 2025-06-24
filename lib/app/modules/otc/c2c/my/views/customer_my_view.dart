import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/verify_info_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/customer_my_controller.dart';

class CustomerMyView extends GetView<CustomerMyController> {
  const CustomerMyView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerMyController>(builder: (controller) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (controller.userInfo?.isMerchant == false &&
                        OtcConfigUtils().showApplyTip == true)
                    ? GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.MERCHANT_APPLY);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          margin: EdgeInsets.only(bottom: 24.w),
                          decoration: ShapeDecoration(
                            color: const Color(0x33FFD428),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          child: Row(
                            children: [
                              MyImage(
                                'otc/c2c/c2c_merchant_star_0'.svgAssets(),
                                width: 24.w,
                                height: 24.w,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: Text(
                                    LocaleKeys.c2c318.tr,
                                    style: AppTextStyle.f_14_600.color111111,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  OtcConfigUtils().showApplyTip = false;
                                  controller.update();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: MyImage(
                                    'otc/c2c/c2c_merchant_close'.svgAssets(),
                                    width: 13.w,
                                    height: 13.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                UserAvatar(
                  controller.userInfo?.headImage,
                  width: 60.w,
                  height: 60.w,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Text('${Get.find<UserGetx>().userName}'.stringSplit(),
                        style: AppTextStyle.f_20_600),
                    SizedBox(width: 4.w),
                    controller.userInfo?.isMerchant == true
                        ? MyImage(
                            'otc/c2c/c2c_merchant_star_${controller.userInfo?.merchant?.type ?? 0}'
                                .svgAssets(),
                            width: 18.w,
                            height: 18.w,
                          )
                        : Visibility(
                            visible: UserGetx.to.isKyc,
                            child: MyImage(
                              'otc/c2c/verify_emblem'.svgAssets(),
                              width: 18.w,
                              height: 18.w,
                            ),
                          )
                  ],
                ),
                16.h.verticalSpace,
                VerifyInfoWidget(userInfo: controller.userInfo),
                16.h.verticalSpace,
                _buildHistory(),
                _buildDetail(context)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHistory() {
    Widget buildContent(String title, String subTitle, TextStyle style) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.f_14_400.color666666),
          Text(subTitle, style: style)
        ],
      );
    }

    return Column(
      children: [
        Container(
            width: double.infinity, height: 1.h, color: AppColor.colorEEEEEE),
        SizedBox(height: 17.h),
        buildContent(
            LocaleKeys.c2c4.tr,
            '${controller.userInfo?.completeOrders ?? 0}',
            AppTextStyle.f_14_600),
        SizedBox(height: 10.h),
        buildContent(
            LocaleKeys.c2c5.tr,
            controller.userInfo?.completeOrderRate ?? '0%',
            AppTextStyle.f_14_600),
        SizedBox(height: 10.h),
        buildContent(LocaleKeys.c2c6.tr,
            controller.userInfo?.payTime ?? '00:00:00', AppTextStyle.f_14_400),
        SizedBox(height: 10.h),
        buildContent(LocaleKeys.c2c7.tr,
            controller.userInfo?.passTime ?? '00:00:00', AppTextStyle.f_14_400),
        SizedBox(height: 16.h),
        Container(
            width: double.infinity, height: 1.h, color: AppColor.colorEEEEEE),
      ],
    );
  }

  Widget _buildDetail(BuildContext context) {
    List<MenuEntry> temp = [
      MenuEntry(
        name: LocaleKeys.c2c9.tr,
        onTap: () {
          Get.toNamed(Routes.COMISSION_METHOD);
        },
      ),
      MenuEntry(
        name: LocaleKeys.c2c10.tr,
        onTap: () {
          // Get.toNamed(Routes.C2C_APPLY);
          Get.toNamed(Routes.MERCHANT_APPLY);
        },
      ),
      MenuEntry(
        name: LocaleKeys.c2c11.tr,
        onTap: () {
          Get.toNamed(Routes.WEBVIEW,
              arguments: {'url': LinksGetx.to.onlineServiceProtocal});
        },
      ),
    ];
    if (controller.userInfo?.isMerchant == true) {
      temp.insert(
          0,
          MenuEntry(
            name: LocaleKeys.c2c8.tr,
            onTap: () {
              Get.toNamed(Routes.COMMISSION_RECORD);
            },
          ));
    }
    List<MenuEntry> _entries(BuildContext context) {
      return temp;
    }

    return universalListWidget(
      context,
      _entries,
    );
  }
}
