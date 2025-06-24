class UserTagModel {
  String tag;
  bool isDelete;
  bool isAdded;
  bool isDefineAdd;

  UserTagModel({
    required this.tag,
    required this.isDelete,
    this.isAdded = false,
    this.isDefineAdd =false,
  });

  void setAdd() {
    isAdded = true;
  }
}
