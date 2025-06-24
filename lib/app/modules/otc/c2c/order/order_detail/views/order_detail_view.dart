import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_record.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/controllers/order_list_controller.dart';

import '../controllers/order_detail_controller.dart';
import 'order_list_page.dart';

class OrderDetailView extends StatefulWidget {
  final RecordTabType tabType;
  const OrderDetailView({super.key, required this.tabType});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  late OrderDetailController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = Get.find<OrderDetailController>(tag: widget.tabType.key);
    ; //Get.put(OrderDetailController(index: widget.tabType), tag: widget.tabType.key, permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTabbar(controller),
        16.verticalSpace,
        Expanded(
            child: TabBarView(
          controller: controller.tab,
          children: controller.list
              .map((e) => GetBuilder<OrderListController>(
                  tag: '${widget.tabType.key}${e.title()}',
                  init: OrderListController(widget.tabType, e),
                  builder: (controller) {
                    return OrderListPage(orderType: e, tabType: widget.tabType);
                  }))
              .toList(),
        ))
      ],
    );
  }

  Widget buildTabbar(OrderDetailController controller) {
    return ValueListenableBuilder(
        valueListenable: controller.record,
        builder: (context, value, _) {
          return Container(
            color: AppColor.colorWhite,
            // color: Colors.yellow,
            alignment: Alignment.centerLeft,
            // color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 22.h,
            child: Stack(
              children: [
                TabBar(
                  onTap: (index) {},
                  controller: controller.tab,
                  isScrollable: true,
                  unselectedLabelColor: AppColor.colorABABAB,
                  labelColor: AppColor.color111111,
                  // labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, ),
                  // unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, ),

                  labelStyle: AppTextStyle.f_12_500,
                  unselectedLabelStyle: AppTextStyle.f_12_500,
                  indicatorSize: TabBarIndicatorSize.tab,
                  // indicatorPadding: EdgeInsets.only(left: 0, right: 0, top: 4.h, bottom: 4.h),
                  labelPadding: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 2.w, bottom: 0),
                  indicator: BoxDecoration(
                      // color: AppColor.colorEEEEEE,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: AppColor.color111111)),
                  tabs: controller.list
                      .map((f) => Tab(
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(f.title())),
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Visibility(
                                      visible: f == OTCOrderType.complain &&
                                          value?.isComplaining == true,
                                      child: Container(
                                        width: 4.w,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                            color: AppColor.colorEA1F1F,
                                            shape: BoxShape.circle),
                                      ),
                                    )),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          );
          ;
        });
  }
}
