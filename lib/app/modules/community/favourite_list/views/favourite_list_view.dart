import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/community/favourite_list/favourite_list_detail/controllers/favourite_list_detail_controller.dart';
import 'package:nt_app_flutter/app/modules/community/favourite_list/favourite_list_detail/views/favourite_list_detail_view.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../widgets/components/keep_alive_wrapper.dart';
import '../controllers/favourite_list_controller.dart';

class FavouriteListView extends GetView<FavouriteListController> {
  FavouriteListView({Key? key}) : super(key: key);
  List<String> list = [LocaleKeys.community30.tr,LocaleKeys.community31.tr]; //['点赞', '收藏'];
  List<String> keys = ['like', 'favourite'];

  @override
  Widget build(BuildContext context) {
    //return KeepAliveWrapper(child: FavouriteListDetailView(tagKey: keys[0]));

    return Column(
      children: [
        _buildTab(),
        Expanded(
          child: TabBarView(
            controller: controller.tab,
            children: list
                .map((e) {
                  int index = list.indexOf(e);
               return KeepAliveWrapper(child: FavouriteListDetailView(tagKey: keys[index]));
            })
                .toList(),
          ),
        )
      ],
    );
  }

  _buildTab() {
    return Container(
      height: 43.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: controller.tab,
              isScrollable: true,
              indicator: MyUnderlineTabIndicator(
                borderSide: const BorderSide(
                  width: 2,
                  color: AppColor.color111111,
                ),
                lineWidth: 24.w,
              ),
              labelColor: AppColor.color111111,
              unselectedLabelColor: AppColor.colorABABAB,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(text: LocaleKeys.community30.tr),//'点赞'),
                Tab(text: LocaleKeys.community31.tr),//'收藏'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
