import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utilities/permission_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

// 显示选择图片方式弹窗
showImagePickDialog(context, Function callback) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            color: AppColor.colorWhite,
            height: 170.w + MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.fromLTRB(
                22.w, 0.h, 22.w, MediaQuery.of(context).padding.bottom),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: (() async {
                    ImagePicker _picker = ImagePicker();
                    Get.back();
                    if (await requestCameraPermission()) {
                      var res =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (res != null) {
                        callback(res);
                      }
                    }
                  }),
                  child: Container(
                    height: 60.0,
                    alignment: Alignment.center,
                    child: const Text(
                      "拍照",
                      style: TextStyle(
                          height: 1,
                          color: AppColor.color111111,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Divider(
                  height: 1.h,
                ),
                InkWell(
                  onTap: (() async {
                    ImagePicker _picker = ImagePicker();
                    Get.back();
                    if (await requestPhotosPermission()) {
                      // Navigator.of(context).pop();
                      var res =
                          await _picker.pickImage(source: ImageSource.gallery);

                      if (res != null) {
                        callback(res);
                      }
                    }
                  }),
                  child: Container(
                    height: 60.0,
                    alignment: Alignment.center,
                    child: const Text(
                      "选择照片",
                      style: TextStyle(
                          height: 1,
                          color: AppColor.color111111,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Container(
                  height: 5.h,
                  color: AppColor.colorFFFFFF,
                ),
                InkWell(
                  child: Container(
                    height: 40.0,
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.public2.tr,
                      style: TextStyle(
                          height: 1,
                          color: AppColor.color111111,
                          fontSize: 15.0),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                )
              ],
            ));
      });
}
