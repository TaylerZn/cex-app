import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/model/follow_super_model.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/model/apply_supertrade_help.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class ApplySupertradeController extends GetxController {
  final List<String> messageArray = [LocaleKeys.follow263.tr, LocaleKeys.follow264.tr, LocaleKeys.follow265.tr];

  final List<ApplySupertradeHelp> helpArray = [];
  FollowSuperListModel model = FollowSuperListModel();
  var btnStr = '';
  num? status;
  @override
  void onInit() {
    super.onInit();
    // AFFollow.supperList().then((value) {
    //   model = value;
    //   update();
    // });

    // //-1未申请，0审核中，1已通过，2已拒绝等等。
    // AFFollow.applyStatus().then((value) {
    //   num? status = value['status'];
    //   if (status == 0) {
    //     btnStr = '审核中';
    //   } else if (status == 1) {
    //     btnStr = '已通过';
    //   } else if (status == 2) {
    //     btnStr = '已拒绝';
    //   } else {
    //     btnStr = '立即申请';
    //   }
    //   update();
    // });
    getData();
  }

  //-1未申请，0审核中，1已通过，2已拒绝等等。
  getData() async {
    model = await AFFollow.supperList();
    var value = await AFFollow.applyStatus();
    status = value['status'];

    if (status == 0) {
      btnStr = LocaleKeys.follow289.tr;
    } else if (status == 1) {
      btnStr = LocaleKeys.follow290.tr;
    } else {
      btnStr = LocaleKeys.follow288.tr;
      status = -1;
    }
    update();
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

//  final List<ApplySupertradeHelp> helpArray = [
//     ApplySupertradeHelp(
//         header: '常见问题',
//         expanded:
//             '这是问题回答常见问题回答常见问题回答常见问题回答常见问题回答常见问题回答常常见问题。这是问题回答常见问题回答常见问题回答常见问题回答常见问题回答常见问题回答常常见问题。这是问题回答常见问题回答常见问题回答常见问题回答常见问题回答常见问题回答常常见问题。'),
//     ApplySupertradeHelp(header: '常见问题', expanded: '这是问题回答常见问题回答常见问题回答常见问题回答常见问题回答常见问题回答常常见问题。'),
//     ApplySupertradeHelp(header: '常见问题', expanded: '这是问题回答常见问题回答常见问题回答常见问题回答常见问题回答常见问题回答常常见问题。'),
//   ];
