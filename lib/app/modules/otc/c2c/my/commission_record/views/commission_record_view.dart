import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/advert_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/commission_record/widget/comission_record_row.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_out_line_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../../generated/locales.g.dart';
import '../controllers/commission_record_controller.dart';

class CommissionRecordView extends GetView<CommissionRecordController> {
  const CommissionRecordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(LocaleKeys.c2c174.tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _contentList()),
          Container(height: 1.h, color: AppColor.colorECECEC),
          Container(

              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.w),
              height: 110.h,
              alignment: Alignment.topCenter,

              child: Row(
                children: [
                  Expanded(
                      child: MyButton(
                          text: LocaleKeys.c2c26.tr,
                          onTap: () async {
                            await Get.toNamed(Routes.SALES_COMISSION,
                                arguments: {"type": 0});
                            controller.refreshData(false);
                          },
                          backgroundColor: AppColor.colorWhite,
                          color: AppColor.color111111,
                          height: 46.h,
                          border: Border.all(color: AppColor.colorABABAB))),
                  SizedBox(width: 7.w),
                  Expanded(
                      child: MyButton(
                          text: LocaleKeys.c2c27.tr,
                          onTap: () async {
                            await Get.toNamed(Routes.SALES_COMISSION,
                                arguments: {"type": 1});
                            controller.refreshData(false);
                          },
                          backgroundColor: AppColor.colorWhite,
                          color: AppColor.color111111,
                          height: 46.h,
                          border: Border.all(color: AppColor.colorABABAB))),
                ],
              )),
        ],
      ),
    );
  }

  Widget _contentList() {
    return controller
        .pageObx(onRetryRefresh: () => controller.refreshData(false), (data) {
      return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onRefresh: () async {
            await controller.refreshData(false);
            controller.refreshController.refreshToIdle();
            controller.refreshController.loadComplete();
          },
          onLoading: () async {
            await controller.loadMoreData();
          },
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: data?.length,
              itemBuilder: (context, index) {
                DataList? datalist = data?[index];
                return ComissionRecordRow(data: datalist,onTap: (){
                    controller.cancelAdvert(datalist);
                });
              }));
    });
  }
}
