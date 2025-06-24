import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take/controllers/my_take_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';

//

class MyTakeTop extends StatelessWidget {
  const MyTakeTop({
    super.key,
    required this.controller,
  });
  final MyTakeController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(left: 16, right: 0, top: 26.h, bottom: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(LocaleKeys.follow184.tr,
                      style: AppTextStyle.f_14_500.color111111),
                  Text(controller.infoModel.rateStr,
                      style: AppTextStyle.f_38_600.color111111),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: Row(
                      children: [
                        Text('${LocaleKeys.follow40.tr}(USDT)',
                            style: AppTextStyle.f_12_400.color999999),
                        SizedBox(width: 8.w),
                        Text(controller.infoModel.i90TraderTotalAmountStr,
                            style: AppTextStyle.f_14_500.color111111),
                      ],
                    ),
                  ),
                ],
              ),
              MyImage('assets/images/contract/my_take_top_right.png',
                      width: 77.w, height: 90.w)
                  .paddingOnly(right: 12.w),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MyButton(
                    text: LocaleKeys.follow192.tr,
                    color: Colors.white,
                    textStyle: AppTextStyle.f_15_600,
                    backgroundColor: Colors.black,
                    height: 40.h,
                    onTap: () => Get.toNamed(Routes.MY_TAKE_PARTING,
                        arguments: {'model': controller.infoModel})),
              ),
              SizedBox(width: 13.w),
              Expanded(
                child: MyButton(
                  text: LocaleKeys.follow193.tr,
                  color: AppColor.color111111,
                  textStyle: AppTextStyle.f_15_600,
                  backgroundColor: AppColor.colorWhite,
                  border: Border.all(color: AppColor.color111111),
                  height: 40.h,
                  onTap: () => Get.toNamed(Routes.MY_TAKE_SHIELD,
                      arguments: {'model': controller.infoModel}),
                ),
              ),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
    ));
  }
}

class MyTakeTabbar extends StatelessWidget {
  const MyTakeTabbar(
      {super.key, required this.dataArray, required this.controller});
  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
        ),
      ),
      height: 40.h,
      width: double.infinity,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_14_500,
        unselectedLabelStyle: AppTextStyle.f_14_500,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColor.colorBlack,
            width: 2.h,
          ),
          insets: EdgeInsets.only(left: 14.w, right: 14.w, top: 0, bottom: 0),
        ),
        labelPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    ));
  }
}

// class MyDialog extends StatelessWidget {
//   const MyDialog({super.key, required this.controller});
//   final MyTakeController controller;

//   @override
//   Widget build(BuildContext context) {
//     controller.textVC = TextEditingController();
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Container(
//         padding: EdgeInsets.fromLTRB(16, 24.h, 16, 10.h),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '分润比例设置',
//               style: TextStyle(
//                 color: AppColor.color333333,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 16.h, bottom: 10.h),
//               padding: const EdgeInsets.only(left: 12, right: 10, top: 12, bottom: 8),
//               decoration: BoxDecoration(
//                 color: AppColor.colorF4F4F4,
//                 borderRadius: BorderRadius.circular(6.0),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                       child: SearchTextField(
//                     height: 24,
//                     controller: controller.textVC,
//                     hintText: '建议5%-70%',
//                     havePrefixIcon: false,
//                     haveSuffixIcon: false,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                     inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))],
//                   )),
//                   const Text(
//                     '%',
//                     textAlign: TextAlign.right,
//                     style: TextStyle(
//                       color: Color(0xFF111111),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(bottom: 20.h),
//               child: Text.rich(
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                       text: '*',
//                       style: TextStyle(
//                         color: AppColor.downColor,
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     TextSpan(
//                       text: '调整成功后从下一笔带单生效，当前带单按照原有比例分润，可能产生推广费0%-4.5%，请高于最高推广费',
//                       style: TextStyle(
//                         color: AppColor.color999999,
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: MyButton(
//                     text: '确认修改 ',
//                     color: AppColor.colorWhite,
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.w600,
//                     backgroundColor: AppColor.color111111,
//                     height: 40.h,
//                     onTap: () {
//                       controller.editCommission();
//                       Get.back();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
