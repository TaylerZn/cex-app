import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/main_tab/models/trade_type.dart';
import 'package:nt_app_flutter/app/modules/transation/trades/controllers/trades_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class SwitchTransactionView extends StatefulWidget {
  const SwitchTransactionView({super.key, required this.btnBottom});

  final double btnBottom;

  static Future<int?> show(double btnBottom) async {
    return await Get.bottomSheet<int>(
      SwitchTransactionView(
        btnBottom: btnBottom,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: false,
    );
  }

  @override
  State<SwitchTransactionView> createState() => _SwitchTransactionViewState();
}

class _SwitchTransactionViewState extends State<SwitchTransactionView>
    with SingleTickerProviderStateMixin {
  /// 交易类型列表
  List<Map<String, dynamic>> transactionTypeList = [
    {
      'icon': 'assets/images/contract/tran_follow.png',
      'title': LocaleKeys.trade1.tr
    },
    {
      'icon': 'assets/images/contract/tran_contract.png',
      'title': LocaleKeys.trade2.tr
    },
    {
      'icon': 'assets/images/contract/tran_convert.png',
      'title': LocaleKeys.trade289.tr //闪兑
    },
    // {
    //   'icon': 'assets/images/contract/tran_spot_goods.png',
    //   'title': LocaleKeys.trade3.tr
    // },
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1.0 / 4.0).animate(_controller);
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 343.w,
          height: 180.h,
          padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/contract/switch_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0),
            itemCount: transactionTypeList.length,
            itemBuilder: (BuildContext context, int index) {
              bool isSelect = false;
              if (index == 0) {
              } else if (index == 1) {
                if (TradesController.to.tradeIndextype.value !=
                    TradeIndexType.immediate) {
                  isSelect = MainTabController.to.tradeType.value ==
                      TradeType.contract;
                }
              } else if (index == 2) {
                isSelect = TradesController.to.tradeIndextype.value ==
                    TradeIndexType.immediate;
              }
              return _buildItem(transactionTypeList[index]['icon'],
                  transactionTypeList[index]['title'], isSelect, () {
                if (index == 1) {
                  MainTabController.to.tradeType.value = TradeType.contract;
                  TradesController.to.tradeIndextype.value =
                      TradeIndexType.contract;
                }
                if (index == 2) {
                  //闪兑
                  RouteUtil.goTo('/immediate-exchange');
                }
                Get.back(result: index);
              });
            },
          ),
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.colorWhite,
              borderRadius: BorderRadius.circular(23.w),
            ),
            width: 48.w,
            height: 48.w,
            alignment: Alignment.center,
            child: RotationTransition(
              turns: _animation,
              child: MyImage(
                'assets/images/contract/trade_close.png',
                width: 12.w,
                height: 12.w,
              ),
            ),
          ),
        ),
        SizedBox(
          height: (Get.height - widget.btnBottom),
        ),
      ],
    );
  }

  _buildItem(String icon, String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.colorF5F5F5 : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            MyImage(
              icon,
              width: 16.w,
              height: 16.w,
            ),
            10.horizontalSpace,
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (isSelected)
              MyImage(
                'assets/images/contract/trade_selected.png',
                width: 12.w,
                height: 12.w,
              ),
          ],
        ),
      ),
    );
  }
}
