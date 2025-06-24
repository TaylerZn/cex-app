import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/file_upload.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_sliver.dart';
import 'package:nt_app_flutter/app/modules/search/search/controllers/search_index_controller.dart';
import 'package:nt_app_flutter/app/modules/search/search/model/search_enum.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class SearchGroupList extends StatelessWidget {
  const SearchGroupList(
      {super.key,
      required this.title,
      required this.controller,
      this.spotsList,
      this.contractList,
      this.des = '',
      this.traderList,
      this.topicsList,
      this.searchText});
  final String title;
  final SearchIndexController controller;
  final String des;
  final List<MarketInfoModel>? spotsList;
  final List<ContractInfo>? contractList;
  final List<TopicdetailModel>? topicsList;
  final List<FollowKolInfo>? traderList;
  final String? searchText;

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];
    if (contractList != null && contractList!.isNotEmpty) {
      var sliversList = [
        SliverToBoxAdapter(
            child: SearchGroupTitle(
                title: title,
                onTap: () {
                  int index = controller.tabs.indexOf(SearchResultsType.contract);
                  controller.tabController.animateTo(index);
                })),
        SearchGroupContractList(
          list: contractList!,
          saarchText: searchText,
        )
      ];
      slivers.addAll(sliversList);
    }
    if (spotsList != null && spotsList!.isNotEmpty) {
      var sliversList = [
        SliverToBoxAdapter(
            child: SearchGroupTitle(
                title: title,
                onTap: () {
                  int index = controller.tabs.indexOf(SearchResultsType.spot);
                  controller.tabController.animateTo(index);
                })),
        SearchGroupMarketList(
          list: spotsList!,
          saarchText: searchText,
        )
      ];
      slivers.addAll(sliversList);
    }

    if (topicsList != null && topicsList!.isNotEmpty) {
      var sliversList = [
        SliverToBoxAdapter(
            child: SearchGroupTitle(
                title: title,
                onTap: () {
                  int index = controller.tabs.indexOf(SearchResultsType.community);
                  controller.tabController.animateTo(index);
                })),
        SearchGroupCommunityDesList(
          list: topicsList!,
        )
      ];
      slivers.addAll(sliversList);
    }

    if (traderList != null && traderList!.isNotEmpty) {
      var sliversList = [
        SliverToBoxAdapter(
            child: SearchGroupTitle(
                title: title,
                onTap: () {
                  int index = controller.tabs.indexOf(SearchResultsType.trader);
                  controller.tabController.animateTo(index);
                })),
        SearchGroupTraderDesList(
          list: traderList!,
        )
      ];
      slivers.addAll(sliversList);
    }
    return SliverMainAxisGroup(slivers: slivers);
  }
}

class SearchGroupTitle extends StatelessWidget {
  const SearchGroupTitle({super.key, this.title = '合约', this.onTap});
  final String title;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(color: AppColor.colorWhite),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: AppTextStyle.f_16_600.color111111),
              MyImage(
                'default/go'.svgAssets(),
                width: 14.w,
                color: AppColor.color111111,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchGroupCommunityDesList extends StatelessWidget {
  const SearchGroupCommunityDesList({
    super.key,
    this.type = SearchResultsType.contract,
    required this.list,
  });
  final SearchResultsType type;
  final List<TopicdetailModel> list;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var item = list[index];
          return InkWell(
              onTap: () {
                if (item.type == CommunityFileTypeEnum.VIDEO) {
                  Get.toNamed(Routes.COMMUNITY_VIDEO_INFO, arguments: {'topicNo': item.topicNo, 'data': item});
                } else {
                  Get.toNamed(Routes.COMMUNITY_INFO, arguments: {'topicNo': item.topicNo, 'data': item});
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.colorEEEEEE,
                      width: 1.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.w),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${item.topicTitle}',
                      softWrap: true,
                      style: TextStyle(
                        color: AppColor.color111111,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ).marginOnly(bottom: 10.h),
                    Row(
                      children: <Widget>[
                        UserAvatar(
                          '${item.memberHeadUrl ?? ''}',
                          width: 16.w,
                          height: 16.w,
                          tradeIconSize: 11.w,
                        ),

                        Text('${item.memberName ?? '--'}'.stringSplit(), style: AppTextStyle.f_14_500.color4D4D4D)
                            .marginOnly(left: 4.w, right: 10.w),
                        Text(item.createTime != null ? RelativeDateFormat.format(DateTime.parse('${item.createTime}')) : '',
                            style: AppTextStyle.f_12_400.color999999),
                        // Expanded(
                        //     child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text('${item.memberName ?? '--'}'.stringSplit(),
                        //         style: AppTextStyle.body2_500.color4D4D4D),
                        //     Text(
                        //         item.createTime != null
                        //             ? RelativeDateFormat.format(
                        //                 DateTime.parse('${item.createTime}'))
                        //             : '',
                        //         style: AppTextStyle.small_400.color999999)
                        //   ],
                        // )),
                        // ClipOval(
                        //   child: MyImage(
                        //     'https://mcd.merchain.live/app_operation_static/vendor/img/kolTradersList-head.a0525ea.png',
                        //     width: 16.w,
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ));
        },
        childCount: list.length > 3 ? 3 : list.length,
      ),
    );
  }
}

