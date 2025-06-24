import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ContractTransactionTopBar extends StatefulWidget {
  const ContractTransactionTopBar({super.key, required this.onTabChanged});
  final ValueChanged<int> onTabChanged;

  @override
  State<ContractTransactionTopBar> createState() =>
      _ContractTransactionTopBarState();
}

class _ContractTransactionTopBarState extends State<ContractTransactionTopBar> {
  final List<String> _tabs = [LocaleKeys.trade4, LocaleKeys.trade5];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1,
          ),
        ),
      ),
      child: ListView.separated(
        itemCount: _tabs.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20.w,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                _currentIndex = index;
                widget.onTabChanged(index);
              });
            },
            child: Container(
              height: 40.h,
              alignment: Alignment.center,
              child: Text(
                _tabs[index].tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: index == _currentIndex
                      ? AppColor.colorBlack
                      : AppColor.color999999,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
