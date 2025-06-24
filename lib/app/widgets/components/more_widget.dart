// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
// import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
// import 'package:nt_app_flutter/app/utils/utils.dart';
// import 'package:nt_app_flutter/app/api/community/community_interface.dart';
// import 'package:nt_app_flutter/app/getX/user_Getx.dart';
// import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
// import 'package:nt_app_flutter/app/widgets/dialog/my_dialog.dart';
// 

// import 'package:animations/animations.dart';

// enum MyMoreType {
//   userInfo, // 文字帖子
//   imagePost, // 图文帖子
//   videoPost, // 视频帖子
// }

// myMoreWidget(context, infoData, id,
//     {isMe = false,
//     MyMoreType type = MyMoreType.userInfo,
//     callBack,
//     isBlock = false,
//     permissionType = 0}) {
//   var islogin = true;
//   if (Get.find<UserGetx>().isLogin) {
//   } else {
//     islogin = false;
//   }

//   // type  0 个人主页 1 图文帖子 2视频帖子
//   return Container(
//       width: MediaQuery.of(context).size.width,
//       child: Column(children: [
//         Container(
//           decoration: BoxDecoration(
//               color: Color(0xff999999),
//               borderRadius: BorderRadius.circular(16)),
//           width: 40.w,
//           height: 5.w,
//         ),
//         islogin
//             ? Column(
//                 children: [
//                   SizedBox(
//                     height: 24.w,
//                   ),
//                   // Container(
//                   //     height: 80.w,
//                   //     child: Row(
//                   //         crossAxisAlignment: CrossAxisAlignment.start,
//                   //         mainAxisAlignment: MainAxisAlignment.start,
//                   //         children: [
//                   //           Container(
//                   //               width: MediaQuery.of(context).size.width,
//                   //               child: SingleChildScrollView(
//                   //                   scrollDirection: Axis.horizontal,
//                   //                   child: ListView.builder(
//                   //                       shrinkWrap: true,
//                   //                       scrollDirection: Axis.horizontal,
//                   //                       itemCount: itemCount,
//                   //                       itemBuilder: (context, index) {
//                   //                         SocialmessagepublicspageModelRecordsUserInfo?
//                   //                             data;
//                   //                         // if (index != 0 && index != itemCount - 1) {
//                   //                         data = shareDataList[index];
//                   //                         // }
//                   //                         return index != itemCount - 1
//                   //                             ? index == 0
//                   //                                 ? Padding(
//                   //                                     padding: EdgeInsets.only(
//                   //                                         left: 12.w),
//                   //                                     child: MyMoreItemWidget(
//                   //                                         context,
//                   //                                         'private_letter'
//                   //                                             .svgAssets(),
//                   //                                         S.current.lang_502,
//                   //                                         () {
//                   //                                       Get.back();
//                   //                                       // Get.to(DMFriendPage(
//                   //                                       //   id: id,
//                   //                                       //   type: type,
//                   //                                       //   infoData: infoData,
//                   //                                       // ));
//                   //                                     }))
//                   //                                 : MyMoreItemWidget(
//                   //                                     context,
//                   //                                     '${data.icon ?? ''}',
//                   //                                     '${data.nickname ?? ''}',
//                   //                                     () {
//                   //                                       // moreShareOnTap(id, data?.uid,
//                   //                                       //     type, infoData);
//                   //                                       showMyShareDialog(
//                   //                                         context,
//                   //                                         id,
//                   //                                         data,
//                   //                                         type,
//                   //                                         infoData,
//                   //                                       );
//                   //                                     },
//                   //                                   )
//                   //                             : MyMoreItemWidget(
//                   //                                 context,
//                   //                                 'more_friend_more'
//                   //                                     .svgAssets(),
//                   //                                 S.current.more,
//                   //                                 () {
//                   //                                   Get.back();
//                   //                                   // Get.to(DMFriendPage(
//                   //                                   //   id: id,
//                   //                                   //   type: type,
//                   //                                   //   infoData: infoData,
//                   //                                   // ));
//                   //                                 },
//                   //                               );
//                   //                       })))
//                   //         ])),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(0, 13.w, 0, 16.w),
//                     width: MediaQuery.of(context).size.width,
//                     height: 1.w,
//                     color: Color(0xffEEEEEE),
//                   ),
//                 ],
//               )
//             : SizedBox(
//                 height: 16.w,
//               ),
//         Row(
//           children: [
//             // Padding(
//             //     padding: EdgeInsets.only(left: 12.w),
//             //     child: MyMoreItemWidget(
//             //         context, 'more_picture'.svgAssets(), '生成海报', () {
//             //       var arguments;
//             //       switch (type) {
//             //         case MyMoreType.userInfo:
//             //           arguments = {'data': infoData, 'type': 0, 'id': id};

