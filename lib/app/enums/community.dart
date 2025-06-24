// 社区特殊字符Enum
enum SpecialContentEnum {
  postTitle,
  postContent,
  firstLevelComments,
  secondLevelComments,
}

class MemberTypeEnum {
  static const NORMAL_MEMBER = '0';
  static const REAL_MEMBE = '1';
  static const OPERATOR_MEMBER = '2';
  static const OPERATOR_TRADERS = '3';
  static const SUPER_TRADERS = '4';

  static bool isSuper(code) {
    switch ('$code') {
      case SUPER_TRADERS:
        return true;
      default:
        return false;
    }
  }
}
