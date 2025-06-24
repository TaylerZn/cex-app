// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:lottie/lottie.dart';
// import 'package:nt_app_flutter/app/api/community/community_interface.dart';
// import 'package:nt_app_flutter/app/getX/user_Getx.dart';
// import 'package:nt_app_flutter/app/models/community/community.dart';
// import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_list.dart';
// import 'package:nt_app_flutter/app/routes/app_pages.dart';
// import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
// import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
// import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
// import 'package:nt_app_flutter/app/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
// import 'package:nt_app_flutter/app/widgets/components/community/post_list_widget.dart';
// import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:loading_more_list/loading_more_list.dart';
// import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';

// class CommunityChildPage extends StatefulWidget {
//   final num? uid;
//   const CommunityChildPage({super.key, this.uid});

//   @override
//   _CommunityChildPageState createState() => _CommunityChildPageState();
// }

// class _CommunityChildPageState extends State<CommunityChildPage>
//     with TickerProviderStateMixin {
//   final RefreshController _refreshController = RefreshController();
//   MyPageLoadingController loadingController = MyPageLoadingController();
//   List<TopicdetailModel> recommendList = [];
//   int recommendPages = 1;
//   int recommendTotalPages = 1;
//   Timer? resendTimer;
//   late final AnimationController _controller;
//   LottieComposition? _composition;

//   bool isSendExpand = false;
//   double bottom = 0;

//   @override
//   void initState() {
//     _loadLottieComposition();
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1))
//           ..addListener(() {
//             // if (_controller.isCompleted) {
//             //   _controller.animateTo(0.1);
//             // }
//           });
//     addCommunityListen();

//     getData();
//     super.initState();
//   }

//   Future<void> _loadLottieComposition() async {
//     final bytes = await DefaultAssetBundle.of(context)
//         .load('assets/json/community/send.json');
//     final composition =
//         await LottieComposition.fromBytes(bytes.buffer.asUint8List());
//     setState(() {
//       _composition = composition;
//       _controller.duration = _composition?.duration;
//     });
//   }

//   void _playAnimation(int startFrame, int endFrame) {
//     if (_composition == null) return;
//     final frameCount = _composition!.endFrame - _composition!.startFrame;
//     final startProgress = startFrame / frameCount;
//     final endProgress = endFrame / frameCount;
//     _controller.animateTo(
//       endProgress,
//       duration: Duration(
//           milliseconds: ((endProgress - startProgress) *
//                   _composition!.duration.inMilliseconds)
//               .round()),
//       curve: Curves.linear,
//     );
//   }

//   getData() {
//     getTuiJianList();
//   }

//   getTuiJianList() async {
//     List<TopicdetailModel> list;
//     if (recommendPages == 1) {
//       list = [];
//     } else {
//       list = recommendList;
//     }
//     var res =
//         await topicpageList('$recommendPages', '10', '', '${widget.uid ?? ''}');

//     if (res != null) {
//       for (var i = 0; i < res.data!.length; i++) {
//         var item = TopicdetailModel.fromJson(res.data![i]);
//         List<CommunityCommentItem> oneLevelList = [];

//         list.add(item);
//       }
//       recommendList = list;
//       recommendTotalPages = res.totalPage;
//       loadingController.setSuccess();
//     }
//     if (recommendList.isEmpty) {
//       loadingController.setEmpty();
//     }
//     if (mounted) setState(() {});
//   }

//   // 监听社区事件
//   addCommunityListen() {
//     Bus.getInstance().on(EventType.blockUser, (data) {
//       recommendList.removeWhere((item) => item.memberId == data);
//       setState(() {});
//     });
//     Bus.getInstance().on(EventType.delPost, (data) {
//       recommendList.removeWhere((item) => item.id == data);
//       setState(() {});
//     });
//     Bus.getInstance().on(EventType.postUpdate, (data) {
//       int index = recommendList.indexWhere((item) => item.id == data.id);
//       if (index != -1) {
//         recommendList[index] = data;
//       }
//       setState(() {});
//     });
//   }

//   // 监听社区事件
//   removeCommunityListen() {
//     Bus.getInstance().off(EventType.blockUser, (data) {});
//     Bus.getInstance().off(EventType.delPost, (data) {});
//   }

//   @override
//   void dispose() {
//     removeCommunityListen();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: UserGetx.to.isKol && widget.uid == null
//             ? Stack(
//                 children: [
//                   Positioned(
//                     bottom: 20.h,
//                     left: 0,
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 400),
//                       height: isSendExpand ? 132.h : 0,
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                               },
//                               child: Container(
//                                 width: 40.h,
//                                 height: 40.h,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10.r)),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     MyImage(
//                                       'community/my'.svgAssets(),
//                                       width: 20.w,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             16.verticalSpace,
//                             InkWell(
//                                 onTap: () {
//                                   Get.toNamed(Routes.COMMUNITY_POST);
//                                 },
//                                 child: Container(
//                                   width: 40.h,
//                                   height: 40.h,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius:
//                                           BorderRadius.circular(10.r)),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       MyImage(
//                                         'community/send'.svgAssets(),
//                                         width: 20.w,
//                                       )
//                                     ],
//                                   ),
//                                 )),
//                             16.verticalSpace,
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       const Spacer(),
//                       InkWell(
//                         onTap: () {
//                           isSendExpand = !isSendExpand;
//                           if (isSendExpand) {
//                             _playAnimation(1, 40);
//                           } else {
//                             _playAnimation(60, 90);
//                           }
//                           setState(() {});
//                         },
//                         child: _composition == null
//                             ? const SizedBox()
//                             : Lottie(
//                                 width: 40.w,
//                                 height: 40.w,
//                                 composition: _composition,
//                                 controller: _controller,
//                               ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             : 0.horizontalSpace,
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//         body: MyPageLoading(
//             controller: loadingController,
//             onEmpty: noDataWidget(context, wigetHeight: 400.w),
//             body: SmartRefresher(
//                 primary: false,
//                 controller: _refreshController,
//                 enablePullDown: true,
//                 enablePullUp: true,
//                 onRefresh: () async {
//                   recommendPages = 1;
//                   recommendTotalPages = 1;
//                   getTuiJianList();
//                   _refreshController.refreshCompleted();
//                   _refreshController.loadComplete();
//                 },
//                 onLoading: () async {
//                   if (recommendTotalPages <= recommendPages) {
//                     _refreshController.loadNoData();
//                   } else {
//                     recommendPages = recommendPages + 1;
//                     await getTuiJianList();

//                     _refreshController.loadComplete();
//                   }
//                 },
//                 child: WaterfallFlow.builder(
//                   padding: const EdgeInsets.all(0),
//                   itemCount: recommendList.length,
//                   gridDelegate:
//                       SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 1,
//                     crossAxisSpacing: 0.w,
//                     mainAxisSpacing: 0.h,
//                   ),
//                   itemBuilder: (context, i) {
//                     return postListWidget(context, recommendList[i]);
//                   },
//                 ))));
//   }
// }
