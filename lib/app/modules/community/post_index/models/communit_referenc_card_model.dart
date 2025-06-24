class CommunityReferenceCardModel {
  String? memberHeadUrl;
  String? topicTitle;
  String? topicContent;
  String? topicNo;
  bool isActive;
  CommunityReferenceCardModel(
      {this.memberHeadUrl,
      this.topicTitle,
      this.topicContent,
      this.topicNo,
      this.isActive = true});
}
