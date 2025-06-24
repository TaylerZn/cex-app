import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/community/flutter_polls.dart';

import '../../../../utils/utilities/community_util.dart';

class MyPollingWidget extends StatelessWidget {
  final List<PollOption> options;
  final bool disablePoll;
  final Function(PollOption)? onTap;
  final String? selectedVote;
  final bool allowVote; //是否已结束
  const MyPollingWidget(
      {super.key,
      required this.options,
      this.allowVote = false,
      this.disablePoll = true,
      this.onTap,
      this.selectedVote});

  @override
  Widget build(BuildContext context) {
    if (options.length < 2) {
      return SizedBox();
    }
    return FlutterPolls(
        hasVoted: ObjectUtil.isNotEmpty(selectedVote),
        votedCheckmark:
            allowVote ? MyImage('community/check_icon'.svgAssets()) : null,
        pollEnded: ObjectUtil.isNotEmpty(selectedVote),
        userToVote: selectedVote,
        userVotedOptionId: selectedVote,
        votedProgressColor: AppColor.colorCCCCCC,
        pollOptionsBorder: Border.all(color: Colors.transparent),
        leadingVotedProgessColor: AppColor.colorFFD429,
        pollOptionsFillColor: AppColor.colorF5F5F5,
        votedBackgroundColor: AppColor.colorF5F5F5,
        votesTextStyle: AppTextStyle.f_15_600,
        pollId: '0',
        votedPercentageTextStyle: AppTextStyle.f_15_600,
        votedAnimationDuration:
            ObjectUtil.isNotEmpty(selectedVote) || !allowVote ? 0 : 200,
        disablePoll: !allowVote,
        pollOptionsHeight: 48.h,
        onVoted: (PollOption pollOption, int newTotalVotes) async {
          MyCommunityUtil.socialMenu = Get.currentRoute;
          if (!UserGetx.to.goIsLogin()) {
            return false;
          }
          onTap?.call(pollOption);
          return true;
        },
        pollTitle: SizedBox(),
        pollOptions: options);
  }
}
