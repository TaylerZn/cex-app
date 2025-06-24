import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/components/linear_percent_indicator.dart';

class FlutterPolls extends StatefulWidget {
  const FlutterPolls({
    super.key,
    required this.pollId,
    this.hasVoted = false,
    this.userVotedOptionId,
    required this.onVoted,
    this.loadingWidget,
    required this.pollTitle,
    this.heightBetweenTitleAndOptions = 10,
    required this.pollOptions,
    this.heightBetweenOptions,
    this.votesText = 'Votes',
    this.votesTextStyle,
    this.metaWidget,
    this.createdBy,
    this.userToVote,
    this.pollStartDate,
    this.disablePoll = false,
    this.pollEnded = false,
    this.pollOptionsHeight = 36,
    this.pollOptionsWidth,
    this.pollOptionsBorderRadius,
    this.pollOptionsFillColor,
    this.pollOptionsSplashColor = Colors.grey,
    this.pollOptionsBorder,
    this.votedPollOptionsBorder,
    this.votedPollOptionsRadius,
    this.votedBackgroundColor = const Color(0xffEEF0EB),
    this.votedProgressColor = const Color(0xff84D2F6),
    this.leadingVotedProgessColor = const Color(0xff0496FF),
    this.voteInProgressColor = const Color(0xffEEF0EB),
    this.votedCheckmark,
    this.votedPercentageTextStyle,
    this.votedAnimationDuration = 1000,
  });

  /// The id of the poll.
  /// This id is used to identify the poll.
  /// It is also used to check if a user has already voted in this poll.
  final String? pollId;

  /// Checks if a user has already voted in this poll.
  /// If this is set to true, the user can't vote in this poll.
  /// Default value is false.
  /// [userVotedOptionId] must also be provided if this is set to true.
  final bool hasVoted;

  /// Checks if the [onVoted] execution is completed or not
  /// it is true, if the [onVoted] exection is ongoing and
  /// false, if completed

  final bool disablePoll;

  /// If a user has already voted in this poll.
  /// It is ignored if [hasVoted] is set to false or not set at all.
  final String? userVotedOptionId;

  /// An asynchronous callback for HTTP call feature
  /// Called when the user votes for an option.
  /// The index of the option that the user voted for is passed as an argument.
  /// If the user has already voted, this callback is not called.
  /// If the user has not voted, this callback is called.
  /// If the callback returns true, the tapped [PollOption] is considered as voted.
  /// Else Nothing happens,
  final Future<bool> Function(PollOption pollOption, int newTotalVotes) onVoted;

  /// The title of the poll. Can be any widget with a bounded size.
  final Widget pollTitle;

  /// Data format for the poll options.
  /// Must be a list of [PollOptionData] objects.
  /// The list must have at least two elements.
  /// The first element is the option that is selected by default.
  /// The second element is the option that is selected by default.
  /// The rest of the elements are the options that are available.
  /// The list can have any number of elements.
  ///
  /// Poll options are displayed in the order they are in the list.
  /// example:
  ///
  /// pollOptions = [
  ///
  ///  PollOption(id: 1, title: Text('Option 1'), votes: 2),
  ///
  ///  PollOption(id: 2, title: Text('Option 2'), votes: 5),
  ///
  ///  PollOption(id: 3, title: Text('Option 3'), votes: 9),
  ///
  ///  PollOption(id: 4, title: Text('Option 4'), votes: 2),
  ///
  /// ]
  ///
  /// The [id] of each poll option is used to identify the option when the user votes.
  /// The [title] of each poll option is displayed to the user.
  /// [title] can be any widget with a bounded size.
  /// The [votes] of each poll option is the number of votes that the option has received.
  final List<PollOption> pollOptions;

  /// The height between the title and the options.
  /// The default value is 10.
  final double? heightBetweenTitleAndOptions;

  /// The height between the options.
  /// The default value is 0.
  final double? heightBetweenOptions;

  /// Votes text. Can be "Votes", "Votos", "Ibo" or whatever language.
  /// If not specified, "Votes" is used.
  final String? votesText;

  /// [votesTextStyle] is the text style of the votes text.
  /// If not specified, the default text style is used.
  /// Styles for [totalVotes] and [votesTextStyle].
  final TextStyle? votesTextStyle;

  /// [metaWidget] is displayed at the bottom of the poll.
  /// It can be any widget with an unbounded size.
  /// If not specified, no meta widget is displayed.
  /// example:
  /// metaWidget = Text('Created by: $createdBy')
  final Widget? metaWidget;

