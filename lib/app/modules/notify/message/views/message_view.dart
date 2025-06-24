import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/notify/message/models/message_list_models.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_appbar_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../widgets/no/loading_widget.dart';
import '../../../../widgets/no/no_data.dart';
import '../controllers/message_list_controller.dart';
import '../widget/message_item_widget.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(myTitle: Get.arguments?['title'] ?? ''),
        body: GetBuilder<MessageListController>(
            init: MessageListController(),
            builder: (controller) {
              return controller.pageObx(
                (state) {
                  return SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: () => controller.refreshData(true),
                    onLoading: controller.loadMoreData,
                    enablePullUp: true,
                    enablePullDown: true,
                    child: ListView.builder(
                      itemCount: state?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (index < 0 || index >= state!.length) {
                          return Container(); // or handle the error appropriately
                        }
                        return MessageItemWidget(
                          messageInfo: state[index],
                          messageIcon: controller
                              .getMessageIcon(state[index].messageType ?? 0),
                          isShowContent: controller.messageType == 1,
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
              );
            }));
  }

  showSheetView(
      List<MessageListModel> array, MessageListController controller) {
    // 临时变量用于保存选中的 messageType
    int tempMessageType = controller.messageType;

    showModalBottomSheet(
        context: Get.context!,
        useSafeArea: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColor.colorWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
                padding: EdgeInsets.only(
                    bottom: 16.h + MediaQuery.of(context).padding.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 19.h, horizontal: 16.w),
                        child: Text(LocaleKeys.user222.tr,
                            style: AppTextStyle.f_20_600)),
                    WaterfallFlow.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                            // 更新临时的 messageType，改变选中样式
                            setState(() {
                              tempMessageType = array[index].id;
                            });
                          },
                          child: Container(
                            height: 28.h,
                            padding: EdgeInsets.symmetric(horizontal: 6.5.h),
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: array[index].id != tempMessageType
                                    ? const BorderSide(
                                        width: 1, color: AppColor.colorEEEEEE)
                                    : const BorderSide(
                                        width: 1, color: AppColor.color4D4D4D),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              array[index].name,
                              style: AppTextStyle.f_13_400.copyWith(
                                color: array[index].id != tempMessageType
                                    ? AppColor.color999999
                                    : AppColor.color111111,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider().marginOnly(bottom: 16.h, top: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: MyButton.borderWhiteBg(
                            height: 48.w,
                            text: LocaleKeys.public2.tr,
                            onTap: () {
                              // 点击取消按钮，恢复原来的 messageType
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
                            // 点击确认按钮，更新 controller 的 messageType 并刷新数据
                            controller.messageType = tempMessageType;
                            controller.refreshData(false);
                            Get.back();
                          },
                        )),
                      ],
                    ).paddingSymmetric(horizontal: 16.w),
                  ],
                ),
              );
            },
          );
        });
  }
}
