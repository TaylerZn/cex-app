import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/controllers/community_list_controller.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/views/my_polling_widget.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/favorite_community_row.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/interested_people_widget.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/index.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../widget/more_dialog.dart';
import 'community_market_combined_widget.dart';

class PostListRow extends StatelessWidget {
  final Function(MoreActionType, TopicdetailModel model) onRefresh;
  final TopicdetailModelWrapper item;
  final bool isHome;
  final CommunityListController? controller;

  const PostListRow(
      {super.key,
      required this.onRefresh,
      this.isHome = false,
      required this.item,
      this.controller});

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      case TopicdetailModelType.none:
        return const SizedBox();
      case TopicdetailModelType.normal:
        return postListWidget(context, item.model);
      case TopicdetailModelType.graph:
        return const CommunityMarketCombinedWidget();

      case TopicdetailModelType.recommended:
        return FavoriteCommunityRow(data: controller?.hotTopicModel);

      case TopicdetailModelType.voting:
        return const MyPollingWidget(
          options: [],
        );
    }
  }

  Widget postListWidget(context, TopicdetailModel item,
      {key, isMe = false, isFail = false, tap, isSC = false, isLike = false}) {
    CommodityDataStoreController.to.getContractInfoByContractId(1);

    return item.interestPeopleList != null
        ? isHome
            ? InterestedPeopleWidget(
                list: item.interestPeopleList!,
              )
            : const SizedBox()
        : item.cmsDatatList != null
            ? item.cmsDatatList!.isNotEmpty
                ? Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.h),
                    decoration: const BoxDecoration(
                        color: AppColor.colorWhite,
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: AppColor.colorEEEEEE))),
                    child: Column(children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => Get.toNamed(Routes.FOLLOW_TAKER_LIST,
                            arguments: {'index': 1}),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              LocaleKeys.community41.tr,
                              style: AppTextStyle.f_16_600,
                            ),
                          ],
                        ),
                      ),
                      16.verticalSpace,
                      MyActivityWidget(
                        height: 130.h,
                        list: item.cmsDatatList!,
                      ),
                    ]))
                : const SizedBox()
            : CommunityItemRow(item: item, onRefresh: onRefresh);
  }
}
