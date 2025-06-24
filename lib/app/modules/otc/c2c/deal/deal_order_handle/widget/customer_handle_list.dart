import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_mixin.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_handle/controllers/customer_handle_controller.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderHandelListView extends StatelessWidget {
  const CustomerOrderHandelListView({super.key, required this.controller});
  final CustomerOrderHandleController controller;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshVC,
      enablePullDown: true,
      onRefresh: () async {
        await controller.getData();
        controller.refreshVC.refreshToIdle();
        controller.refreshVC.loadComplete();
      },
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
            child: Column(
              children: <Widget>[
                CustomerDealOrderTopView(controller: controller),
                CustomerDealOrderMidView(controller: controller)
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class CustomerDealOrderTopView extends StatelessWidget {
  const CustomerDealOrderTopView({super.key, required this.controller});
  final CustomerOrderHandleController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          children: [
            Text(
              LocaleKeys.c2c228.tr,
              style: AppTextStyle.f_20_600.color111111,
            ),
          ],
        ).marginOnly(bottom: 6.h),
        Row(
          children: [
            Obx(() => controller.limitTimeStr.value.isNotEmpty
                ? Text(
                    LocaleKeys.c2c217.tr,
                    style: AppTextStyle.f_12_400.color666666,
                  )
                : const SizedBox()),
            SizedBox(width: 4.h),
            Obx(() => Text(
                  controller.limitTimeStr.value,
                  style: AppTextStyle.f_12_400.color333333,
                ))
          ],
        ),
        CustomerDealOrderTop(
            icon: controller.model.chartModel.icon,
            usernameStr: controller.model.chartModel.usernameStr,
            latestNewsStr: controller.model.chartModel.latestNewsStr,
            countStr: controller.model.chartModel.countStr,
            orderId: controller.model.detailModel.idNum)
      ],
    );
  }
}

class CustomerDealOrderMidView extends StatelessWidget with CustomerOrderRow {
  const CustomerDealOrderMidView({super.key, required this.controller});
  final CustomerOrderHandleController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 26.w,
          top: 20.h,
          bottom: 20.h,
          child: CustomPaint(
              painter: DashedBorderPainter(
            color: AppColor.colorBBBBBB,
            strokeWidth: 1,
            dashWidth: 4,
            gapWidth: 5,
          )),
        ),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColor.colorEEEEEE),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 8.w),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: ShapeDecoration(
                                color: AppColor.color111111,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Text('1',
                                  style: AppTextStyle.f_12_600.colorWhite)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
                        child: Text(LocaleKeys.c2c229.tr,
                            style: AppTextStyle.f_14_500.color666666),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Text(controller.model.detailModel.paymentStr,
                        style: AppTextStyle.f_14_500.color0C0D0F),
                  ),
                ],
              ).paddingOnly(bottom: 20.h),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 8.w),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: ShapeDecoration(
                                    color: AppColor.color111111,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                  child: Text('2',
                                      style: AppTextStyle.f_12_600.colorWhite)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
                            child: Text(LocaleKeys.c2c230.tr,
                                style: AppTextStyle.f_14_500.color666666),
                          )
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.h, right: 4.w),
                        child: Text(controller.model.detailModel.totalPriceStr,
                            style: AppTextStyle.f_18_600.color111111),
                      ),
                      GestureDetector(
                          onTap: () {
                            CopyUtil.copyText(
                                controller.model.detailModel.totalPriceStr);
                          },
                          child: Text(LocaleKeys.public6.tr,
                              style: AppTextStyle.f_12_400.color0075FF)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                        margin: EdgeInsets.only(top: 10.h, bottom: 16.h),
                        decoration: ShapeDecoration(
                          color: AppColor.colorF5F5F5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Column(
                          children: <Widget>[
                            getRow(LocaleKeys.c2c52.tr,
                                controller.model.detailModel.paymentUseNameStr,
                                haveCopy: true,
                                top: 16,
                                style: AppTextStyle.f_12_600.color333333),
                            getRow(LocaleKeys.c2c54.tr,
                                controller.model.detailModel.paymentAccountStr,
                                haveCopy: true,
                                top: 16,
                                style: AppTextStyle.f_12_600.color333333),
                            getRow(LocaleKeys.c2c57.tr,
                                controller.model.detailModel.paymentStr,
                                haveCopy: true,
                                top: 16,
                                style: AppTextStyle.f_12_600.color333333),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(LocaleKeys.c2c231.tr,
                                        style:
                                            AppTextStyle.f_12_400.color666666)
                                    .paddingOnly(right: 30.w),
                                Expanded(
                                    child: Text(
                                        controller
                                            .model.detailModel.descriptionStr,
                                        style:
                                            AppTextStyle.f_12_400.color666666))
                              ],
                            ).paddingOnly(top: 16.h)
                          ],
                        ),
                      ),
                      Text(LocaleKeys.c2c224.tr,
                              style: AppTextStyle.f_12_500.color333333)
                          .marginOnly(bottom: 10.h),
                      Text(LocaleKeys.c2c232.tr,
                          style: AppTextStyle.f_12_400_15.color666666)
                    ],
                  ).paddingOnly(left: 26.w)
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: ShapeDecoration(
                        color: AppColor.color111111,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child:
                          Text('3', style: AppTextStyle.f_12_600.colorWhite)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 0.w, bottom: 2.h),
                      child: Text(LocaleKeys.c2c233.tr,
                          style: AppTextStyle.f_14_500.color666666.ellipsis),
                    ),
                  )
                ],
              ).marginOnly(top: 20.h)
            ],
          ),
        )
      ],
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double gapWidth;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.gapWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();

    for (double i = 0; i < size.height; i += dashWidth + gapWidth) {
      path.moveTo(0, i);
      path.lineTo(0, i + dashWidth);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
