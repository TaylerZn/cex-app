class VoteOption {
  String text;
  int votes;

  VoteOption({required this.text, this.votes = 0});

  factory VoteOption.fromJson(Map<String, dynamic> json) {
    return VoteOption(
      text: json['text'],
      votes: json['votes'],
    );
  }
}
