import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/advert_model.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../models/otc/c2c/payment_info.dart';

class CommissionRecordController extends GetListController<DataList?> {
  //TODO: Implement CommissionRecordController

  @override
  void onInit() {
    super.onInit();
    refreshData(false);
  }

  Future<void> cancelAdvert(DataList? data) async {
    EasyLoading.show();
    dynamic model;
    try {
      EasyLoading.show();
      model = await OtcApi.instance().advertCancel(data?.advertId);
      EasyLoading.dismiss();
      if (model == null) {
        UIUtil.showSuccess('取消成功');
        dataList.remove(data);
        change(dataList, status: dataList.isEmpty ? RxStatus.empty() : RxStatus.success());
      }
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }

  @override
  Future<List<DataList?>> fetchData() async {
    AdvertModel? model;
    try {
      model = await OtcApi.instance().advertList(currentPage: pageIndex, pageSize: pageSize, uid: UserGetx.to.uid!);
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
    return model?.dataList ?? [];
  }
}
