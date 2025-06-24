import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_search_textField.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsTransferSearch extends StatelessWidget {
  AssetsTransferSearch({super.key, required this.list});

  final List<AssetSpotsAllCoinMapModel> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: SearchTextField(
                  height: 32,
                  hintText: LocaleKeys.public9.tr,
                )

                    // SizedBox(
                    //     height: 32.h,
                    //     child: TextField(
                    //       controller: TextEditingController(),
                    //       onChanged: (value) {},
                    //       decoration: InputDecoration(
                    //         hintText: '搜索币种/币对/合约',
                    //         hintStyle: TextStyle(
                    //             color: AppColor.colorBBBBBB, fontSize: 16.sp, fontWeight: FontWeight.w500), // 设置 hintText 的文字样式

                    //         prefixIcon: const Icon(
                    //           Icons.search,
                    //           color: AppColor.color111111,
                    //         ),
                    //         suffixIcon: IconButton(
                    //           icon: const Icon(
                    //             Icons.clear,
                    //             color: AppColor.color111111,
                    //           ),
                    //           onPressed: () {},
                    //         ),
                    //         filled: true,
                    //         fillColor: AppColor.colorF4F4F4,
                    //         border: InputBorder.none,
                    //         contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(6),
                    //           borderSide: BorderSide.none,
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(6),
                    //           borderSide: BorderSide.none,
                    //         ),
                    //       ),
                    //       cursorColor: AppColor.color111111,
                    //       textAlignVertical: TextAlignVertical.center,
                    //     )),
                    ),
                SizedBox(width: 16.w),
                InkWell(
                  onTap: () => Get.back(),
                  child: Text(
                    LocaleKeys.public2.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final e = list[index];
            return InkWell(
              onTap: () {
                Get.back(result: e);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 24.h, 14, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyImage(
                      'currency/usdt'.svgAssets(),
                      width: 34.r,
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.coinName ?? '',
                          style: TextStyle(
                            color: AppColor.color111111,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(e.exchangeSymbol ?? '',
                            style: TextStyle(
                              color: AppColor.color999999,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                    const Spacer(),
                    Text(e.allBalance ?? '',
                        style: TextStyle(
                          color: AppColor.color111111,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ))
                  ],
                ),
              ),
            );
          },
        ));
  }
}
