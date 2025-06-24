import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/community/widget/more_dialog.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';

import '../../../../../models/community/community.dart';
import '../../../../../widgets/components/community/post_more_bottom_dialog.dart';
import 'action.dart';

class CommunityItemRowController extends GetxController {
  Future<void> performAction(
      MoreActionType action, TopicdetailModel? item, Function? callback) async {
    return await topicPerformAction(action,item,callback);

  }
}
