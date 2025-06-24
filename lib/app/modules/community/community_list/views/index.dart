import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/controllers/community_list_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'community_list_view.dart';

class CommunityIndexPage extends StatefulWidget {
  const CommunityIndexPage({super.key});

  @override
  State<CommunityIndexPage> createState() => _CommunityIndexPageState();
}

class _CommunityIndexPageState extends State<CommunityIndexPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  List<String> keys = ['Market1', 'Market2'];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      if (!controller.indexIsChanging) {
        Bus.getInstance().emit(EventType.postSend, null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content() {
      if (!UserGetx.to.isLogin) {
        return GetBuilder<CommunityListController>(
            init: CommunityListController(tagKey: 'Market1'),
            tag: 'Market1',
            builder: (controller) {
              return CommunityListView(tagKey: 'Market1');
            });
      }
      return Column(
        children: [
          _buildTab(),
          Expanded(
              child: TabBarView(controller: controller, children: [
            GetBuilder<CommunityListController>(
                init: CommunityListController(tagKey: 'Market1'),
                tag: 'Market1',
                builder: (controller) {
                  return CommunityListView(tagKey: 'Market1');
                }),
            GetBuilder<CommunityListController>(
                init: CommunityListController(tagKey: 'Market2'),
                tag: 'Market2',
                builder: (controller) {
                  return CommunityListView(tagKey: 'Market2');
                }),
            // CommunityListView(tagKey: 'Market2')
          ]))
        ],
      );
    }

    return GetBuilder<UserGetx>(
      builder: (_) {
        return KeepAliveWrapper(child: content());
      },
    );
  }

  _buildTab() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 38.w,
            child: TabBar(
              controller: controller,
              isScrollable: true,
              labelColor: AppColor.color111111,
              // indicator: ShapeDecoration(
              //     color: AppColor.colorFFFFFF,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.r),
              //     )),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppColor.colorTextPrimary,
                  width: 2.w,
                ),
              ),
              indicatorColor: Colors.transparent,
              labelStyle: AppTextStyle.f_16_500,
              unselectedLabelStyle: AppTextStyle.f_16_500.colorABABAB,
              tabs: [
                InkWell(
                    child: Tab(text: LocaleKeys.community42.tr),
                    onTap: () {
                      controller.index = 0;
                      Get.find<CommunityListController>(tag: 'Market1')
                          .backToTop(); //.isLogin
                    }), //'推荐'),
                InkWell(
                    child: Tab(text: LocaleKeys.community43.tr),
                    onTap: () {
                      controller.index = 1;
                      Get.find<CommunityListController>(tag: 'Market2')
                          .backToTop();
                    }), //'推荐'),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 0.6.w,
            color: AppColor.colorBorderGutter,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
