import 'package:get/get.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/enums/send_code.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';

class MySafeWithdrawalController extends GetxController {
  String smsCode = '';
  String emailCode = '';
  String googleCode = '';
  final int verifCount;
  MySafeWithdrawalController({this.verifCount = 2});

  int get currentIndex {
    int nonEmptyCount = 0;

    if (smsCode.isNotEmpty) nonEmptyCount++;
    if (emailCode.isNotEmpty) nonEmptyCount++;
    if (googleCode.isNotEmpty) nonEmptyCount++;

    return nonEmptyCount;
  }

  void onInit() {
    super.onInit();
  }

  verificationGo(type) async {
    var sendType;
    var verification = VerificationDataModel();
    switch (type) {
      case Ver2FAEnum.mobile:
        if (UserGetx.to.isSetMobile) {
          if (UserGetx.to.isMobileVerify) {
            sendType = UserSafeVerificationEnum.MOBILE_CRYTO_WITHDRAW;
            break;
          } else {
            Get.toNamed(Routes.MY_SAFE_MOBILE, preventDuplicates: false);
            return;
          }
        } else {
          Get.toNamed(Routes.MY_SAFE_MOBILE_BIND, preventDuplicates: false);
          return;
        }

      case Ver2FAEnum.email:
        if (UserGetx.to.isSetEmail) {
          sendType = UserSafeVerificationEnum.EMAIL_CRYTO_WITHDRAW;
          break;
        } else {
          Get.toNamed(Routes.MY_SAFE_EMAIL_BIND, preventDuplicates: false);
          return;
        }

      case Ver2FAEnum.google:
        if (UserGetx.to.isGoogleVerify) {
          break;
        } else {
          Get.toNamed(Routes.MY_SAFE_GOOGLE_BIND, preventDuplicates: false);
          return;
        }

      default:
    }
    verification.type = '$type';

    var res = await Get.toNamed(Routes.MY_SAFE_WITHDRAWAL_VERIFICATION,
        arguments: {'type': sendType, 'verificatioData': verification},
        preventDuplicates: false);
    if (res != null) {
      switch (type) {
        case Ver2FAEnum.mobile:
          smsCode = res;
        case Ver2FAEnum.email:
          emailCode = res;
        case Ver2FAEnum.google:
          googleCode = res;

        default:
      }
      update();
      if (currentIndex == verifCount) {
        var vData = {
          'smsCode': smsCode,
          'emailCode': emailCode,
          'googleCode': googleCode,
        };
        Get.back(result: vData);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
