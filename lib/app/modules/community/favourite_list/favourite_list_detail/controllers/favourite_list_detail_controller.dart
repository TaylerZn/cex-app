import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';

import '../../../../../models/community/community.dart';

class FavouriteListDetailController extends GetListController {
  //TODO: Implement FavouriteListDetailController
  String? tag;
  FavouriteListDetailController({this.tag});

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    refreshData(false);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  @override
  Future<List<TopicdetailModel?>> fetchData() async {
    // TODO: implement fetchData
    var data = {
      'currentPage': pageIndex,
      'pageSize': pageSize,
      'memberId': UserGetx.to.uid,
    };
    try {
      List<TopicdetailModel> list = [];

      PublicListModel? res;
      if(tag == 'like'){
        res = await CommunityApi.instance().praisePageList(data);
      }else{
        res = await CommunityApi.instance().topicCollectPage(data);
      }


      if (res != null) {
        for (var i = 0; i < res.data!.length; i++) {
          var item = TopicdetailModel.fromJson(res.data![i]);
          list.add(item);
        }
        return list;
      }
    } on dio.DioException catch (e) {
      print('topicpageList: e.error===${e.error}');
    }
    return [];
  }
}
