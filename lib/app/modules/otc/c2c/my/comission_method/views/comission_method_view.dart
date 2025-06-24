import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_method_row.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/footer_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../models/otc/c2c/payment_info.dart';
import '../../../../../../widgets/no/no_data.dart';
import '../controllers/comission_method_controller.dart';

class ComissionMethodView extends GetView<ComissionMethodController> {
  const ComissionMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          title: Text(LocaleKeys.c2c47.tr),
          centerTitle: true,
        ),
        body: GetBuilder<ComissionMethodController>(builder: (controller) {
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Expanded(
                    child: controller.paymentList.isEmpty
                        ? !controller.isRequest
                            ? SizedBox()
                            : noDataWidget(context, text: LocaleKeys.c2c312.tr)
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: controller.paymentList.length,
                            itemBuilder: (context, index) {
                              PaymentInfo? paymentInfo = controller.paymentList[index];
                              return ComissionMethodRow(
                                  paymentInfo: paymentInfo,
                                  onTap: (index) {
                                    controller.performAction(index, paymentInfo);
                                  });
                            }))),
                CustomerFooterWidget(
                    text: LocaleKeys.c2c37.tr,
                    onTap: () {
                      Get.toNamed(Routes.PAYMENT_CHANNEL);
                    })
              ],
            ),
          );
        }));
  }
}
