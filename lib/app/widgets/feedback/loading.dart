import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class MyLoading extends Dialog {
  final String msg;

  const MyLoading({
    super.key,
    this.msg = '',
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitCircle(
              color: Colors.white,
              size: 40.sp,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              msg,
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
