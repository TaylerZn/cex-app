import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_top.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_list.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../controllers/my_follow_controller.dart';

//

class MyFollowView extends StatelessWidget {
  const MyFollowView({super.key, this.tag});
  final String? tag;
  @override
  Widget build(BuildContext context) {
    return tag != null
        ? GetBuilder<MyFollowController>(
            tag: tag,
            builder: (controller) {
              return Column(
                children: [
                  MyFollowTabbar(
                    controller: controller.tabController,
                    dataArray: controller.tabs.map((e) => e.value).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: controller.tabs.map((type) {
                        return Builder(builder: (context) {
                          return MyFollowListCell(
                            type: type,
                            controller: controller,
                          );
                        });
                      }).toList(),
                    ),
                  ),
                ],
              );
            })
        : GetBuilder<MyFollowController>(builder: (controller) {
            return Scaffold(
                backgroundColor: AppColor.colorWhite,
                appBar: AppBar(
                  leading: const MyPageBackWidget(),
                  title: Text(LocaleKeys.follow177.tr),
                  centerTitle: true,
                ),
                body: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      MyfollowTop(
                        controller: controller,
                      ),
                      SliverPinnedHeader(
                        child: MyFollowTabbar(
                          controller: controller.tabController,
                          dataArray: controller.tabs.map((e) => e.value).toList(),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: controller.tabController,
                    children: controller.tabs.map((type) {
                      return Builder(builder: (context) {
                        return MyFollowListCell(
                          type: type,
                          controller: controller,
                        );
                      });
                    }).toList(),
                  ),
                ));
          });
  }
}
