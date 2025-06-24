import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nt_app_flutter/app/api/file/file_interface.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/kyc.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/file/file.dart';
import 'package:nt_app_flutter/app/models/main/main.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_log_event_name.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_manager.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/permission_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/dialog/image_pick_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class KycIndexController extends GetxController {
  late PageController childPageController; //控制器不能放在logic，会被多个子page复用
  var idFrontImage;
  var idReverseImage;
  var idHoldingImage;
  var idHoldingImageType = KycImageEnum.NOT_UPLOADED;
  var idFrontImageType = KycImageEnum.NOT_UPLOADED;
  var idReverseImageType = KycImageEnum.NOT_UPLOADED;
  var passportBeforeByteLength;
  var idFrontBeforeByteLength;
  var idReverseBeforeByteLength;
  var pageIndex = 0;
  TextEditingController surnameTextControll = TextEditingController();
  TextEditingController nameTextControll = TextEditingController();
  TextEditingController documentsTextControll = TextEditingController();
  int idType = 1;
  CountryList? countryData;
  String chinaCode = '156';

  DateTime? birthDate;

  @override
  void onInit() {
    if (AreaGetx.to.countryTypeList.isEmpty) {
      AreaGetx.to.getcountrylist();
    }
    childPageController = PageController();
    super.onInit();
  }

  onSubmit() async {
    EasyLoading.show();
    CommonuploadimgModel? firstPhoto =
        await commonuploadimg(await idFrontImage.file);
    CommonuploadimgModel? secondPhoto =
        await commonuploadimg(await idReverseImage.file);
    CommonuploadimgModel? thirdPhoto =
        await commonuploadimg(await idHoldingImage.file);
    var data = {
      'countryCode': countryData?.dialingCode, //国家电话区号
      'numberCode': countryData?.numberCode, //国家数字代码
      'certificateType': idType == KycIdTypeEnum.idCard ? '1' : '2', //认证种类
      'certificateNumber': documentsTextControll.text, //ID号码
      'firstPhoto': '${firstPhoto?.baseImageUrl}${firstPhoto?.filename}',
      'secondPhoto': '${secondPhoto?.baseImageUrl}${secondPhoto?.filename}',
      'thirdPhoto': '${thirdPhoto?.baseImageUrl}${thirdPhoto?.filename}',
      'birthday': birthDate != null ? DateUtil.formatDate(birthDate,format:  DateFormats.y_mo_d) : '', //生日
    };
    // if (idType == KycIdTypeEnum.idCard) {
    //   data['userName'] = nameTextControll.text; //姓
    // } else {
      data['familyName'] = surnameTextControll.text; //姓
      data['name'] = nameTextControll.text; //名
    // }

    try {
      await UserApi.instance().userv4authrealname(data);
      AppsFlyerManager().logEvent(AFLogEventName.complete_kyc);
      UserGetx.to.getRefresh();
      Get.back(result: true);
      Bus.getInstance().emit(EventType.closeKycDialog);
      UIUtil.showSuccess(
        LocaleKeys.user59.tr,
      );
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
    EasyLoading.dismiss();
  }

  getKycImage(type) async {
    //0、手持证件照 1、证件正面 2、证件反面
    if (await requestPhotosPermission()) {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: const AssetPickerConfig(
            requestType: RequestType.image, maxAssets: 1),
      );
      // ImagePicker _picker = ImagePicker();

      //                   if (await requestPhotosPermission()) {
      //                     var result = await _picker.pickImage(
      //                         source: ImageSource.gallery);

      // showImagePickDialog(Get.context, (result) async {
      if (result != null) {
        var file = await result[0].file;
        var beforeByteLength = file?.readAsBytesSync().length;
        if (beforeByteLength != null) {
          if (type == 0) {
            idHoldingImage = result[0];
            passportBeforeByteLength = beforeByteLength;
          } else if (type == 1) {
            idFrontImage = result[0];
            idFrontBeforeByteLength = beforeByteLength;
          } else if (type == 2) {
            idReverseImage = result[0];
            idReverseBeforeByteLength = beforeByteLength;
          }
          if (beforeByteLength < 100 * 1024 * 1024) {
            if (type == 0) {
              idHoldingImageType = KycImageEnum.UPLOADED;
            } else if (type == 1) {
              idFrontImageType = KycImageEnum.UPLOADED;
            } else if (type == 2) {
              idReverseImageType = KycImageEnum.UPLOADED;
            }
          } else {
            if (type == 0) {
              idHoldingImageType = KycImageEnum.LIMIT;
            } else if (type == 1) {
              idFrontImageType = KycImageEnum.LIMIT;
            } else if (type == 2) {
              idReverseImageType = KycImageEnum.LIMIT;
            }
          }
        } else {
          UIUtil.showToast(
            LocaleKeys.user91.tr,
          );
        }
        update();
      }
      // });
    }
  }

  int getNextButtonColor() {
    var canColor = 0xff111111;
    var notColor = 0xffCCCCCC;

    switch (childPageController.initialPage) {
      case 0:
        if (canNextPage()) {
          return canColor;
        }
        return notColor;

      case 1:
        if (canNextPage()) {
          return canColor;
        }
        return notColor;
      case 2:
        if (canNextPage()) {
          return canColor;
        }
        return notColor;
      default:
        return notColor;
    }
  }

  bool canNextPage() {
    if (pageIndex == 0 && countryData != null) {
      return true;
    }
    if (pageIndex == 1) {
      if(birthDate != null && nameTextControll.text.isNotEmpty && surnameTextControll.text.isNotEmpty && documentsTextControll.text.isNotEmpty){
        return true;
      }
      // if (idType == KycIdTypeEnum.passport) {
      //   if (surnameTextControll.text.isEmpty) {
      //     return false;
      //   }
      // }
      // if (nameTextControll.text.isNotEmpty &&
      //     documentsTextControll.text.isNotEmpty) {
      //   return true;
      // }
    }
    if (pageIndex == 2) {
      if (idHoldingImageType == KycImageEnum.UPLOADED &&
          idFrontImageType == KycImageEnum.UPLOADED &&
          idReverseImageType == KycImageEnum.UPLOADED) {
        return true;
      }
    }
    return false;
  }

  getFileName(data) {
    var name = data.toLowerCase();
    if (name.indexOf('heic') != -1) {
      return name + '.jpeg';
    } else {
      return name;
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
