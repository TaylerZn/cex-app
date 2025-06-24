import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/widget/more_dialog.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/community/post_more_bottom_dialog.dart';

import '../../../../../../generated/locales.g.dart';

Future<void> topicPerformAction(
    MoreActionType action, TopicdetailModel? item, Function? callback) async {
  switch (action) {
    case MoreActionType.favourite:
      {
        if (await topiccollectnewOrCancel(item?.topicNo)) {
          item?.collectFlag = !(item.collectFlag ?? false);
          UIUtil.showSuccess(item?.collectFlag
              ? LocaleKeys.community94.tr
              : LocaleKeys.community95.tr); //? '已收藏' : '已取消收藏');
        }
      }
    case MoreActionType.delete:
      {
        UIUtil.showConfirm(LocaleKeys.community96.tr, //'确认删除此帖子？',
            titleStyle: AppTextStyle.f_14_500.color333333,
            confirmHandler: () async {
          Get.back();
          if (await topicDelete('${item?.id}')) {
            UIUtil.showSuccess(LocaleKeys.community97.tr); //'删除成功');
          }
          Bus.getInstance().emit(EventType.postSend, null);
          callback?.call();
        });
      }
    case MoreActionType.share:
      {
        postShareBottomDialog(
            uid: item?.memberId,
            userName: '${item?.memberName ?? '--'}',
            postData: item,
            blockSuccessFun: () {
              Get.back();
            });
      }
    case MoreActionType.pinTop:
      {
        if (await pinTopic(item?.id)) {
          item?.topFlag = !(item.topFlag ?? false);
          UIUtil.showSuccess(item?.topFlag
                  ? LocaleKeys.community89.tr //'已置顶'
                  : LocaleKeys.community90.tr //'已取消置顶'
              );
          callback?.call();
        }
      }
    case MoreActionType.block:
      {
        blockMember(item?.memberName ?? '', item?.memberId,
            blockSuccessFun: () {
          Bus.getInstance().emit(EventType.postSend, null);
        });
      }
    default:
  }
}
