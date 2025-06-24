import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_record.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/controllers/order_list_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/widget/c2c_detail_row_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../utils/bus/event_bus.dart';
import '../../../../../../utils/bus/event_type.dart';
import '../../../utils/otc_config_utils.dart';

class OrderListPage extends StatefulWidget {
  final RecordTabType tabType;
  final OTCOrderType orderType;

  const OrderListPage({super.key, required this.orderType, required this.tabType});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final RefreshController refreshController = RefreshController();
  late OrderListController controller;

  @override
  void initState() {
    super.initState();
    controller =  Get.find<OrderListController>(tag: '${widget.tabType.key}${widget.orderType.title()}');
    controller.tabType = widget.tabType;
    controller.orderType = widget.orderType;
    // TODO: implement initState
  }

  @override
  void dispose() {
    refreshController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.pageObx(
        onRetryRefresh: () => controller.refreshData(false),
            (data) {
          
          return SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () async {
                await controller.refreshData(true);
                refreshController.refreshToIdle();
                refreshController.loadComplete();
              },
              onLoading: () async {
               await  controller.loadMoreData();
               if(controller.count == 0){
                 refreshController.loadNoData();
               }else{
                 refreshController.loadComplete();
               }
              },
              child:  ListView.builder(padding: EdgeInsets.symmetric(horizontal: 16.w), itemCount: data?.length, itemBuilder: (context,index){
                if(index< (data?.length ?? 0)){
                  Record? record =  data?[index];
                  return C2CDetailRowWidget(record: record,onTap: () async {
                    await OtcConfigUtils.goChatPage(record);
                    controller.refreshData(false);
                  });
                }
                return SizedBox();
              }));
        });
  }

  @override
  void didUpdateWidget(covariant OrderListPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

}
