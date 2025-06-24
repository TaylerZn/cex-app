
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';

class MyAppBar extends AppBar {
  String myTitle;
  bool showTitle;
  bool? showLeading;
  Widget? leadingWidget;
  Color? background;
  List<Widget>? myAction;
  double? myLeadingWidth;
  bool whiteWidget;
  MyAppBar({Key? key, required this.myTitle, this.myLeadingWidth, this.showTitle = true, this.whiteWidget = false, this.myAction, this.leadingWidget, this.showLeading = true, this.background}) : super(key: key);


   @override
  // TODO: implement leading
  Widget? get leading => leadingWidget ??  Visibility(visible: showLeading ?? false, child: MyPageBackWidget());
  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => background ?? AppColor.colorFFFFFF;

  double? fontSize;

  @override
  // TODO: implement tiMyAppBartle
  Widget? get title => Text(myTitle);// showTitle ? Text(myTitle,style: TNMyTextStyle(fontSize: 18.sp,color: whiteWidget ? ColorUtils.white_color : ColorUtils.title_color,fontWeight: FontWeight.bold)) : null;

  @override
  // TODO: implement actions
  List<Widget>? get actions => myAction;
  @override
  // TODO: implement toolbarHeight
 // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity,50);

  @override
  // TODO: implement centerTitle
  bool? get centerTitle => true;
  @override
  // TODO: implement elevation
  double? get elevation => 0;
  @override
  // TODO: implement leadingWidth
  double? get leadingWidth => myLeadingWidth ?? super.leadingWidth;
}
