import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_enum.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_model.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_search_text_field.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

showBottomSheetView(FillterModel model, {BottomViewType bottomType = BottomViewType.defaultView}) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return CustomBottomSheet(
        model: model,
        bottomType: bottomType,
      );
    },
  );
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.model, required this.bottomType});
  final FillterModel model;
  final BottomViewType bottomType;

  @override
  Widget build(BuildContext context) {
    var type = bottomType != BottomViewType.defaultView ? bottomType : model.bottomType;

    switch (type) {
      // case BottomViewType.exportView:
      //   return getExportView(context);
      case BottomViewType.dateView:
        return getTimeView(context);
      case BottomViewType.multipleChoice:
        return getMultipleChoiceView(context);
      default:
        return getDefaultView(context);
    }
  }

  Widget getDefaultView(BuildContext context) {
    var height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 74;
    var containH = 164.w + model.actionArray.length * 44.w;
    model.textClear();
    return Container(
      height: containH < height ? containH : height,
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 24.w),
            child: Text(model.title,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColor.color111111,
                  fontWeight: FontWeight.w600,
                )),
          ),
          model.filterType == FilterType.contract
              ? MySearchTextField(
                  height: 36.h,
                  hintText: LocaleKeys.public10.tr,
                  textEditingController: model.controller,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                )
              : SizedBox(height: 12.h),
          Expanded(
              child: Obx(
            () => ListView.builder(
              itemCount: model.actionArray.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(12.w),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: index == model.currentIndex ? AppColor.colorF5F5F5 : Colors.transparent),
                  child: GestureDetector(
                    onTap: () {
                      model.filterIndex = index;
                      Navigator.pop(context);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(model.actionArray[index],
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColor.color111111,
                              fontWeight: FontWeight.w600,
                            )),
                        index == model.currentIndex
                            ? Icon(
                                Icons.check,
                                color: AppColor.color111111,
                                size: 16.w,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
          const Divider(),
          MyButton.borderWhiteBg(
            height: 48.w,
            text: LocaleKeys.public2.tr,
            onTap: () {
              Navigator.pop(context);
            },
          ).marginAll(16.w)
        ],
      ),
    );
  }

  Widget getMultipleChoiceView(BuildContext context) {
    return Container(
      height: 145.w + model.stateArray.length * 56.w,
      // padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.w, bottom: 12.w, left: 16.w, right: 16.w),
            child: Text(model.title, style: AppTextStyle.f_20_600.color111111),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.stateArray.length,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(12.w),
                  margin: EdgeInsets.only(bottom: 12.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          width: 1, color: model.stateArray[index].select ? AppColor.colorBlack : AppColor.colorEEEEEE)),
                  child: GestureDetector(
                    onTap: () {
                      model.stateArray[index].select = !model.stateArray[index].select;
                      model.stateFilter();
                      Navigator.pop(context);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(model.stateArray[index].name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColor.color111111,
                              fontWeight: FontWeight.w600,
                            )),
                        model.stateArray[index].select
                            ? Icon(
                                Icons.check,
                                color: AppColor.color111111,
                                size: 16.w,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          MyButton.outline(
            text: LocaleKeys.public2.tr,
            onTap: () {
              Navigator.pop(context);
            },
          ).marginAll(16.w),
        ],
      ),
    );
  }

  Widget getTimeView(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 24.w, bottom: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleKeys.trade159.tr,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.w, bottom: 12.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: model.actionArray
                    .map((e) => GestureDetector(
                        onTap: () {
                          model.timeIndex.value = model.actionArray.indexOf(e);
                          // model.filterIndex = model.actionArray.indexOf(e);
                          // Navigator.pop(context);
                        },
                        child: Obx(
                          () => Container(
                            width: 78.w,
                            height: 32.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 1,
                                    color: model.timeIndex.value == model.actionArray.indexOf(e)
                                        ? AppColor.color111111
                                        : AppColor.colorECECEC)),
                            child: Text(e, style: AppTextStyle.f_13_500.color111111),
                          ),
                        )))
                    .toList()),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: MyButton.borderWhiteBg(
                    height: 48.w,
                    text: LocaleKeys.public2.tr,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 7.w,
                ),
                Expanded(
                  child: MyButton(
                    height: 48.w,
                    text: LocaleKeys.public1.tr,
                    onTap: () {
                      model.filterIndex = model.timeIndex.value;
                      // Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget getExportView(BuildContext context) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: AppColor.colorWhite,
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(15),
  //         topRight: Radius.circular(15),
  //       ),
  //     ),
  //     padding: EdgeInsets.only(left: 16, right: 16, top: 24.w, bottom: 16.w),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         Text(LocaleKeys.trade149.tr,
  //             style: TextStyle(
  //               fontSize: 20.sp,
  //               color: AppColor.color111111,
  //               fontWeight: FontWeight.w600,
  //             )),
  //         Container(
  //           margin: EdgeInsets.only(top: 16.w, bottom: 18.w),
  //           padding: EdgeInsets.only(left: 12, top: 12.w, bottom: 12.w),
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.colorF5F5F5),
  //           child: Row(
  //             children: [
  //               const Icon(
  //                 Icons.info,
  //                 color: AppColor.downColor,
  //               ),
  //               SizedBox(width: 8.w),
  //               Text(LocaleKeys.trade150.tr,
  //                   style: TextStyle(
  //                     fontSize: 12.sp,
  //                     color: AppColor.color333333,
  //                     fontWeight: FontWeight.w400,
  //                   )),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(bottom: 10.w),
  //           child: Text(LocaleKeys.trade151.tr,
  //               style: TextStyle(
  //                 fontSize: 12.sp,
  //                 color: AppColor.color666666,
  //                 fontWeight: FontWeight.w500,
  //               )),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Container(
  //               width: 108.w,
  //               height: 32.h,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(6), border: Border.all(width: 1, color: AppColor.colorF5F5F5)),
  //               child: Text(LocaleKeys.trade152.tr,
  //                   style: TextStyle(
  //                     fontSize: 12.sp,
  //                     color: AppColor.color333333,
  //                     fontWeight: FontWeight.w500,
  //                   )),
  //             ),
  //             Container(
  //               width: 108.w,
  //               height: 32.h,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(6), border: Border.all(width: 1, color: AppColor.color111111)),
  //               child: Text(LocaleKeys.follow136.tr,
  //                   style: TextStyle(
  //                     fontSize: 12.sp,
  //                     color: AppColor.color333333,
  //                     fontWeight: FontWeight.w500,
  //                   )),
  //             ),
  //             Container(
  //               width: 108.w,
  //               height: 32.h,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(6), border: Border.all(width: 1, color: AppColor.colorF5F5F5)),
  //               child: Text(LocaleKeys.trade154.tr,
  //                   style: TextStyle(
  //                     fontSize: 12.sp,
  //                     color: AppColor.color333333,
  //                     fontWeight: FontWeight.w500,
  //                   )),
  //             )
  //           ],
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 10.w, bottom: 24.w),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Container(
  //                 width: 168.w,
  //                 height: 32.h,
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(6), border: Border.all(width: 1, color: AppColor.colorF5F5F5)),
  //                 child: Text(LocaleKeys.trade155.tr,
  //                     style: TextStyle(
  //                       fontSize: 12.sp,
  //                       color: AppColor.color333333,
  //                       fontWeight: FontWeight.w500,
  //                     )),
  //               ),
  //               Container(
  //                 width: 168.w,
  //                 height: 32.h,
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(6), border: Border.all(width: 1, color: AppColor.colorF5F5F5)),
  //                 child: Text(LocaleKeys.trade156.tr,
  //                     style: TextStyle(
  //                       fontSize: 12.sp,
  //                       color: AppColor.color333333,
  //                       fontWeight: FontWeight.w500,
  //                     )),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Container(
  //               width: 159.w,
  //               height: 40.h,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.colorF5F5F5),
  //               child: Text('2024-02-16',
  //                   style: TextStyle(
  //                     fontSize: 12.sp,
  //                     color: AppColor.color333333,
  //                     fontWeight: FontWeight.w500,
  //                   )),
  //             ),
  //             Text(LocaleKeys.trade157.tr,
  //                 style: TextStyle(
  //                   fontSize: 12.sp,
  //                   color: AppColor.color666666,
  //                   fontWeight: FontWeight.w500,
  //                 )),
  //             Container(
  //               width: 150.w,
  //               height: 40.h,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.colorF5F5F5),
  //               child: Text('2024-02-16',
  //                   style: TextStyle(
  //                     fontSize: 12.sp,
  //                     color: AppColor.color333333,
  //                     fontWeight: FontWeight.w500,
  //                   )),
  //             ),
  //           ],
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 16.w, bottom: 21.w),
  //           child: Text(LocaleKeys.trade159.tr,
  //               style: TextStyle(
  //                 fontSize: 12.sp,
  //                 color: AppColor.color666666,
  //                 fontWeight: FontWeight.w500,
  //               )),
  //         ),
  //         const Divider(),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   height: 48.w,
  //                   alignment: Alignment.center,
  //                   margin: EdgeInsets.symmetric(vertical: 16.w),
  //                   decoration: const BoxDecoration(
  //                     image: DecorationImage(
  //                       image: AssetImage(
  //                         'assets/images/trade/entrust_filter_cancel.png',
  //                       ),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   child: Text(LocaleKeys.public2.tr,
  //                       style: TextStyle(
  //                         fontSize: 16.sp,
  //                         color: AppColor.color111111,
  //                         fontWeight: FontWeight.w600,
  //                       )),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   height: 48.w,
  //                   alignment: Alignment.center,
  //                   margin: EdgeInsets.symmetric(vertical: 16.w),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(6),
  //                     // color: AppColor.upColor,
  //                     image: const DecorationImage(
  //                       image: AssetImage(
  //                         'assets/images/trade/entrust_filter_sure.png',
  //                       ),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   child: Text(LocaleKeys.public1.tr,
  //                       style: TextStyle(
  //                         fontSize: 16.sp,
  //                         color: AppColor.colorWhite,
  //                         fontWeight: FontWeight.w600,
  //                       )),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
