import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/widget/my_parting_list.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/widget/my_parting_top.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../controllers/my_take_parting_controller.dart';

class MyTakePartingView extends GetView<MyTakePartingController> {
  const MyTakePartingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorWhite,
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          centerTitle: true,
          title: Text(LocaleKeys.follow212.tr),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              MyPartTop(controller: controller),
              MyPartTabbar(
                  controller: controller.tabController,
                  dataArray: controller.tabs.map((e) => e.value).toList())
            ];
          },
          body: TabBarView(
            controller: controller.tabController,
            children: controller.tabs.map((type) {
              return Builder(builder: (context) {
                return MyPartingList(
                  type: type,
                  controller: controller,
                );
              });
            }).toList(),
          ),
        ));
  }
}

class MyPartTabbar extends StatelessWidget {
  const MyPartTabbar(
      {super.key, required this.dataArray, required this.controller});
  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
        ),
      ),
      height: 40.h,
      width: double.infinity,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.color999999,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_14_600,
        unselectedLabelStyle: AppTextStyle.f_14_600,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColor.colorBlack,
            width: 2.h,
          ),
          insets: EdgeInsets.only(left: 14.w, right: 14.w, top: 0, bottom: 0),
        ),
        labelPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    ));
  }
}
