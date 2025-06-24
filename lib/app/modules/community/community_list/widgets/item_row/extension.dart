import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/post_quote_widget.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

import '../../../../../global/dataStore/commodity_data_store_controller.dart';
import 'bottom_action.dart';
import 'community_polling.dart';
import 'index.dart';

extension CommunityItemRowSub on CommunityItemRow {
  Widget buildExtraWidget(TopicdetailModel model, {Function? callback}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.verticalSpaceFromWidth,
        Visibility(
            visible: ObjectUtil.isNotEmpty(model.quoteTopicId),
            child: Container(
                margin: EdgeInsets.only(bottom: 10.w),
                child: PostQuoteWidget(quoteId: model.quoteTopicId))),
        BottomAction(item: model),
        16.verticalSpaceFromWidth,
      ],
    );
  }

  ContractInfo? getContract(TopicdetailModel model, int index) {
    dynamic obj = model.symbolList?[index];

    String t = '$obj';
    ContractInfo? info =
        CommodityDataStoreController.to.getContractInfoBySymbol(t);
    return info;
  }
}
