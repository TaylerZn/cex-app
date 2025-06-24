import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/search.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_search/controllers/markets_search_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_search/model/markets_search_model.dart';
import 'package:nt_app_flutter/app/modules/search/search_history/controllers/search_index_controller.dart';
import 'package:nt_app_flutter/app/modules/search/search_history/views/search_index_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

//

class MarketsSearchList extends StatelessWidget {
  MarketsSearchList({super.key, required this.array});
  final List<MarketSearchResModel> array;
  final leftStyle = TextStyle(
    fontSize: 13.sp,
    color: AppColor.color666666,
    fontWeight: FontWeight.w400,
  );
  final rightStyle = TextStyle(
    fontSize: 13.sp,
    color: AppColor.color111111,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
            padding: EdgeInsets.only(top: 20.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return getCell(array[index]);
                },
                childCount: array.length,
              ),
            ))
      ],
    );
  }

  Widget getCell(MarketSearchResModel model) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: EdgeInsets.only(bottom: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: model.symbol,
                    style: AppTextStyle.f_16_500.color111111),
                // TextSpan(
                //   text: '/TRY',
                //   style: TextStyle(
                //     color: AppColor.color999999,
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(model.price, style: AppTextStyle.f_16_500.color111111),
              SizedBox(height: 6.h),
              Text(model.rate, style: AppTextStyle.f_12_500.color999999),
            ],
          ),
        ],
      ),
    );
  }
}

class MarketsSearchEmptyView extends StatelessWidget {
  MarketsSearchEmptyView({super.key, required this.controller});
  final MarketsSearchController controller;
  final leftStyle = TextStyle(
    fontSize: 13.sp,
    color: AppColor.color666666,
    fontWeight: FontWeight.w400,
  );
  final rightStyle = TextStyle(
    fontSize: 13.sp,
    color: AppColor.color111111,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Column(
          children: [
            GetBuilder<SearchHistoryController>(
              init: SearchHistoryController(
                type: SearchHistoryEnumn.market,
                onHistoryItemClicked: (String val) {
                  debugPrint(val);
                },
              ),
              builder: (controller) => SearchHistoryView(),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        )),
        Obx(() => SliverVisibility(
            visible: controller.recommendList.isNotEmpty,
            sliver: SliverPinnedHeader(
                child: Container(
              color: AppColor.colorWhite,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text('热门搜索', style: AppTextStyle.f_16_500.color111111),
            )))),
        Obx(() => SliverPadding(
            padding: EdgeInsets.only(top: 23.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return getCell(index, controller.recommendList[index]);
                },
                childCount: controller.recommendList.length,
              ),
            )))
      ],
    );
  }

  Widget getCell(int i, MarketInfoModel model) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '${i + 1} ',
                    style: i < 3
                        ? AppTextStyle.f_16_500.color111111
                        : AppTextStyle.f_16_500.color999999),
                TextSpan(
                    text: model.showName,
                    style: AppTextStyle.f_16_500.color111111),
                // TextSpan(
                //   text: '/USDT',
                //   style: TextStyle(
                //     color: AppColor.color999999,
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(model.priceStr, style: AppTextStyle.f_16_500.color111111),
              SizedBox(height: 6.h),
              Text(model.roseStr,
                  style: AppTextStyle.f_12_500.copyWith(
                    color: model.backColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
