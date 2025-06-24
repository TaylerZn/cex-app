import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/no/network_error_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class InviteUsersHistoryAgentUserTypeStatChartController
    extends GetxController {
  var userTypeStat = AgentUserTypeStatModel().obs;
  var hasNetworkError = false.obs;
  var isLoadding = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserTypeStat();
  }

  Future<void> fetchUserTypeStat() async {
    try {
      isLoadding.value = true;
      AgentUserTypeStatModel? res =
          await UserApi.instance().agentNewUserTypeStat();
      hasNetworkError.value = false;
      isLoadding.value = false;
      if (res != null) {
        userTypeStat.value = res;
      }
    } catch (e) {
      print('Error fetching user type stat: $e');
      hasNetworkError.value = true;
      isLoadding.value = false;
    }
  }

  void refreshData(bool refresh) {
    if (refresh) {
      fetchUserTypeStat(); // Retry fetching data
    }
  }
}

class InviteUsersHistoryAgentUserTypeStatChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(InviteUsersHistoryAgentUserTypeStatChartController());

    return Obx(() {
      if (controller.hasNetworkError.value) {
        // Show network error widget if there's a network error
        return NetworkErrorWidget(
          onTap: () => controller.refreshData(true),
        );
      }
      if (controller.isLoadding.value) {
        return Center(child: CircularProgressIndicator());
      }
      final stat = controller.userTypeStat.value;
      if (stat.participates == null) {
        return Center(child: CircularProgressIndicator());
      }

      final participates = stat.participates!
          .where((p) => p.type != 'finance')
          .toList(); //这里后台应该取掉的数,但是没有,所以这里手动去掉
      final pieSections = participates
          .map((p) => PieChartSectionData(
                color: getTypeColor(p.type),
                value: p.percent == null
                    ? 0.0
                    : double.parse(p.percent?.replaceFirst('%', '') ?? '0.0'),
                title: '${p.percent}\n${p.count}${LocaleKeys.user292.tr}',
                radius: 115,
                titleStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: p.type == "follow"
                        ? AppColor.colorFFFFFF
                        : AppColor.color111111),
              ))
          .toList();

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 15.h),
            child: Container(
              height: 80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildStatItem(
                        LocaleKeys.user289.tr, stat.directUserCount),
                  ),
                  Expanded(
                    child: _buildStatItem(
                        LocaleKeys.user290.tr, stat.indirectUserCount),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 232.50.w,
            height: 232.50.h,
            child: PieChart(PieChartData(
              sections: pieSections,
              centerSpaceRadius: 0,
              sectionsSpace: 0,
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: participates
                  .map((p) => _buildLegendItem(
                      p.typeTxt ?? '', getTypeColor(p.type), p.percent ?? ''))
                  .toList(),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildStatItem(String title, int? count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // 垂直居中对齐
      crossAxisAlignment: CrossAxisAlignment.start, // 水平靠左对齐
      children: [
        Container(
          child: Text('$count',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColor.color111111,
                  fontWeight: FontWeight.w600)),
        ),
        Container(
          child: Text(title,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.colorABABAB,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String title, Color color, String percent) {
    return Column(
      children: [
        Container(width: 16, height: 16, color: color),
        SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 14)),
        Text(percent, style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Color getTypeColor(String? type) {
    switch (type) {
      case 'futures_exchange':
        return AppColor.colorFFD429; //Colors.yellow;
      case 'finance':
        return AppColor.colorSuccess;
      case 'follow':
        return AppColor.color2F2F2F;
      default:
        return Colors.grey;
    }
  }
}
