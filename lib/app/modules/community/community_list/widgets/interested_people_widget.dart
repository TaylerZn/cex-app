import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community_interface.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/interest.dart';
import 'package:nt_app_flutter/app/modules/community/widget/follow_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class InterestedPeopleWidget extends StatefulWidget {
  const InterestedPeopleWidget({super.key, required this.list});

  final List<InterestPeopleListModel?> list;

  @override
  State<InterestedPeopleWidget> createState() => _InterestedPeopleWidgetState();
}

class _InterestedPeopleWidgetState extends State<InterestedPeopleWidget> {
  late List<InterestPeopleListModel?> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.w),
        decoration: const BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: AppColor.colorBorderGutter))),
        child: Column(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                await Get.toNamed(Routes.INTERESTED_LIST,
                    arguments: {'data': list});
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    LocaleKeys.community38.tr,
                    style: AppTextStyle.f_16_600.colorTextPrimary,
                  ),
                  MyImage('community/arrow_forward_ios'.svgAssets(),
                      width: 14.w)
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: list.length > 3 ? 3 : list.length,
              itemBuilder: (context, index) {
                InterestPeopleListModel? item = list[index];
                return InkWell(
                    onTap: () {
                      MyCommunityUtil.pushToUserInfo(item?.uid);
                    },
                    child: Column(
                      children: [
                        16.verticalSpaceFromWidth,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    UserAvatar(
                                      item?.pictureUrl,
                                      width: 34.w,
                                      height: 34.w,
                                      levelType: item?.levelType,
                                    ),
                                    8.w.horizontalSpace,
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item?.nickName ?? '--',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle
                                              .f_14_500.colorTextPrimary,
                                        ),
                                        2.verticalSpaceFromWidth,
                                        Text(
                                          item?.signatureInfo ?? '--',                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle
                                              .f_11_400.colorTextDescription,
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              8.horizontalSpace,
                              if (item?.followStatus != 1)
                                FollowWidget(
                                    isFollow: item?.followStatus == 1,
                                    onTap: () async {
                                      TopicdetailModel model = TopicdetailModel(
                                          memberId: item?.uid,
                                          focusOn: item?.followStatus == 1);
                                      if (await socialsocialfollowfollow(
                                          model)) {
                                        setState(() {
                                          item?.followStatus =
                                              item.followStatus == 0 ? 1 : 0;
                                        });
                                      }
                                    })
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ],
        ));
  }
}
