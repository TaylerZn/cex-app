import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class UserAuditStatus {
  /// 审核中
  static const int Reviewing = 0;

  /// 通过
  static const int Success = 1;

  /// 未通过
  static const int Error = 2;

  /// 未提交
  static const int noSubmit = 3;
  // 0-未提交身份认证 1-身份认证审核中 2-身份认证审核通过

  static String getTypeImage(code) {
    switch (code) {
      case Reviewing:
        return 'my/setting/kyc_loading';
      case Success:
        return 'my/setting/kyc_ok';
      case Error:
        return 'my/setting/kyc_error';
      default:
        return '';
    }
  }

  static String getTypeTitle(code) {
    switch (code) {
      case Reviewing:
        return LocaleKeys.user237.tr;
      case Success:
        return LocaleKeys.user238.tr;
      case Error:
        return LocaleKeys.user239.tr;
      default:
        return LocaleKeys.user240.tr;
    }
  }

  static String getTypeInfoTitle(code) {
    switch (code) {
      case Reviewing:
        return LocaleKeys.user237.tr;
      case Success:
        return LocaleKeys.user259.tr;
      case Error:
        return LocaleKeys.user260.tr;
      default:
        return '';
    }
  }

  static String getTypeInfoConnect(code) {
    switch (code) {
      case Reviewing:
        return LocaleKeys.user241.tr;
      case Success:
        return LocaleKeys.user242.tr;
      case Error:
        return LocaleKeys.user243.tr;
      default:
        return '';
    }
  }

  static bool isSuccess(code) {
    switch (code) {
      case Success:
        return true;
      default:
        return false;
    }
  }

  static bool isLoading(code) {
    switch (code) {
      case Reviewing:
        return true;
      default:
        return false;
    }
  }

  static bool isError(code) {
    switch (code) {
      case Error:
        return true;
      default:
        return false;
    }
  }
}
