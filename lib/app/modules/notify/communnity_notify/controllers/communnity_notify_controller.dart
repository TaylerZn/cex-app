import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/models/message/user_message.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';

class CommunnityNotifyController extends GetListController<UserMessage>  {
  //TODO: Implement CommunnityNotifyController

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
  Future<List<UserMessage>> fetchData() async {
    // TODO: implement fetchData
    try {
      Map<String,dynamic> res = await PublicApi.instance().getV2UserMessageList(
        pageIndex++,
        pageSize,
        100 , //社区的传值是100
      );

      List<dynamic> list = res['records'];
      List<UserMessage> temp = [];
      list.forEach((element) {
        temp.add( UserMessage.fromJson(element));
      });
      return temp;

    } catch (e) {
      Get.log('refreshData error: $e');
    }
    return [];
  }
}
