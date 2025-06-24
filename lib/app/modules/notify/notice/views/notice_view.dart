import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../widgets/no/loading_widget.dart';
import '../../../../widgets/no/no_data.dart';
import '../controllers/notice_controller.dart';
import '../widget/notice_item_widget.dart';

class NoticeListView extends StatelessWidget {
  const NoticeListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<NoticeController>(
            init: NoticeController(),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  leading: const MyPageBackWidget(),
                  title: const Center(child: Text('')),
                ),
                body: Column(children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        LocaleKeys.user255.tr,
                        style: AppTextStyle.f_24_600.color111111,
                      )),
                  Expanded(
                    child: controller.obx(
                      (state) {
                        return SmartRefresher(
                          controller: controller.refreshController,
                          onRefresh: () => controller.onRefresh(true),
                          onLoading: () {
                            controller.onLoadMore();
                          },
                          enablePullUp: true,
                          enablePullDown: true,
                          child: ListView.builder(
                            itemCount: state?.length ?? 0,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemBuilder: (context, index) {
                              return NoticeItemWidget(
                                noticeInfo: state![index],
                              );
                            },
                          ),
                        );
                      },
                      onLoading: const LoadingWidget(),
                      onError: (error) => noDataWidget(
                        context,
                        text: error.toString(),
                      ),
                      onEmpty: noDataWidget(
                        context,
                        text: LocaleKeys.public8.tr,
                      ),
                    ),
                  )
                ]),
              );
            }));
  }

  showSheetView(List array, NoticeController controller) {
    showModalBottomSheet(
        context: Get.context!,
        useSafeArea: true,
        builder: (BuildContext context) {
          return GetBuilder<NoticeController>(
              init: NoticeController(),
              builder: (controller) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColor.colorWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                  ),
                  padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: 16.w + MediaQuery.of(context).padding.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
                          child: Text(
                            LocaleKeys.user222.tr,
                            style: TextStyle(
                              color: AppColor.color111111,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      WaterfallFlow.builder(
                        shrinkWrap: true,
                        itemCount: array.length,
                        gridDelegate:
                            SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 12.w,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.onTypeChange(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: index != controller.messageType
                                      ? const BorderSide(
                                          width: 1, color: AppColor.colorEEEEEE)
                                      : const BorderSide(
                                          width: 1,
                                          color: AppColor.color4D4D4D),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Text(array[index],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColor.color111111,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          );
                        },
                      ),
                      const Divider().marginOnly(bottom: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: MyButton.borderWhiteBg(
                              height: 48.w,
                              text: LocaleKeys.public2.tr,
                              onTap: () {
                                Get.back();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Expanded(
                              child: MyButton(
                            height: 48.w,
                            text: LocaleKeys.public1.tr,
                            onTap: () {
                              controller.onRefresh(false);
                              Get.back();
                            },
                          )),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
    // MediaQuery.of(context).padding.bottom
  }
}