class SearchGroupTraderDesList extends StatelessWidget {
  const SearchGroupTraderDesList({
    super.key,
    this.type = SearchResultsType.contract,
    required this.list,
  });
  final SearchResultsType type;
  final List<FollowKolInfo> list;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var trader = list[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': trader.uid});
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
              padding: EdgeInsets.all(16.w),
              decoration: ShapeDecoration(
                color: AppColor.colorF4F4F4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
              ),
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: MyImage(
                      trader.icon,
                      width: 36.w,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(trader.userName, style: AppTextStyle.f_15_500.color111111.ellipsis),
                        // Row(
                        //   children: <Widget>[
                        //     MyImage(
                        //       'flow/supervisor_account'.svgAssets(),
                        //       width: 10.w,
                        //     ),
                        //     SizedBox(width: 4.w),
                        //     Text(trader.currentNumber.toString(),
                        //         style: AppTextStyle.small2_500.color333333),
                        //     Text('/${trader.maxNumber}',
                        //         style: AppTextStyle.small2_400.color999999),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(LocaleKeys.follow8.tr, style: AppTextStyle.f_11_400.colorA3A3A3),
                      Text(trader.monthProfitRateStr, style: AppTextStyle.f_14_600.copyWith(color: trader.monthProfitRateColor))
                          .marginOnly(left: 4.w, right: 20.w),
                    ],
                  ).marginOnly(right: 26.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(LocaleKeys.follow306.tr, style: AppTextStyle.f_11_400.colorA3A3A3),
                      Text(trader.compositeScoreStr,
                          style: AppTextStyle.f_14_600.copyWith(color: trader.monthProfitAmountColor)),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }
}

// class SearchGroupFunctiontypeDesList extends StatelessWidget {
//   const SearchGroupFunctiontypeDesList({
//     super.key,
//     this.type = SearchResultsType.contract,
//     required this.list,
//   });
//   final SearchResultsType type;
//   final List<MarketInfoModel> list;
//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return SearchDesCell(i: index, model: list[index]);
//         },
//         childCount: list.length,
//       ),
//     );
//   }
// }

class SearchGroupMarketList extends StatelessWidget {
  const SearchGroupMarketList({
    super.key,
    this.saarchText,
    required this.list,
  });
  final String? saarchText;
  final List<MarketInfoModel> list;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return SpotSliverCell(marketInfoModel: list[index], saarchName: saarchText);
        },
        childCount: list.length,
      ),
    );
  }
}

class SearchGroupContractList extends StatelessWidget {
  const SearchGroupContractList({
    super.key,
    this.saarchText,
    required this.list,
  });
  final String? saarchText;
  final List<ContractInfo> list;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var model = list[index];
          return model.contractType == 'E'
              ? ContractSliverCell(contractModel: model, saarchName: saarchText)
              : StandardContractSliverCell(commodityModel: model, saarchName: saarchText);
        },
        childCount: list.length,
      ),
    );
  }
}

// class SearchDesCell extends StatelessWidget {
//   const SearchDesCell({
//     super.key,
//     required this.i,
//     required this.model,
//   });
//   final int i;
//   final MarketInfoModel model;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
//       child: Row(
//         children: <Widget>[
//           MyImage(
//             'currency/usdt'.svgAssets(),
//             width: 32.w,
//           ).marginOnly(right: 8.h),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text.rich(
//                 TextSpan(
//                   children: [
//                     TextSpan(text: model.firstName, style: AppTextStyle.medium2_500.color111111),
//                     TextSpan(text: model.secondName, style: AppTextStyle.medium_500.color999999),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 2.h),
//                 child: Text(model.volStr, style: AppTextStyle.small2_400.color666666),
//               )
//             ],
//           ),
//           const Spacer(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               Text(model.priceStr, textAlign: TextAlign.right, style: AppTextStyle.medium_500.color111111),
//               Padding(
//                 padding: EdgeInsets.only(top: 6.h),
//                 child: Text(model.desPriceStr, textAlign: TextAlign.right, style: AppTextStyle.small2_400.color999999),
//               )
//             ],
//           ),
//           SizedBox(
//             width: 34.w,
//           ),
//           Container(
//             width: 76.w,
//             height: 28.h,
//             alignment: Alignment.center,
//             decoration: ShapeDecoration(
//               color: model.backColor,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//             ),
//             child: Text(model.roseStr, textAlign: TextAlign.center, style: AppTextStyle.medium_500.colorWhite),
//           )
//         ],
//       ),
//     );
//   }
// }
