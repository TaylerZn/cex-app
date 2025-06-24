import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_record.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/controllers/customer_order_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/order_detail/controllers/order_detail_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';

import '../../../../../api/otc/otc.dart';
import '../../../../../utils/utilities/ui_util.dart';

class OrderListController extends GetListController<Record?> {
  late RecordTabType tabType;
  late OTCOrderType orderType;
  int count = 0;
  OrderListController(this.tabType, this.orderType);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (UserGetx.to.isLogin) {
      refreshData(false);
    }
  }


  @override
  Future<List<Record?>> fetchData() async {
    Map<String, dynamic> params = {};
    params['current'] = pageIndex;
    params['size'] = pageSize;
    params['tab'] = tabType.key;
    if (ObjectUtil.isNotEmpty(orderType.key)) {
      params['status'] = orderType.key;
    }
    final controller = Get.find<CustomerOrderController>();

    if (ObjectUtil.isNotEmpty(controller.filterBean)) {
      params['startTime'] =
          DateUtil.formatDate(controller.filterBean?.startTime.value);
      params['endTime'] =
          DateUtil.formatDate(controller.filterBean?.endTime.value);
      if (ObjectUtil.isNotEmpty(controller.filterBean?.type().key)) {
        params['side'] = controller.filterBean?.type().key;
      }
    }
    OtcRecord? record;
    try {
      record = await OtcApi.instance().orderPage(
          startTime: params['startTime'],
          endTime: params['endTime'],
          side: params['side'],
          currentPage: params['current'],
          size: params['size'],
          tab: params['tab'],
          status: params['status']);
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }

    Get.find<OrderDetailController>(tag: tabType.key).record.value = record;
    count = record?.records?.length ?? 0;

    // TODO: implement fetchData
      return record?.records ?? [];
  }
}
