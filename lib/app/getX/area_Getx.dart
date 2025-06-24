import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/models/main/main.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

class AreaGetx extends GetxController {
  late String areaCode;
  List<CountryList> countryTypeList = <CountryList>[];

  static AreaGetx get to => Get.find();

  /// 初始化
  @override
  void onInit() {
    setAreaCode();
    super.onInit();
  }

  setAreaCode() {
    try {
      String? code = StringKV.areaCode.get();
      if (code != null && code.isNotEmpty) {
        areaCode = code;
      } else {
        getUserDialingCode().then((value) {
          if (value != null && value != "") {
            areaCode = value;
          } else {
            areaCode = '+39';
          }
        });
      }
    } catch (e) {
      areaCode = '+39';
    }
  }

  Future getUserDialingCode() async {
    try {
      var res = await UserApi.instance().getDialingCode();
      return res.dialingCode;
    } on DioException catch (e) {
      // UIUtil.showError('${e.message}');
      AppLogUtil.e(e);
      return null;
    } catch (e) {
      AppLogUtil.e(e);
      return null;
    }
  }

  getcountrylist() async {
    try {
      CountryListModel? res = await PublicApi.instance().getcountryinfo();
      if (res != null) {
        countryTypeList = res.countryList as List<CountryList>;
        update();
      }
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }

  void setSP(value, {bool? isSave}) async {
    areaCode = value;
    if (isSave == true) {
      StringKV.areaCode.set(value);
    }
    update();
  }

  /// 加载完成
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// 控制器被释放
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
