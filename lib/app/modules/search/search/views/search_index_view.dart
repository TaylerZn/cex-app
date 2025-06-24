import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/search/search/views/search_result_main_view.dart';
import 'package:nt_app_flutter/app/modules/search/search/widget/search_empty.dart';
import 'package:nt_app_flutter/app/modules/search/search/widget/search_top.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import '../controllers/search_index_controller.dart';

class SearchIndexView extends GetView<SearchIndexController> {
  const SearchIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        child: Scaffold(
      appBar: AppBar(
        leadingWidth: ScreenUtil().screenWidth,
        leading: getSearchTopView(controller),
      ),
      body: Column(children: [
        Expanded(
          child: Column(
            children: [
              Obx(() => Visibility(
                  visible: controller.isSearchOntap.value,
                  child: const Expanded(
                    child: SearchResultMainView(),
                  ))),
              Obx(
                () => Visibility(
                  visible: controller.textEditVC.value.text.isEmpty &&
                      controller.isSearchOntap.value == false,
                  child: Expanded(
                    child: SearchEmptyView(controller: controller),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    ));
  }
}
