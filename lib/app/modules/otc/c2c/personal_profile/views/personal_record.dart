import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/advert_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/personal_profile/views/personal_record_row.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../my/commission_record/widget/comission_record_row.dart';
import '../controllers/personal_record_controller.dart';

class PersonalRecordPage extends StatefulWidget {
  const PersonalRecordPage({super.key});

  @override
  State<PersonalRecordPage> createState() => _PersonalRecordPageState();
}

class _PersonalRecordPageState extends State<PersonalRecordPage> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalRecordController>(init: PersonalRecordController(), builder: (controller) {
      return controller.pageObx(
            (state) {
          return SmartRefresher(
            controller: controller.refreshController,
            onRefresh: () => controller.refreshData(true),
            onLoading: controller.loadMoreData,
            enablePullUp: true,
            enablePullDown: true,
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state?.length ?? 0,
              itemBuilder: (context, index) {
                DataList? data =  state?[index];

                return PersonalRecordRow(data:data ,onTap: (){

                  Get.toNamed(Routes.CUSTOMER_DEAL, arguments: {'id':data?.advertId,'coin':data?.paycoinTrade,'isBuy':data?.isPurchase});
                  //  controller.cancelAdvert(datalist);
                });
              },
            ),
          );
        },
        onRetryRefresh: () => controller.refreshData(false),
      );
    });

  }
}
