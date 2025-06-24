import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/advert_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/personal_profile/controllers/personal_profile_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonalRecordController extends GetListController<DataList?> {
  //TODO: Implement CommissionRecordController


  @override
  void onInit() {
    super.onInit();
    change(Get.find<PersonalProfileController>().dataList,status: Get.find<PersonalProfileController>().dataList?.isEmpty == true ? RxStatus.empty() :  RxStatus.success());

  }

  Future<void> cancelAdvert(DataList? data) async {
    EasyLoading.show();
    bool? model = await OtcApi.instance().advertCancel(data?.advertId);
    EasyLoading.dismiss();
    if(model == true){
      UIUtil.showSuccess('取消成功');
      dataList.remove(data);
      change(dataList,
          status: dataList.isEmpty ? RxStatus.empty() : RxStatus.success());

    }
  }

  @override
  Future<List<DataList?>> fetchData() async {
    AdvertModel? model = await OtcApi.instance().advertList(currentPage: pageIndex,pageSize: pageSize,uid:Get.find<PersonalProfileController>().uid! );
    return model?.dataList ?? [];
  }
}