//             //           break;
//             //         case MyMoreType.imagePost:
//             //           arguments = {
//             //             'data': {
//             //               'picList': infoData.picList,
//             //               'name': '${infoData.memberName ?? ''}',
//             //               'uicon': '${infoData.memberHeadUrl ?? ''}',
//             //               'description': '${infoData.memberName ?? ''}',
//             //             },
//             //             'type': 1,
//             //             'id': id
//             //           };
//             //           break;
//             //         case MyMoreType.videoPost:
//             //           arguments = {
//             //             'data': {
//             //               'coverUrl': '${infoData.coverUrl}',
//             //               'name': '${infoData.memberName ?? ''}',
//             //               'uicon': '${infoData.memberHeadUrl ?? ''}',
//             //               'description': '${infoData.memberName ?? ''}',
//             //             },
//             //             'type': 2,
//             //             'id': id
//             //           };
//             //           break;

//             //         default:
//             //           break;
//             //       }
//             //       if (arguments != null) {
//             //         Get.back();
//             //         Navigator.pushNamed(context, MyffRoutes.fluttershare,
//             //             arguments: arguments);
//             //       }
//             //     })),
//             // (type == 0 || type == 1 || type == 2) && isMe == false
//             //     ? MyMoreItemWidget(context, 'more_report'.svgAssets(), '举报',
//             //         () {
//             //         if (Get.find<UserGetx>().goIsLogin()) {
//             //           Get.back();
//             //           // Get.to(QuestionIndexPage(
//             //           //   uid: id,
//             //           // ));
//             //         }
//             //       })
//             //     : SizedBox(),
//             (type == MyMoreType.imagePost || type == MyMoreType.videoPost) &&
//                     isMe == true
//                 ? MyMoreItemWidget(context, 'more_del'.svgAssets(), '删除',
//                     () async {
//                     UIUtil.showConfirm('删除此动态?', confirmHandler: () async {
//                       var res = await socialsocialpostdel('$id');
//                       if (res) {
//                         // EventService.eventBus.fire(removePostEvent(id));
//                         Get.back();
//                         Get.back(result: true);
//                       } else {
//                         UIUtil.showToast('删除失败');
//                       }
//                     });
//                   })
//                 : SizedBox(),
//             // (type == MyMoreType.imagePost || type == MyMoreType.videoPost) &&
//             //         isMe == true
//             //     ? MyMoreItemWidget(context, 'more_public'.svgAssets(), '公开',
//             //         () async {
//             //         var res = await socialsocialpostupdatePermissionType('$id');
//             //         if (res != null) {
//             //           var permissionType;
//             //           // if (infoData?.permissionType == 1) {
//             //           permissionType = 0;
//             //           // } else {
//             //           //   permissionType = 1;
//             //           // }
//             //           callBack(permissionType);
//             //           UIUtil.showToast('设置成功');
//             //           Get.back();
//             //         }
//             //       })
//             //     : SizedBox(),
//           ],
//         ),
//         SizedBox(
//           height: 24.w,
//         )
//       ]));
// }

// MyMoreItemWidget(context, icon, name, ontap) {
//   return InkWell(
//       onTap: () {
//         ontap();
//       },
//       child: Container(
//         width: 62.w,
//         margin: EdgeInsets.only(left: 3.w, right: 3.w),
//         // color: Colors.red,
//         child: Column(
//           children: [
//             Container(
//               width: 48.w,
//               height: 48.w,
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(99)),
//               clipBehavior: Clip.antiAlias,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   MyImage(
//                     '$icon',
//                     color: Colors.black,
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7.w,
//             ),
//             Text(
//               '$name'.stringSplit(),
//               style: TextStyle(
//                 // height: 1,
//                 color: Color(0xff4D4D4D),
//                 fontSize: 12.sp,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             )
//           ],
//         ),
//       ));
// }

// void showMyShareDialog(
//   widgetContext,
//   id,
//   data,
//   type,
//   infoData,
// ) {
//   showModal<Null>(
//     context: widgetContext,
//     // barrierDismissible: true,
//     useRootNavigator: true,

