import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots_info/model/assets_spots_info_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsFundsInfoHistoryController
    extends GetListController<AssetsSpotsHistoryModel> {
  String source;
  String? coinSymbol;

  AssetsFundsInfoHistoryController({required this.source, this.coinSymbol});
  @override
  void onReady() {
    super.onReady();

    refreshData(false);
  }

  @override
  Future<List<AssetsSpotsHistoryModel>> fetchData() async {
    AssetsHistoryRecord? res = await OtcApi.instance()
        .c2cFinanceTransactionList(
            source, coinSymbol ?? '', pageSize, pageIndex);
    if (res?.financeList != null && res!.financeList!.isNotEmpty) {
      var array = res.financeList!
          .map((item) => AssetsSpotsHistoryModel.fromMap({
                'type': item.scene,
                'name': TextUtil.isEmpty(item.sceneText) ? "" : item.sceneText,
                'value': item.amount,
                'time': item.createTime.toString(),
              }))
          .toList();
      return array;
    }
    return [];
    // B2COrderTransctionListModel? res =
    //     await OtcApi.instance().b2cOrderTransctionList(
    //   null,
    //   pageSize,
    //   pageIndex,
    // );
    // print(res);
    // if (res != null && res.dataList != null && res.dataList!.isNotEmpty) {
    //   return res.dataList as List<AssetsHistoryRecordItem>;
    // }
    // return [];
  }
}
