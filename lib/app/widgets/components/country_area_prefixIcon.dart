import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/models/main/main.dart';
import 'package:nt_app_flutter/app/modules/login/widgets/Search_Country_Page.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class CountryAreaPrefixIconWidget extends StatefulWidget {
  const CountryAreaPrefixIconWidget({Key? key}) : super(key: key);

  @override
  State<CountryAreaPrefixIconWidget> createState() =>
      _CountryAreaPrefixIconWidgetState();
}

class _CountryAreaPrefixIconWidgetState
    extends State<CountryAreaPrefixIconWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AreaGetx>(builder: (areaGetx) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const SearchCountryPage();
          })).then((value) {
            if (value != null && value is CountryList) {
              if (value.numberCode != null) {
                areaGetx.setSP(value.dialingCode);
                setState(() {});
              }
            }
          });
        },
        child: SizedBox(
          width: 40.w + (areaGetx.areaCode.length * 10.w),
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              Text(
                areaGetx.areaCode,
                style: TextStyle(
                    color: AppColor.color111111,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              MyImage(
                'default/arrow_bottom'.svgAssets(),
                width: 16.w,
              ),
              const Expanded(child: SizedBox()),
              Container(
                width: 1.w,
                height: 12.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColor.colorBBBBBB,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ),
      );
    });
  }
}
