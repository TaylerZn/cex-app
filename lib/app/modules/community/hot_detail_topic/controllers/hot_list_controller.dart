import 'package:dio/dio.dart' as dio;
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';

class HotListController extends GetListController<TopicdetailModel> {
  String tag;
  String? keyword;
  HotListController(this.tag, this.keyword);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshData(false);
  }

  @override
  Future<List<TopicdetailModel>> fetchData() async {
    List<TopicdetailModel> list = [];
    try {
      var data = {
        'currentPage': pageIndex,
        'pageSize': pageSize,
        'keyWords' : keyword ?? '',
        'sortType' : tag.contains('hot') ? '1' :'2'
      };

      PublicListModel? res = await CommunityApi.instance().topicpageList(data);
      for (var i = 0; i < res?.data!.length; i++) {
        var item = TopicdetailModel.fromJson(res?.data![i]);
        list.add(item);
      }
    } on dio.DioException catch (e) {
      print('topicpageList: e.error===${e.error}');
    }
    // TODO: implement fetchData
    return list;
  }
}
