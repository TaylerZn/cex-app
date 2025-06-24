import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/interest.dart';
import 'package:nt_app_flutter/app/modules/community/widget/follow_widget.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_appbar_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/interested_list_controller.dart';

class InterestedListView extends GetView<InterestedListController> {
  const InterestedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<InterestPeopleListModel?>? list = Get.arguments?['data'];

    return Scaffold(
        appBar: MyAppBar(myTitle: LocaleKeys.community38.tr),
        body: GetBuilder<InterestedListController>(builder: (controller) {
          return ListView.separated(
              itemCount: list?.length ?? 0,
              separatorBuilder: (_, __) => Container(
                    color: AppColor.colorBorderGutter,
                    height: 1.w,
                    width: double.infinity,
                  ),
              itemBuilder: (context, index) {
                InterestPeopleListModel? item = list?[index];
                return InkWell(
                    onTap: () {
                      MyCommunityUtil.pushToUserInfo(item?.uid);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserAvatar(
                            item?.pictureUrl,
                            width: 34.w,
                            height: 34.w,
                            levelType: item?.levelType,
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              item?.nickName ?? '--',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyle.f_14_500,
                                            ),
                                            8.verticalSpace,
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1.w),
                                              child: MyImage(
                                                item?.flagIcon ?? '',
                                                width: 16.w,
                                                height: 12.w,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(1.w),
                                                child: MyImage(
                                                  item?.organizationIcon ?? '',
                                                  width: 12.w,
                                                  height: 12.w,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        6.verticalSpaceFromWidth,
                                        followerFansWidget(item),
                                      ],
                                    ),
                                    FollowWidget(
                                        isFollow: item?.followStatus == 1,
                                        onTap: () async {
                                          TopicdetailModel model =
                                              TopicdetailModel(
                                                  memberId: item?.uid,
                                                  focusOn:
                                                      item?.followStatus == 1);
                                          if (await socialsocialfollowfollow(
                                              model)) {
                                            item?.followStatus =
                                                item.followStatus == 0 ? 1 : 0;
                                            controller.update();
                                          }
                                        })
                                  ],
                                ),
                                //todo white 身份描述
                                Row(
                                  children: [
                                    Visibility(
                                        visible: ObjectUtil.isNotEmpty(
                                            item?.tradingStyleStr),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 6.w),
                                          child: Container(
                                              height: 15.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColor
                                                      .colorFunctionTradingYel,
                                                  width: 0.6.w,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(3.w),
                                              ),
                                              padding: EdgeInsets.only(
                                                  left: 4.w,
                                                  top: 1.w,
                                                  right: 4.w),
                                              child: Text(
                                                '${item?.tradingStyleStr}',
                                                style: AppTextStyle.f_9_500
                                                    .colorFunctionTradingYel,
                                              )),
                                        )),
                                    Visibility(
                                        visible: ObjectUtil.isNotEmpty(
                                            item?.identityDesc),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 6.w),
                                          child: Container(
                                              height: 15.w,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColor.colorFunctionBuy
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(3.w),
                                              ),
                                              padding: EdgeInsets.only(
                                                  left: 4.w,
                                                  top: 1.w,
                                                  right: 4.w),
                                              child: Text(
                                                '${item?.identityDesc}',
                                                style: AppTextStyle
                                                    .f_9_500.colorFunctionBuy
                                                    .copyWith(wordSpacing: 0),
                                              )),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Text(
                                    item?.signatureInfo ?? '--',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle
                                        .f_12_400.colorTextDescription,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
              });
        }));
  }

  Row followerFansWidget(InterestPeopleListModel? item) {
    return Row(
      children: [
        Row(
          children: [
            Text('${item?.focusNum} ',
                style: AppTextStyle.f_12_600.colorTextPrimary),
            4.horizontalSpace,
            Text(LocaleKeys.community111.tr,
                style: AppTextStyle.f_12_400.colorTextTips),
          ],
        ),
        16.horizontalSpace,
        Row(
          children: [
            Text('${item?.fanNum} ',
                style: AppTextStyle.f_12_600.colorTextPrimary),
            Text(LocaleKeys.community109.tr,
                style: AppTextStyle.f_12_400.colorTextTips),
          ],
        )
      ],
    );
  }
}
