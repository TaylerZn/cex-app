import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take/widgets/my_take_list.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take/widgets/my_take_top.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import '../controllers/my_take_controller.dart';

class MyTakeView extends GetView<MyTakeController> {
  const MyTakeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorWhite,
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.MY_TAKE_MANAGE),
              icon: MyImage(
                'flow/follow_taker_set'.svgAssets(),
                width: 18,
              ),
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              MyTakeTop(controller: controller),
              MyTakeTabbar(
                controller: controller.tabController,
                dataArray: controller.tabs.map((e) => e.value).toList(),
              )
            ];
          },
          body: TabBarView(
            controller: controller.tabController,
            children: controller.tabs.map((type) {
              return Builder(builder: (context) {
                return MyTakeListView(
                  type: type,
                  controller: controller,
                );
              });
            }).toList(),
          ),
        ));
  }
}
