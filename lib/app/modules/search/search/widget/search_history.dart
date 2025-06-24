// import 'package:flutter/material.dart';
// import 'package:nt_app_flutter/app/config/theme/app_color.dart';
// import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
// import 'package:nt_app_flutter/app/enums/search.dart';
// import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
// import 'package:nt_app_flutter/app/utils/utils.dart';
// import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

// class SearchHistory extends StatefulWidget {
//   SearchHistory({super.key, required this.type});
//   SearchHistoryEnumn type;
//   @override
//   State<SearchHistory> createState() => _SearchHistoryState();
// }

// class _SearchHistoryState extends State<SearchHistory> {
//   bool isFold = true;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 14.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text('搜索历史', style: AppTextStyle.body_500.color111111),
//               MyImage('his_clear'.svgAssets(), width: 16.w)
//             ],
//           ),
//         ),
//         Container(
//           // color: Colors.red,
//           constraints: BoxConstraints(minHeight: 28.h),
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: FoldWrap(
//             extentHeight: 28.h,
//             spacing: 8.w,
//             runSpacing: 8.w,
//             isFold: isFold,
//             foldLine: 2,
//             foldWidget: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     isFold = !isFold;
//                   });
//                 },
//                 child: Container(
//                     alignment: Alignment.center,
//                     width: 28.w,
//                     height: 28.w,
//                     decoration: ShapeDecoration(
//                       color: AppColor.colorF5F5F5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     child: MyImage(
//                         (isFold ? 'home/search_arrow' : 'home/search_arrow_up')
//                             .svgAssets(),
//                         width: 12.w))),
//             children: widget.array
//                 .map((e) => Container(
//                       height: 28.h,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(6),
//                           color: AppColor.colorF5F5F5),
//                       padding: EdgeInsets.fromLTRB(10.w, 2.h, 10.w, 0),
//                       child: Text(e,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppTextStyle.medium_400.color4D4D4D),
//                     ))
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
