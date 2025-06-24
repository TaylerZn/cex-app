import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/im/chat/widgets/message_tip_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/im/chat/widgets/order_state_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/im/widgets/chat_bottom_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/im/widgets/message_item.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';

import '../controllers/chat_controller.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              leading: const MyPageBackWidget(),
              title: Text(
                controller.other?.otcNickName ?? '',
                style: AppTextStyle.f_16_500.color111111,
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                color: AppColor.colorF5F5F5,
                child: Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        controller: controller.scrollController,
                        slivers: [
                          if (controller.orderState != null)
                            SliverPadding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 10.h,
                              ),
                              sliver: SliverToBoxAdapter(
                                child: OrderStateWidget(
                                  orderState: controller.orderState,
                                ),
                              ),
                            ),
                          if ((controller.orderState?.isBUy ?? false) &&
                              (controller.orderState?.status ?? 0) < 6)
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              sliver: SliverToBoxAdapter(
                                child: MessageTipWidget(
                                  seller: controller.other,
                                ),
                              ),
                            ),
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final message = controller.messages[index];
                                  return MessageItem(
                                    content: message.content,
                                    time: message.timeStr,
                                    avatar: message.from ==
                                            controller.me?.uid.toString()
                                        ? controller.me?.imageUrl ?? ''
                                        : controller.other?.imageUrl ?? '',
                                    picUrl: message.content.isImageFileName
                                        ? message.content
                                        : '',
                                    isSender: message.from ==
                                        controller.me?.uid.toString(),
                                    uid: message.from,
                                  );
                                },
                                childCount: controller.messages.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ChatBottomWidget(
                      onSend: (value) {
                        controller.sendTextMessage(value);
                      },
                      onSendImage: (value) {
                        controller.sendImageMessage(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
        );
      },
    );
  }
}
