import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/models/main/main.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

// class CityModel extends ISuspensionBean {
//   String? tagIndex;
//   String? countryname;
//   String? ename;
//   String? areacode;
//   int? islang;
//   String? langname;
//   String? addtime;
//   String? ico;
//   bool? status;

//   CityModel(
//       {this.tagIndex,
//       this.countryname,
//       this.ename,
//       this.areacode,
//       this.islang,
//       this.langname,
//       this.addtime,
//       this.ico,
//       this.status});

//   CityModel.fromJson(Map<String, dynamic> json) {
//     countryname = json['countryname'];
//     ename = json['ename'];
//     areacode = json['areacode'];
//     islang = json['islang'];
//     langname = json['langname'];
//     addtime = json['addtime'];
//     ico = json['ico'];
//     tagIndex = json['tagIndex'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();

//     data['countryname'] = this.countryname;
//     data['ename'] = this.ename;
//     data['areacode'] = this.areacode;
//     data['islang'] = this.islang;
//     data['langname'] = this.langname;
//     data['addtime'] = this.addtime;
//     data['ico'] = this.ico;
//     data['status'] = this.status;
//     data['tagIndex'] = this.tagIndex;
//     return data;
//   }

//   @override
//   String getSuspensionTag() => tagIndex as String;

//   @override
//   String toString() => json.encode(this);
// }

class SearchCountryPage extends StatefulWidget {
  const SearchCountryPage({super.key});

  @override
  _SearchCountryPageState createState() => _SearchCountryPageState();
}

class _SearchCountryPageState extends State<SearchCountryPage> {
  List<CountryList> cityList = [];
  List<CountryList> searchCityList = [];

  MyPageLoadingController loadingController = MyPageLoadingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    if (AreaGetx.to.countryTypeList.isEmpty) {
      await AreaGetx.to.getcountrylist();
      if (AreaGetx.to.countryTypeList.isNotEmpty) {
        loadingController.setSuccess();
      } else {
        loadingController.setEmpty();
      }
    } else {
      loadingController.setSuccess();
    }

    var countryTypeList = AreaGetx.to.countryTypeList;
    cityList.clear();
    cityList = countryTypeList;
    searchCityList = cityList;
    _handleList(searchCityList);
    return;
  }

  void _handleList(List<CountryList> list) {
    if (list.isEmpty) return;

    SuspensionUtil.setShowSuspensionStatus(cityList);
    if (mounted) setState(() {});
  }

  void _searchAction(String data) {
    var text = data.toUpperCase();
    print('_searchAction==$text');
    if (text.isEmpty) {
      searchCityList = cityList;
    } else {
      var tempList = <CountryList>[];
      for (var cityModel in cityList) {
        var name = cityModel.showName ?? '';
        var areaNum = cityModel.dialingCode ?? '';
        if (name.contains(text)) {
          tempList.add(cityModel);
        } else if (areaNum.contains(text)) {
          tempList.add(cityModel);
        }
      }
      print(tempList);
      searchCityList = tempList;
    }
    _handleList(searchCityList);
    if (mounted) setState(() {});
  }

  Widget header() {
    return Container(
      color: Colors.white,
      height: 51.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 36.w,
              decoration: BoxDecoration(
                color: Color(0xffF7F7F7),
                borderRadius: BorderRadius.circular(30.0),
              ),
              // alignment: Alignment.centerRight,
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  MyImage(
                    'default/search'.svgAssets(),
                    width: 16.w,
                    height: 16.w,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                      child: TextField(
                    key: const Key('search_text_field'),
                    onChanged: (val) {
                      _searchAction(val);
                    },
                    textInputAction: TextInputAction.search,
                    style: AppTextStyle.f_13_400,
                    cursorColor: AppColor.color111111,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: LocaleKeys.public11.tr,
                        hintStyle: AppTextStyle.f_13_400.colorABABAB),
                  )),
                  SizedBox(width: 9.w),
                ],
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        child: Scaffold(
            appBar: AppBar(
              leading: Container(),
              title: Text(LocaleKeys.user34.tr.stringSplit()),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                      width: 60.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.public2.tr,
                            style: AppTextStyle.f_14_500.color666666,
                          ),
                        ],
                      )),
                ),
              ],
            ),
            body: MyPageLoading(
              controller: loadingController,
              body: Column(
                children: [
                  header(),
                  Container(
                    height: 6,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: AzListView(
                        data: searchCityList,
                        itemCount: searchCityList.length,
                        itemBuilder: (BuildContext context, int index) {
                          CountryList model = searchCityList[index];
                          return getListItem(context, model);
                        },
                        padding: EdgeInsets.zero,
                        // susItemBuilder: (BuildContext context, int index) {
                        //   CountryList model = searchCityList[index];
                        //   String tag = model.getSuspensionTag();
                        //   return getSusItem(context, tag);
                        // },
                        // indexBarData: ['★', ...kIndexBarData],
                        indexBarData: []),
                  )
                ],
              ),
            )));
  }
}

Widget getSusItem(BuildContext context, String tag, {double susHeight = 40}) {
  if (tag == '★') {
    tag = '★ 热门城市';
  }
  return Container(
    width: MediaQuery.of(context).size.width,
    color: Color(0xffFAFAFA),
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Row(
      children: [
        Container(
          height: susHeight,
          width: MediaQuery.of(context).size.width - 32.w,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1.w, color: Color(0xffEEEEEE)))),
          alignment: Alignment.centerLeft,
          child: Text(
            '$tag',
            softWrap: false,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000000),
            ),
          ),
        )
      ],
    ),
  );
}

Widget getListItem(BuildContext context, CountryList model,
    {double susHeight = 40}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: Container(
        // height: 44.w,
        width: MediaQuery.of(context).size.width,
        margin:
            EdgeInsets.only(left: 16.w, right: 20.w, top: 16.w, bottom: 16.w),
        // color: Color(0xFFF3F4F5),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${model.showName}'.stringSplit(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.color111111,
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              '${model.dialingCode}',
              softWrap: false,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(
                    0xff666666,
                  ),
                  fontWeight: FontWeight.w600),
            ),
          ],
        )),
    onTap: () {
      Get.back(result: model);
    },
  );
}
