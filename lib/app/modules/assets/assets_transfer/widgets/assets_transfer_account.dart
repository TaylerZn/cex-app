import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_transfer/enums/account_enums.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_transfer/models/account_enums.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsTransferAccount extends StatelessWidget {
  AssetsTransferAccount(
      {super.key,
      required this.type,
      required this.current,
      required this.other,
      required this.array});

  AssetsTransferAccountEnum type;
  final int current;
  final int other;

  final List<AssetsTransferItemModel> array;
  final List<AssetsTransferItemModel> currentaArray = [];

  List<AssetsTransferItemModel> filterListBySupportedIds(List<int> ids) {
    return array.where((item) {
      if (ids.contains(item.id)) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (type == AssetsTransferAccountEnum.to) {
      var item = array[other].supportIdList;
      List<AssetsTransferItemModel> filteredList =
          filterListBySupportedIds(item);
      currentaArray.addAll(filteredList);
    } else {
      currentaArray.addAll(array);
    }

    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          title: Text(LocaleKeys.assets83.tr),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: currentaArray.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 30.h),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, array.indexOf(currentaArray[index]));
                },
                child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: (Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentaArray[index].name,
                            style: AppTextStyle.f_15_600.color111111),
                        currentaArray[index] == array[current]
                            ? MyImage(
                                'assets/assets_check'.svgAssets(),
                                width: 18.r,
                              )
                            : const SizedBox()
                      ],
                    ))),
              ),
            );
          },
        ));
  }
}
