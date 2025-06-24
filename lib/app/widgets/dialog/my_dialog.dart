// import 'package:get/get.dart';
// import 'package:nt_app_flutter/app/config/theme/app_color.dart';
// import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nt_app_flutter/app/utils/utils.dart';

// void showMyDialog(widgetContext, title, content, cupertino,
//     {barrierDismissible = true, isRightBack = true}) {
//   showDialog<Null>(
//     context: widgetContext,
//     barrierDismissible: barrierDismissible,
//     useRootNavigator: false,
//     builder: (BuildContext context) {
//       return Center(
//         child: SingleChildScrollView(
//             child: Container(
//                 width: 255.w,
//                 padding: EdgeInsets.fromLTRB(16.w, 24.w, 16.w, 10.w),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(6),
//                   color: AppColor.color111111,
//                 ),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                               child: Text(
//                             '$title'.stringSplit(),
//                             style: TextStyle(
//                                 fontSize: 16.sp, fontWeight: FontWeight.w600),
//                             maxLines: 2,
//                           )),
//                         ],
//                       ),
//                       content.isNotEmpty
//                           ? Container(
//                               margin: EdgeInsets.fromLTRB(0, 8.w, 0, 15.w),
//                               child: Text('$content'.stringSplit(),
//                                   style: TextStyle(
//                                       color: AppColor.color4D4D4D,
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w400)),
//                             )
//                           : SizedBox(
//                               height: 30.w,
//                             ),
//                       Container(
//                         height: 44.w,
//                         child: Row(
//                           children: worker<Widget>(cupertino, (index, item) {
//                             return Expanded(
//                                 child: GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               child: Container(
//                                 margin: EdgeInsets.only(
//                                     right: index == 0 ? 6.w : 0),
//                                 alignment: Alignment.center,
//                                 height: 44.w,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(6),
//                                     color: index == 0
//                                         ? AppColor.colorF5F5F5
//                                         : AppColor.color111111),
//                                 child: Text(
//                                   '${item['name']}',
//                                   style: TextStyle(
//                                       color: index == 0
//                                           ? AppColor.color111111
//                                           : AppColor.colorFFFFFF,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                               onTap: () {
//                                 if (item['tap'] != null) {
//                                   if (isRightBack == true) {
//                                     Get.back();
//                                   }
//                                   item['tap']();
//                                 } else {
//                                   Get.back();
//                                 }
//                               },
//                             ));
//                           }),
//                         ),
//                       )
//                     ]))),
//       );
//     },
//   );
// }
