import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ExchangeRateView extends StatefulWidget {
  const ExchangeRateView({super.key});

  @override
  _ExchangeRateViewState createState() => _ExchangeRateViewState();
}

class _ExchangeRateViewState extends State<ExchangeRateView> {
  List<MarketInfoRateModel> rateList = [];
  List<MarketInfoRateModel> searchCityList = [];
  MyPageLoadingController loadingController = MyPageLoadingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    if (AssetsGetx.to.rateList.isEmpty) {
      await SpotDataStoreController.to.getPublicInfoMarket();
      if (AssetsGetx.to.rateList.isNotEmpty) {
        loadingController.setSuccess();
      } else {
        loadingController.setEmpty();
      }
    } else {
      loadingController.setSuccess();
    }
    var countryTypeList = AssetsGetx.to.rateList;

    rateList.clear();
    for (var i = 0; i < countryTypeList.length; i++) {
      String tag = countryTypeList[i].langCoin!.substring(0, 1).toUpperCase();
      countryTypeList[i].tagIndex = tag;
    }
    rateList = countryTypeList;
    searchCityList = rateList;
    _handleList(searchCityList);
    return;
  }

  void _handleList(List<MarketInfoRateModel> list) {
    if (list.isEmpty) return;

    SuspensionUtil.setShowSuspensionStatus(rateList);
    if (mounted) setState(() {});
  }

  void _searchAction(String data) {
    var text = data.toUpperCase();
    print('_searchAction==$text');
    if (text.isEmpty) {
      searchCityList = rateList;
    } else {
      var tempList = <MarketInfoRateModel>[];
      for (var cityModel in rateList) {
        var name = cityModel.langCoin ?? '';
        var areaNum = cityModel.langCoin ?? '';
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
        height: 36.w,
        decoration: BoxDecoration(
          color: AppColor.colorF5F5F5,
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24.w),
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
              // readOnly: true,
              key: Key('search_text_field'),
              onChanged: (val) {
                _searchAction(val);
              },
              textInputAction: TextInputAction.search,
              style: TextStyle(fontSize: 12.sp),
              cursorColor: AppColor.color111111,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                disabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: LocaleKeys.user189.tr,
                hintStyle:
                    AppTextStyle.f_12_400.colorBBBBBB.copyWith(height: 1),
              ),
            )),
            SizedBox(width: 9.w),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        child: Scaffold(
            appBar: AppBar(
              leading: const MyPageBackWidget(),
            ),
            body: MyPageLoading(
              controller: loadingController,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.user190.tr,
                          style: AppTextStyle.f_24_600,
                        ),
                        4.verticalSpace,
                        Text(
                          LocaleKeys.user191.tr,
                          style: AppTextStyle.f_12_400.color999999,
                        )
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  header(),
                  Expanded(
                    child: AzListView(
                        data: searchCityList,
                        itemCount: searchCityList.length,
                        itemBuilder: (BuildContext context, int index) {
                          MarketInfoRateModel model = searchCityList[index];
                          return getListItem(context, index, model);
                        },
                        padding: EdgeInsets.zero,
                        // susItemBuilder: (BuildContext context, int index) {
                        //   MarketInfoRateModel model = searchCityList[index];
                        //   String tag = model.getSuspensionTag();
                        //   return getSusItem(context, tag);
                        // },
                        // indexBarData: const [...kIndexBarData],
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

Widget getListItem(BuildContext context, int index, MarketInfoRateModel model,
    {double susHeight = 40}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(left: 24.w, right: 24.w, top: 16.w, bottom: 16.w),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${model.langCoin}'.stringSplit(),
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
            GetBuilder<AssetsGetx>(builder: (assetsGetx) {
              return assetsGetx.currentRate?.langCoin == model.langCoin
                  ? MyImage(
                      'default/selected'.svgAssets(),
                      width: 16.w,
                    )
                  : SizedBox();
            })
          ],
        )),
    onTap: () {
      int modelIndex = AssetsGetx.to.rateList
          .indexWhere((element) => element.langCoin == model.langCoin);
      if (modelIndex != -1) {
        AssetsGetx.to.rateCurrentIndex = modelIndex;
      } else {
        AssetsGetx.to.rateCurrentIndex = index;
      }
      AssetsGetx.to.update();
      Get.back();
    },
  );
}
