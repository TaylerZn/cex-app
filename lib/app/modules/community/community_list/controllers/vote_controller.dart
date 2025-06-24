import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../models/vote_option.dart';

class VoteController extends GetxController {
  var options = <VoteOption>[].obs;
  var canVote = true.obs;
  var remainingTime = Duration(hours: 12).obs;
  var totalVotes = 0.obs;
  var voteTitle = ''.obs;
  var voteId = 0.obs;
  var voteContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVoteData();
  }

  Future<void> fetchVoteData() async {
    //TODO: 待接入数据
  }
  Future<void> vote(int index) async {
    // final response = await http.post(
    //   Uri.parse('https://api.example.com/vote'),
    //   body: jsonEncode({
    //     'optionIndex': index,
    //   }),
    // );
    //
    // if (response.statusCode == 200) {
    //   // Update local state after successful vote
    //   options[index].votes += 1;
    //   totalVotes.value += 1;
    //   canVote.value = false;
    // } else {
    //   // Handle error
    //   print('Failed to vote');
    // }
  }

  String get remainingTimeText {
    if (remainingTime.value.inHours > 1) {
      return LocaleKeys.community75.trArgs([
        "${remainingTime.value.inHours}"
      ]); //'还剩${remainingTime.value.inHours}小时';
    } else {
      return LocaleKeys.community76.trArgs([
        "${remainingTime.value.inMinutes}"
      ]); //'还剩${remainingTime.value.inMinutes}分钟';
    }
  }

  List<int> get percentages {
    if (totalVotes.value == 0) return List.filled(options.length, 0);

    List<double> rawPercentages = options
        .map((option) => (option.votes / totalVotes.value) * 100)
        .toList();
    List<int> roundedPercentages =
        rawPercentages.map((percent) => percent.round()).toList();
    int sum = roundedPercentages.fold(0, (sum, percent) => sum + percent);

    if (sum != 100) {
      int difference = 100 - sum;
      int maxIndex = rawPercentages
          .indexOf(rawPercentages.reduce((a, b) => a > b ? a : b));
      roundedPercentages[maxIndex] += difference;
    }

    return roundedPercentages;
  }
}
