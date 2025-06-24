import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handing_fee_agent/invite_history_handling_fee_agent_view_view.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handling_fee/views/invite_history_handling_fee_view.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/user_agent/invite_users_history_agent_view.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/users/invite_users_history_view.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_history/spot_history_main/controllers/spot_history_main_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/app_text_style.dart';
import '../../../../../../widgets/basic/my_tab_underline_widget.dart';

class InviteHistoryMainView extends GetView<SpotHistoryMainController> {
  const InviteHistoryMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: Text(
          LocaleKeys.user44.tr,
        ),
        centerTitle: true,
        actions: [
          Center(
              child: InkWell(
            onTap: () {
              Get.toNamed(Routes.WEBVIEW,
                  arguments: {'url': LinksGetx.to.inviteRules});
            },
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                LocaleKeys.user52.tr,
                style: AppTextStyle.f_14_500,
              ),
            ),
          ))
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            _buildTabBar(Theme.of(context)),
            Expanded(
              child: GetBuilder<UserGetx>(builder: (userGetx) {
                return TabBarView(children: [
                  KeepAliveWrapper(
                      child: !userGetx
                              .isCoAgent //是否经纪人 //TODO: mock 数据,注意提交时修改加!
                          ? InviteHistoryHandlingFeeView()
                          : InviteHistoryHandlingFeeAgentViewView()), //手续费返佣
                  KeepAliveWrapper(
                      child: !userGetx
                              .isCoAgent //是否经纪人 //TODO: mock 数据,注意提交时修改加!
                          ? InviteUsersHistoryView() //邀请记录 InviteUsersHistoryAgentView
                          : InviteUsersHistoryAgentView()), //邀请记录
                ]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(ThemeData themeData) {
    return Container(
      height: 40.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1.w,
          ),
        ),
      ),
      child: GetBuilder<UserGetx>(builder: (userGetx) {
        return Row(
          children: [
            4.horizontalSpace,
            TabBar(
              isScrollable: true,
              indicator: const MyUnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2,
                  color: AppColor.color111111,
                ),
              ),
              labelColor: AppColor.color111111,
              unselectedLabelColor: AppColor.colorABABAB,
              labelStyle: AppTextStyle.f_14_500,
              unselectedLabelStyle: AppTextStyle.f_14_500,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: LocaleKeys.user53.tr), //手续费返佣
                Tab(
                  text: !userGetx.isCoAgent
                      ? LocaleKeys.user303.tr //邀请用户明细
                      : LocaleKeys.user302.tr, //邀请用户
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
