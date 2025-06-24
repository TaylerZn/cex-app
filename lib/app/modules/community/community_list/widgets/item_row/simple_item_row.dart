import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/community.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/community/post_index/widgets/coin_market_widget.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/woker_util.dart';
import 'package:nt_app_flutter/app/widgets/components/community/community_info_public.dart';

import 'bottom_action.dart';

class SimpleItemRow extends StatefulWidget {
  final TopicdetailModel item;

  const SimpleItemRow({super.key, required this.item});

  @override
  State<SimpleItemRow> createState() => _SimpleItemRowState();
}

class _SimpleItemRowState extends State<SimpleItemRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyCommunityUtil.jumpToTopicDetail(widget.item);
      },
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  16.verticalSpaceFromWidth,
                  buildInfo(widget.item),
                  upDownWidget(widget.item),
                  12.verticalSpaceFromWidth,
                  SizedBox(
                      height: 36.w, child: BottomAction(item: widget.item)),
                ],
              )),
        ],
      ),
    );
  }

  Widget upDownWidget(model) {
    return Visibility(
        visible: model.symbolList != null,
        child: model.symbolList != null
            ? Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 12.w),
                child: Wrap(
                    children: worker<Widget>(model.symbolList, (index, item) {
                  ContractInfo? info = getContract(model, index);
                  if (ObjectUtil.isNotEmpty(info)) {
                    return Container(
                      margin: EdgeInsets.only(
                          right: info != model.symbolList?.last ? 6.w : 0),
                      child: CoinMarketWidget(
                        contractInfo: info!,
                      ),
                    );
                  }
                  return const SizedBox();
                })),
              )
            : const SizedBox());
  }

  Widget buildInfo(TopicdetailModel item) {
    return Visibility(
      visible: (item.topicTitle ?? '').isNotEmpty ||
          (item.topicContent ?? '').isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: (item.topicTitle ?? '').isNotEmpty,
              child: Text(
                item.topicTitle ?? '',
                style: AppTextStyle.f_16_600.colorTextPrimary,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.verticalSpaceFromWidth,
              Container(
                alignment: Alignment.centerLeft,
                child: MyCommunityUtil.specialStringtToWidget(
                  item.topicContent,
                  SpecialContentEnum.postContent,
                  textStyle: AppTextStyle.f_15_400,
                  lines: 2,
                  specialTextStyle: AppTextStyle.f_15_400.tradingYel,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
