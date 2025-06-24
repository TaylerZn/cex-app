import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

// 获取应用程序的版本信息
class PackageUtil {
  static String? _versionCode;
  static String get versionCode => _versionCode ??= '';

  static String? _buildNumber;
  static String get buildNumber => _buildNumber ??= '';
  static String? _packageName;
  static String get packageName => _packageName ??= '';

  static String? platformCuNum;
  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _versionCode = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    _packageName = packageInfo.packageName;
    platformCuNum ??= dotenv.env['APPBUILDTYPE'];
  }

  // Platform-CU-Num
  // 9 other, 0 iosAppStore, 1 iosTestFlight,2 androidGooglePlay,3 androidAPK
  static int getPlatformCuNum() {
    platformCuNum ??= dotenv.env['APPBUILDTYPE'];
    if (platformCuNum == 'iosAppStore') {
      return 0;
    }
    if (platformCuNum == 'iosTestFlight') {
      return 1;
    }
    if (platformCuNum == 'androidGooglePlay') {
      return 2;
    }
    if (platformCuNum == 'androidAPK') {
      return 3;
    }
    return 9;
  }
}
