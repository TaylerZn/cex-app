import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/im/widgets/chat_bottom_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/im/widgets/message_item.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/appeal_controller.dart';

class AppealView extends StatelessWidget {
  const AppealView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppealController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              leading: const MyPageBackWidget(),
              title: Text(
                LocaleKeys.c2c113.tr,
                style: AppTextStyle.f_16_500.color111111,
              ),
              centerTitle: true,
            ),
            backgroundColor: AppColor.colorF5F5F5,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      controller: controller.scrollController,
                      itemCount: controller.rqReplyList.length,
                      itemBuilder: (context, index) {
                        final item = controller.rqReplyList[index];
                        return MessageItem(
                          content: item.replayContent ?? '',
                          time: item.timeStr,
                          avatar:
                              UserGetx.to.user!.info?.profilePictureUrl ?? '',
                          picUrl: item.contentType == 2
                              ? item.replayContent ?? ''
                              : '',
                          isSender: item.userId == UserGetx.to.user!.info?.id,
                          uid: item.userId.toString() ?? '',
                        );
                      },
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
        );
      },
    );
  }
}