  /// Who started the poll.
  final String? createdBy;

  /// Current user about to vote.
  final String? userToVote;

  /// The date the poll was created.
  final DateTime? pollStartDate;

  /// If poll is closed.
  final bool pollEnded;

  /// Height of a [PollOption].
  /// The height is the same for all options.
  /// Defaults to 36.
  final double? pollOptionsHeight;

  /// Width of a [PollOption].
  /// The width is the same for all options.
  /// If not specified, the width is set to the width of the poll.
  /// If the poll is not wide enough, the width is set to the width of the poll.
  /// If the poll is too wide, the width is set to the width of the poll.
  final double? pollOptionsWidth;

  /// Border radius of a [PollOption].
  /// The border radius is the same for all options.
  /// Defaults to 0.
  final BorderRadius? pollOptionsBorderRadius;

  /// Border of a [PollOption].
  /// The border is the same for all options.
  /// Defaults to null.
  /// If null, the border is not drawn.
  final BoxBorder? pollOptionsBorder;

  /// Border of a [PollOption] when the user has voted.
  /// The border is the same for all options.
  /// Defaults to null.
  /// If null, the border is not drawn.
  final BoxBorder? votedPollOptionsBorder;

  /// Color of a [PollOption].
  /// The color is the same for all options.
  /// Defaults to [Colors.blue].
  final Color? pollOptionsFillColor;

  /// Splashes a [PollOption] when the user taps it.
  /// Defaults to [Colors.grey].
  final Color? pollOptionsSplashColor;

  /// Radius of the border of a [PollOption] when the user has voted.
  /// Defaults to Radius.circular(8).
  final Radius? votedPollOptionsRadius;

  /// Color of the background of a [PollOption] when the user has voted.
  /// Defaults to [const Color(0xffEEF0EB)].
  final Color? votedBackgroundColor;

  /// Color of the progress bar of a [PollOption] when the user has voted.
  /// Defaults to [const Color(0xff84D2F6)].
  final Color? votedProgressColor;

  /// Color of the leading progress bar of a [PollOption] when the user has voted.
  /// Defaults to [const Color(0xff0496FF)].
  final Color? leadingVotedProgessColor;

  /// Color of the background of a [PollOption] when the user clicks to vote and its still in progress.
  /// Defaults to [const Color(0xffEEF0EB)].
  final Color? voteInProgressColor;

  /// Widget for the checkmark of a [PollOption] when the user has voted.
  /// Defaults to [Icons.check_circle_outline_rounded].
  final Widget? votedCheckmark;

  /// TextStyle of the percentage of a [PollOption] when the user has voted.
  final TextStyle? votedPercentageTextStyle;

  /// Animation duration of the progress bar of the [PollOption]'s when the user has voted.
  /// Defaults to 1000 milliseconds.
  /// If the animation duration is too short, the progress bar will not animate.
  /// If you don't want the progress bar to animate, set this to 0.
  final int votedAnimationDuration;

  /// Loading animation widget for [PollOption] when [onVoted] callback is invoked
  /// Defaults to [CircularProgressIndicator]
  /// Visible until the [onVoted] execution is completed,
  final Widget? loadingWidget;

  @override
  State<FlutterPolls> createState() => _FlutterPollsState();
}

