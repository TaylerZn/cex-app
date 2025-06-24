import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/views/customer_toc_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/views/customer_my_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/views/customer_order_view.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/customer_index_controller.dart';

class CustomerIndexView extends GetView<CustomerIndexController> {
  const CustomerIndexView({super.key, this.callback});
  final Function(int)? callback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.index.value,
          children: const [
            CustomerTocView(),
            KeepAliveWrapper(child: CustomerOrderView()),
            CustomerMyView()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
            width: 0.5,
            color: AppColor.colorEEEEEE,
          )),
        ),
        child: Obx(() => BottomNavigationBar(
            onTap: (index) {
              if (UserGetx.to.isLogin) {
                controller.index.value = index;
                callback?.call(index);
              } else {
                if (index != 0) {
                  UserGetx.to.goIsLogin();
                }
              }
            },
            items: [
              MapEntry('C2C'.tr, 'otc/c2c/customer_bar_home'),
              MapEntry(LocaleKeys.c2c145.tr, 'otc/c2c/customer_bar_order'),
              MapEntry(LocaleKeys.c2c158.tr, 'otc/c2c/customer_bar_me'),
            ]
                .map((item) => BottomNavigationBarItem(
                    label: item.key,
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: MyImage(
                        item.value.svgAssets(),
                        width: 18.w,
                        height: 18.w,
                        color: AppColor.colorABABAB,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: MyImage(
                        item.value.svgAssets(),
                        width: 18.w,
                        height: 18.w,
                        color: AppColor.color0C0D0F,
                      ),
                    )))
                .toList(),
            currentIndex: controller.index.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.colorWhite,
            selectedLabelStyle: AppTextStyle.f_10_400,
            unselectedLabelStyle: AppTextStyle.f_10_400,
            selectedItemColor: AppColor.color0C0D0F,
            unselectedItemColor: AppColor.colorABABAB)),
      ),
    );
  }
}
