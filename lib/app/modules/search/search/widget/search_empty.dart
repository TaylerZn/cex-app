import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/search.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_sliver.dart';
import 'package:nt_app_flutter/app/modules/search/search/controllers/search_index_controller.dart';
import 'package:nt_app_flutter/app/modules/search/search_history/controllers/search_index_controller.dart';
import 'package:nt_app_flutter/app/modules/search/search_history/views/search_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchEmptyView extends StatelessWidget {
  const SearchEmptyView({super.key, required this.controller});
  final SearchIndexController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Column(
          children: [
            GetBuilder<SearchHistoryController>(
              init: SearchHistoryController(
                type: SearchHistoryEnumn.main,
                onHistoryItemClicked: (String val) {
                  controller.textEditVC.value.text = val;
                  controller.onSubmit(val);
                },
              ),
              builder: (controller) => SearchHistoryView(),
            ),
          ],
        )),
        Obx(() => SliverVisibility(
            visible: controller.recommendList.isNotEmpty,
            sliver: SliverPinnedHeader(
                child: Container(
              color: AppColor.colorWhite,
              padding: EdgeInsets.fromLTRB(16.w, 20.w, 16.w, 0),
              child: Text(LocaleKeys.public42.tr,
                  style: AppTextStyle.f_16_600.color111111),
            )))),
        Obx(() => SliverPadding(
            padding: EdgeInsets.only(top: 10.h),
            sliver:
                ContractSliver(contractList: controller.recommendList.value)))
      ],
    );
  }
}
