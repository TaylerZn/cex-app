import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/comment.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/community_comment_widget/index.dart';
import 'package:nt_app_flutter/app/modules/community/widget/more_dialog.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'controller.dart';

class CommentListView extends StatefulWidget {
  final String tag;

  final TopicdetailModel? model;

  const CommentListView(this.tag, {required this.model, super.key});

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicCommentListViewController>(
        tag: widget.tag,
        init: TopicCommentListViewController(
            widget.tag, widget.model?.topicNo ?? ''),
        builder: (controller) {
          return controller.pageObx((data) {
            return SmartRefresher(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.refreshController,
              onRefresh: () => controller.refreshData(true),
              onLoading: controller.loadMoreData,
              enablePullUp: true,
              enablePullDown: false,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  CommunityCommentItem? item = data![index];
                  return KeepAliveWrapper(
                      child: CommunityCommentWidget(
                    item: item,
                    firstLevelIndex: index,
                    subCommentKeys: controller.subCommentKeys,
                    onLongPress:
                        (int? secondIndex, CommunityCommentReplyEnum level) {
                      controller.removePlDialog(
                          context, level, index, secondIndex);
                    },
                    onTap: (int? secondIndex, CommunityCommentReplyEnum level) {
                      if (Get.find<UserGetx>().goIsLogin()) {
                        controller.showPLDialog(
                            context, level, index, secondIndex);
                      }
                    },
                    model: widget.model,
                    onRefresh: (action, type) {
                      if (action == MoreActionType.delete) {
                        if (type == CommunityCommentReplyEnum.firstLevel) {
                          controller.dataList.remove(item);
                          controller.update();
                          controller.calcCommentCount();
                        } else {
                          controller.calcCommentCount();
                        }
                      } else {
                        controller.refreshData(false);
                      }
                    },
                  ));
                },
                itemCount: data?.length,
              ),
            );
          });
        });
  }

  @override
  void didUpdateWidget(covariant CommentListView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tag != widget.tag) {
      setState(() {});
    }
  }
}