//     // barrierColor: Color(0xffffffff),
//     builder: (BuildContext context) {
//       return Scaffold(
//           backgroundColor: Color(0x00ffffff),
//           body: Center(
//             child: SingleChildScrollView(
//                 child: Container(
//                     width: 248.w,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         color: Colors.white),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                               padding:
//                                   EdgeInsets.fromLTRB(16.w, 22.w, 16.w, 0.w),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     '分享给:',
//                                     style: TextStyle(
//                                         fontSize: 17.sp,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff222222)),
//                                   ),
//                                   SizedBox(
//                                     height: 16.w,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: 30.w,
//                                         height: 30.w,
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(99)),
//                                         clipBehavior: Clip.antiAlias,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             MyImage(
//                                               '${data.icon}',
//                                               color: Colors.black,
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10.w,
//                                       ),
//                                       Expanded(
//                                           child: Text(
//                                         '${data.nickname}',
//                                         style: TextStyle(
//                                             fontSize: 15.sp,
//                                             fontWeight: FontWeight.w500,
//                                             color: Color(0xff3A3A3A)),
//                                       ))
//                                     ],
//                                   ),
//                                   Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     margin:
//                                         EdgeInsets.fromLTRB(0, 16.w, 0, 16.w),
//                                     height: 0.5,
//                                     color: Color(0xffEEEEEE),
//                                   ),
//                                   shareDataTypeWidget(
//                                     context,
//                                     type,
//                                     infoData,
//                                   ),
//                                   Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       margin:
//                                           EdgeInsets.fromLTRB(0, 14.w, 0, 16.w),
//                                       padding: EdgeInsets.fromLTRB(
//                                           10.w, 10.w, 10.w, 10.w),
//                                       // height: 30.w,
//                                       constraints: BoxConstraints(
//                                           minHeight: 30.w, maxHeight: 58.w),
//                                       decoration: BoxDecoration(
//                                           color: Color(0xffF9F9F9),
//                                           borderRadius:
//                                               BorderRadius.circular(6)),
//                                       child: TextField(
//                                         autofocus: true,
//                                         cursorColor: Color(0xff111111),
//                                         // cursorColor: Color(0xFFFF5981),
//                                         maxLines: null,
//                                         minLines: null,
//                                         keyboardType: TextInputType.multiline,
//                                         onChanged: (value) {},
//                                         style: TextStyle(
//                                             fontSize: 12.sp,
//                                             color: Color(0xff111111),
//                                             fontWeight: FontWeight.w400),
//                                         decoration: InputDecoration.collapsed(
//                                           fillColor: Colors.red,
//                                           hintText: '给好友留言',
//                                         ),
//                                       )
//                                       //           ))
//                                       // ],
//                                       // )
//                                       ),
//                                 ],
//                               )),
//                           Container(
//                             height: 44.w,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                     child: GestureDetector(
//                                   behavior: HitTestBehavior.opaque,
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 44.w,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                       top: BorderSide(
//                                           width: 1.w, color: Color(0xffEEEEEE)),
//                                     )),
//                                     child: Text(
//                                       '取消',
//                                       style: TextStyle(
//                                           color: Color(0xff111111),
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     Get.back();
//                                   },
//                                 )),
//                                 Expanded(
//                                     child: GestureDetector(
//                                   behavior: HitTestBehavior.opaque,
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 44.w,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             top: BorderSide(
//                                                 width: 1.w,
//                                                 color: Color(0xffEEEEEE)),
//                                             left: BorderSide(
//                                                 width: 1.w,
//                                                 color: Color(0xffEEEEEE)))),
//                                     child: Text(
//                                       '确认',
//                                       style: TextStyle(
//                                           color: Color(0xff111111),
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     // moreShareOnTap(
//                                     //     id, data, type, infoData, textFiled);
//                                   },
//                                 ))
//                               ],
//                             ),
//                           )
//                         ]))),
//           ));
//     },
//   );
// }

// shareDataTypeWidget(
//   context,
//   type,
//   item,
// ) {
//   // type  0 个人主页 1 图文帖子 2视频帖子 3合集 4nft
//   if (type == 0) {
//     return Row(
//       children: [
//         Container(
//             width: 44.w,
//             height: 44.w,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(99)),
//             clipBehavior: Clip.antiAlias,
//             child: MyImage('${item.icon ?? ''}')),
//         SizedBox(
//           width: 10.w,
//         ),
//         Expanded(
//           child: Text(
//             '${item.nickname ?? ''}'.stringSplit(),
//             style: TextStyle(
//                 color: Color(0xff111111),
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600),
//             textAlign: TextAlign.start,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   } else if (type == 1 || type == 2) {
//     return Row(
//       children: [
//         Stack(
//           children: [
//             Container(
//                 width: 60.w,
//                 height: 60.w,
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(6)),
//                 clipBehavior: Clip.antiAlias,
//                 child: MyImage('${item.socialPost.coverUrl ?? ''}')),
//             type == 2
//                 ? Positioned(
//                     top: 20.w,
//                     right: 20.w,
//                     child: Container(
//                       width: 20.w,
//                       height: 20.w,
//                       child: MyImage('video_play'.svgAssets()),
//                     ),
//                   )
//                 : SizedBox()
//           ],
//         ),
//         SizedBox(
//           width: 10.w,
//         ),
//         Expanded(
//             child: Container(
//                 height: 60.w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${item.socialPost.name ?? ''}'.stringSplit(),
//                       style: TextStyle(
//                           color: Color(0xff4D4D4D),
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400),
//                       textAlign: TextAlign.start,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Expanded(child: SizedBox()),
//                     Row(
//                       children: [
//                         Container(
//                             width: 14.w,
//                             height: 14.w,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(99)),
//                             clipBehavior: Clip.antiAlias,
//                             child: MyImage('${item.socialPost.uicon ?? ''}')),
//                         SizedBox(
//                           width: 4.w,
//                         ),
//                         Text(
//                           '${item.socialPost.unickname ?? ''}'.stringSplit(),
//                           style: TextStyle(
//                               color: Color(0xff4D4D4D),
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w400),
//                           textAlign: TextAlign.start,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     )
//                   ],
//                 ))),
//       ],
//     );
//   } else if (type == 3) {
//     //     "title": '${infoData.name}',
//     // "infoId": "${id}",
//     // "token": "${infoData.token}",
//     // "name": "${infoData.name}",
//     // "imageUrl": "${infoData.imageUrl}",
//     // "bannerImageUrl": "${infoData.bannerImageUrl}",
//     // "description": "${infoData.description}"
//     return Row(
//       children: [
//         Container(
//             width: 50.w,
//             height: 50.w,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(63)),
//             clipBehavior: Clip.antiAlias,
//             child: MyImage('${item.imageUrl ?? ''}')),
//         SizedBox(
//           width: 10.w,
//         ),
//         Expanded(
//             child: Container(
//                 height: 60.w,
//                 padding: EdgeInsets.fromLTRB(0, 5.w, 0, 5.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${item.name ?? ''}'.stringSplit(),
//                       style: TextStyle(
//                           color: Color(0xff111111),
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.start,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Expanded(child: SizedBox()),
//                     Row(
//                       children: [
//                         Container(
//                           width: 14.w,
//                           height: 14.w,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 0.5.w, color: Color(0xffEEEEEE)),
//                               borderRadius: BorderRadius.circular(99)),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               MyImage('ETH_blue'.svgAssets()),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 2.w,
//                         ),
//                         Text(
//                           'Ethereum'.stringSplit(),
//                           style: TextStyle(
//                               color: Color(0xff7A7A7A),
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w400),
//                           textAlign: TextAlign.start,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
//                           width: 1.w,
//                           height: 10.w,
//                           color: Color(0xffDDDDDD),
//                         ),
//                         Text(
//                           'ERC-20'.stringSplit(),
//                           style: TextStyle(
//                               color: Color(0xff7A7A7A),
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w400),
//                           textAlign: TextAlign.start,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     )
//                   ],
//                 ))),
//       ],
//     );
//   } else if (type == 4) {
//     // content =
//     //     "{\"title\":\"${infoData.nft.name}\",\"infoId\":\"${id}\",\"token\":\"${infoData.nft.token}\",\"tokenId\":\"${infoData.nft.tokenId}\",\"name\":\"${infoData.nft.name}\",\"image\":\"${infoData.nft.image}\",\"price\":\"${infoData.nft.priceMin}\",\"priceTokenName\":\"eth\"}";
//     return Row(
//       children: [
//         Stack(
//           children: [
//             Container(
//                 width: 60.w,
//                 height: 60.w,
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(6)),
//                 clipBehavior: Clip.antiAlias,
//                 child: MyImage('${item.nft.image ?? ''}')),
//             type == 2
//                 ? Positioned(
//                     top: 20.w,
//                     right: 20.w,
//                     child: Container(
//                       width: 20.w,
//                       height: 20.w,
//                       child: MyImage('video_play'.svgAssets()),
//                     ),
//                   )
//                 : SizedBox()
//           ],
//         ),
//         SizedBox(
//           width: 10.w,
//         ),
//         Expanded(
//             child: Container(
//                 height: 60.w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${item.nft.name ?? ''}'.stringSplit(),
//                       style: TextStyle(
//                           color: Color(0xff111111),
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.start,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Expanded(child: SizedBox()),
//                     Row(
//                       children: [
//                         MyImage(
//                           'ETH_blue'.svgAssets(),
//                           width: 7.5.w,
//                           height: 12.w,
//                           color: Color(0xff4d4d4d),
//                         ),
//                         SizedBox(
//                           width: 3.w,
//                         ),
//                         Text(
//                           '${item.nft.priceMin ?? ''}'.stringSplit(),
//                           style: TextStyle(
//                               color: Color(0xff111111),
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w700),
//                           textAlign: TextAlign.start,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     )
//                   ],
//                 ))),
//       ],
//     );
//   } else {
//     return SizedBox();
//   }
// }
