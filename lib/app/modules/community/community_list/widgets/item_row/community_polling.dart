import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/greed_voting.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/views/my_polling_widget.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../widgets/components/community/flutter_polls.dart';

class CommunityPolling extends StatefulWidget {
  final TopicdetailModel model;
  final Function? callback;

  const CommunityPolling({super.key, required this.model, this.callback});

  @override
  State<CommunityPolling> createState() => _CommunityPollingState();
}

class _CommunityPollingState extends State<CommunityPolling> {
  String? selectedVote;
  late bool allowVote;

  @override
  void initState() {
    super.initState();
    selectedVote = widget.model.lastVoteOption;
    if (ObjectUtil.isEmpty(widget.model.lastVoteOption)) {
      loadVote();
    }

    allowVote = widget.model.voteStatus ??
        true; // (widget.model.voteStatus ?? true) || int.parse(widget.model.voteRemainTime ?? '0') != 0;
  }

  Future<void> loadVote() async {
    try {
      dynamic voteOption =
          await CommunityApi.instance().isVotedTopic('${widget.model.topicNo}');
      if (ObjectUtil.isNotEmpty(voteOption)) {
        selectedVote = voteOption['votingOption'];
        if (mounted) {
          setState(() {});
        }
      }
    } on dio.DioException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (ObjectUtil.isEmpty(widget.model.votingOptions)) {
      return SizedBox();
    }
    int total = 0;
    widget.model.votingOptions?.forEach((element) {
      int count = element?.votingNum ?? 0;
      total = total + count;
    });

    return SizedBox(
        width: ScreenUtil().screenWidth - 32.w,
        child: KeepAliveWrapper(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.verticalSpaceFromWidth,
            MyPollingWidget(
              allowVote: allowVote,
              selectedVote: selectedVote,
              disablePoll: !allowVote,
              onTap: (option) async {
                VoteRecord? record = widget.model.votingOptions
                    ?.firstWhereOrNull(
                        (element) => '${element?.votingOption}' == option.id);
                VoteRecord? votedRecord = widget.model.votingOptions
                    ?.firstWhereOrNull(
                        (element) => element?.votingPercentage != 0);
                try {
                  widget.model.voteStatus = !(widget.model.voteStatus ?? false);
                  setState(() {
                    if (votedRecord == null) {
                      record?.votingPercentage = 100;
                    }
                    selectedVote = record?.votingOption;
                  });
                  if (await CommunityApi.instance()
                          .topicVote('${record?.topicVoteId}') ==
                      null) {
                    widget.callback?.call();
                  }
                } on dio.DioException catch (e) {
                  UIUtil.showError('${e.message}');
                }
              },
              options: widget.model.votingOptions
                      ?.map((e) => PollOption(
                          id: '${e?.votingOption}',
                          title: Text(e?.votingOption ?? '-',
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.f_15_600),
                          votes: e?.votingPercentage ?? 0))
                      .toList() ??
                  [],
            ),

            // allowVote == true ? Center(child: Text('${LocaleKeys.community98.tr}${widget.model.voteRemainTime}',style: AppTextStyle.small_400.color999999)) : Text('${widget.model.votingNum ?? 0}${LocaleKeys.community99.tr}',style: AppTextStyle.small_400.color999999)
            allowVote == true
                ? Center(
                    child: Text(widget.model.voteRemainTime ?? '',
                        style: AppTextStyle.f_12_400.color999999))
                : Text('${total}${LocaleKeys.community99.tr}',
                    style: AppTextStyle.f_12_400.color999999)
          ],
        )));
    ;
  }

  @override
  void didUpdateWidget(covariant CommunityPolling oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if ((ObjectUtil.isNotEmpty(widget.model.lastVoteOption) &&
        selectedVote != widget.model.lastVoteOption)) {
      setState(() {
        selectedVote = widget.model.lastVoteOption;
      });
    }
  }
}