class _FlutterPollsState extends State<FlutterPolls> {
  bool _isloading = false;
  final RxBool hasPollEnded = false.obs; // ValueNotifier(false);
  final RxBool userHasVoted = false.obs; // ValueNotifier(false);
  final RxBool isLoading = false.obs;
  late Rx<PollOption?> votedOption =
      PollOption(title: SizedBox(), votes: 0).obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hasPollEnded.value = widget.pollEnded;
    userHasVoted.value = widget.hasVoted;
    PollOption? option = widget.pollOptions
        .firstWhereOrNull((element) => element.id == widget.userVotedOptionId);
    if (widget.hasVoted && ObjectUtil.isNotEmpty(option)) {
      votedOption.value = option;
    }
  }

  @override
  Widget build(BuildContext context) {
    // hasPollEnded.value = widget.pollEnded;
    // userHasVoted.value = widget.hasVoted;

    // PollOption? option = widget.pollOptions.firstWhereOrNull((element) => element.id == widget.userVotedOptionId);
    // if (widget.hasVoted && ObjectUtil.isNotEmpty(option)) {
    //   votedOption.value = option;
    // }

    return Column(
      key: ValueKey(widget.pollId),
      children: [
        widget.pollTitle,
        SizedBox(height: widget.heightBetweenTitleAndOptions),
        if (widget.pollOptions.length < 2)
          throw ('>>>Flutter Polls: Poll must have at least 2 options.<<<')
        else
          ...widget.pollOptions.map(
            (pollOption) {
              if (widget.hasVoted && widget.userVotedOptionId == null) {
                throw ('>>>Flutter Polls: User has voted but [userVotedOptionId] is null.<<<');
              } else {
                return Obx(() => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: userHasVoted.value || hasPollEnded.value
                          ? Container(
                              key: UniqueKey(),
                              margin: EdgeInsets.only(
                                bottom: widget.heightBetweenOptions ?? 8,
                              ),
                              decoration: widget.votedPollOptionsBorder != null
                                  ? BoxDecoration(
                                      border: widget.votedPollOptionsBorder,
                                      borderRadius: BorderRadius.all(
                                        widget.votedPollOptionsRadius ??
                                            const Radius.circular(8),
                                      ),
                                    )
                                  : null,
                              child: LinearPercentIndicator(
                                width: widget.pollOptionsWidth,
                                lineHeight: widget.pollOptionsHeight!,
                                barRadius: widget.votedPollOptionsRadius ??
                                    const Radius.circular(8),
                                padding: EdgeInsets.zero,
                                percent: pollOption.votes / 100.0,
                                animation: true,
                                animationDuration:
                                    widget.votedAnimationDuration,
                                backgroundColor: widget.votedBackgroundColor,
                                progressColor:
                                    votedOption.value?.id == pollOption.id
                                        ? widget.leadingVotedProgessColor
                                        : widget.votedProgressColor,
                                center: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(child: pollOption.title),
                                            const SizedBox(width: 10),
                                            if (votedOption.value != null &&
                                                votedOption.value?.id ==
                                                    pollOption.id)
                                              widget.votedCheckmark ??
                                                  const Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    color: Colors.black,
                                                    size: 16,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${pollOption.votes}%',
                                        style: widget.votedPercentageTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              key: UniqueKey(),
                              margin: EdgeInsets.only(
                                bottom: widget.heightBetweenOptions ?? 8,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  if (widget.disablePoll) {
                                    return;
                                  }
                                  bool success =
                                      await widget.onVoted(pollOption, 0
                                          //  totalVotes.value,
                                          );
                                  if (!success) {
                                    return;
                                  }
                                  // Disables clicking while loading
                                  if (isLoading.value) return;

                                  votedOption.value = pollOption;
                                  hasPollEnded.value = true;
                                  isLoading.value = true;

                                  if (success) {
                                    isLoading.value = false;
                                    userHasVoted.value = true;
                                  }
                                },
                                splashColor: widget.pollOptionsSplashColor,
                                borderRadius: widget.pollOptionsBorderRadius ??
                                    BorderRadius.circular(
                                      8,
                                    ),
                                child: Container(
                                  height: widget.pollOptionsHeight,
                                  width: widget.pollOptionsWidth,
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color:
                                        votedOption.value?.id == pollOption.id
                                            ? widget.voteInProgressColor
                                            : widget.pollOptionsFillColor,
                                    border: widget.pollOptionsBorder ??
                                        Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                    borderRadius:
                                        widget.pollOptionsBorderRadius ??
                                            BorderRadius.circular(
                                              8,
                                            ),
                                  ),
                                  child: Center(
                                    child: isLoading.value &&
                                            pollOption.id ==
                                                votedOption.value!.id
                                        ? widget.loadingWidget ??
                                            const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                        : pollOption.title,
                                  ),
                                ),
                              ),
                            ),
                    ));
              }
            },
          ),
        const SizedBox(height: 4),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant FlutterPolls oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pollEnded != widget.pollEnded) {
      setState(() {
        hasPollEnded.value = widget.pollEnded;
        userHasVoted.value = widget.hasVoted;
        PollOption? option = widget.pollOptions.firstWhereOrNull(
            (element) => element.id == widget.userVotedOptionId);
        if (widget.hasVoted && ObjectUtil.isNotEmpty(option)) {
          votedOption.value = option;
        }
      });
    }
  }
}

class PollOption {
  PollOption({
    this.id,
    required this.title,
    required this.votes,
  });

  final String? id;
  final Widget title;
  int votes;
}
