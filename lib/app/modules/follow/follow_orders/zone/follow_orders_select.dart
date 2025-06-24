import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take/model/my_take_list.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowOrderSelect extends StatefulWidget {
  const FollowOrderSelect({super.key, this.symbolList});
  final List? symbolList;

  @override
  State<FollowOrderSelect> createState() => _FollowOrderSelectState();
}

class _FollowOrderSelectState extends State<FollowOrderSelect> {
  List<MyTakefollowUser>? list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const MyPageBackWidget(),
          title: Text(LocaleKeys.follow24.tr)),
      body: widget.symbolList == null
          ? const SizedBox()
          : widget.symbolList!.isEmpty
              ? Center(
                  child: noDataWidget(context, text: LocaleKeys.public8.tr))
              : WaterfallFlow.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: widget.symbolList!.length,
                  gridDelegate:
                      SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 10.w,
                  ),
                  itemBuilder: (context, index) {
                    var symbol = (widget.symbolList![index] as String)
                                .split('-')
                                .length >
                            1
                        ? (widget.symbolList![index] as String).split('-')[1]
                        : '';
                    return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: ShapeDecoration(
                          color: AppColor.colorF5F5F5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Row(
                          children: <Widget>[
                            MarketIcon(iconName: symbol, width: 24.w),
                            Text(
                              symbol,
                              style: AppTextStyle.f_14_600.color111111,
                            ).marginOnly(left: 8.w)
                          ],
                        ));
                  },
                ),
    );
  }
}
