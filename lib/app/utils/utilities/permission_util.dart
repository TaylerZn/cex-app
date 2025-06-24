import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:permission_handler/permission_handler.dart';

/// denied 拒绝

/// granted 授予

/// restricted 受限
// 操作系统拒绝了所请求功能的访问权限。用户无法更改此应用的状态，可能是由于存在家长控制等活动限制。
// *仅支持 iOS。*

/// limited 受限
// 用户已授权此应用进行有限访问。到目前为止，这仅与照片库选择器有关。
// *仅支持 iOS（iOS14+）。*

///permanentlyDenied 拒绝
// 永久拒绝对所请求功能的权限，请求此权限时不会显示权限对话框。用户仍可以在设置中更改权限状态。
// *在 Android 上：*
// Android 11+ (API 30+)：用户是否拒绝了第二次权限。
// Android 11 (API 30) 以下：用户是否拒绝访问所请求的功能并选择不再显示请求。
//
// *在 iOS 上：*
// 如果用户拒绝访问所请求的功能。

/// provisional 临时
// 应用程序被临时授权发布非中断性用户通知。
// *仅支持 iOS (iOS12+)。*

// 请求相册权限
Future<bool> requestPhotosPermission() async {
  if (GetPlatform.isIOS) {
    // 非Android平台
    final PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      photosOpenAppSettings();
    }
  } else {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    var systemVersion = androidInfo.version.release;

    if (double.parse(systemVersion) < 13) {
      // Android 13以下版本使用旧的权限请求方式
      final PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        photosOpenAppSettings();
      }
    } else {
      // Android 13及以上版本使用新的权限请求方式
      final PermissionStatus status = await Permission.photos.request();
      if (status.isGranted) {
        return true;
      } else {
        photosOpenAppSettings();
      }
    }
  }
  return false; //用户拒绝了权限
}

// 假如你点not allow后，下次点击不会在出现系统权限的弹框（系统权限的弹框只会出现一次），
// 这时候需要你自己写一个弹框，然后去打开app权限的页面
photosOpenAppSettings() {
  UIUtil.showConfirm(LocaleKeys.public65.tr, content: LocaleKeys.public66.tr,
      confirmHandler: () {
    Get.back();
    openAppSettings();
  });
}

// 请求相机权限
Future<bool> requestCameraPermission() async {
  late PermissionStatus status;
  // 1、读取系统权限的弹框
  if (GetPlatform.isIOS) {
    status = await Permission.camera.request();
  } else {
    status = await Permission.camera.request();
  }
  // 2、假如你点not allow后，下次点击不会在出现系统权限的弹框（系统权限的弹框只会出现一次），
  // 这时候需要你自己写一个弹框，然后去打开app权限的页面
  if (status != PermissionStatus.granted) {
    UIUtil.showConfirm(LocaleKeys.public67.tr, content: LocaleKeys.public68.tr,
        confirmHandler: () {
      Get.back();
      openAppSettings();
    });
  } else {
    return true;
  }
  return false;
}



// 请求图像权限
// Future<bool> requestPhotosPermission(context) async {
//   late PermissionStatus status;
//   // 读取系统权限的弹框
//   if (GetPlatform.isIOS) {
//     status = await Permission.storage.request();
//   } else {
//     status = await Permission.photos.request();
//   }
//   // 假如你点not allow后，下次点击不会在出现系统权限的弹框（系统权限的弹框只会出现一次），
//   // 这时候需要你自己写一个弹框，然后去打开app权限的页面
//   if (status != PermissionStatus.granted) {
//     UIUtil.showConfirm("NT需要访问您的相册",
//         content: "这将允许我们读取您的照片和视频，并与您分享。您可以随时在「设置」中更改此设置。", confirmHandler: () {
//       Get.back();
//       openAppSettings();
//     });
//   } else {
//     return true;
//   }
//   return false; //用户拒绝了权限
// }
