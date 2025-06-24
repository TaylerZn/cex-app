import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import '../controllers/vote_controller.dart';
import '../models/vote_option.dart';

class VoteView extends StatelessWidget {
  final VoteController controller = Get.put(VoteController());

  VoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(() {
        return Column(
          children: [
            Text(
              controller.voteContent.value,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColor.color111111,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 9.h),
            Text(
              controller.voteContent.value,
              style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColor.color4D4D4D,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 16.h),
            for (int i = 0; i < controller.options.length; i++)
              ListTile(
                title: Text(controller.options[i].text),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (i == 0) Icon(Icons.check, color: Colors.grey),
                    Text('${controller.percentages[i]}%'),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: controller.canVote.value
                          ? () => controller.vote(i)
                          : null,
                      color:
                          controller.canVote.value ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
                subtitle: LinearProgressIndicator(
                  value: controller.percentages[i] / 100,
                  backgroundColor: Colors.grey[300],
                  color: i == 1 ? Colors.yellow : Colors.blue,
                ),
              ),
            SizedBox(height: 16.h),
            Text('${controller.remainingTimeText}'),
          ],
        );
      }),
    ));
  }
}
