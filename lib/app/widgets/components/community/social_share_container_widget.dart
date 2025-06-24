import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

import '../../../config/theme/app_color.dart';
import '../../../getX/links_Getx.dart';
import '../../../utils/utilities/copy_util.dart';
import '../../../utils/utilities/share_helper_util.dart';
import '../../../utils/utilities/url_util.dart';
import '../../basic/my_image.dart';

class SocialShareContainerWidget extends StatelessWidget {
  final dynamic widgetData; // 替换为你实际使用的数据类型

  const SocialShareContainerWidget({super.key, required this.widgetData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAnyAppInstalled(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data == true) {
          return _buildSocialButtons(context);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return FutureBuilder<List<bool>>(
      future: Future.wait([
        isAppInstalled('org.telegram.messenger', urlScheme: 'tg://'),
        isAppInstalled('com.whatsapp', urlScheme: 'whatsapp://'),
        isAppInstalled('com.twitter.android', urlScheme: 'twitter://')
      ]),
      builder: (context, appSnapshot) {
        if (appSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (appSnapshot.hasError) {
          return Text('Error: ${appSnapshot.error}');
        } else if (appSnapshot.hasData && appSnapshot.data!.contains(true)) {
          final bool isTelegramInstalled = appSnapshot.data![0];
          final bool isWhatsappInstalled = appSnapshot.data![1];
          final bool isXInstalled = appSnapshot.data![2];

          return Wrap(
            spacing: 20.w,
            children: [
              if (isTelegramInstalled)
                _buildShareButton(
                  onTap: () {
                    String uri =
                        'tg://msg?text=${LinksGetx.to.topicUrl}${widgetData?.topicNo}';
                    MyUrlUtil.openUrl(uri);
                    recordShareData(widgetData?.topicNo ?? '');
                  },
                  iconPath: 'community/share_tg'.svgAssets(),
                ),
              if (isWhatsappInstalled)
                _buildShareButton(
                  onTap: () {
                    String uri =
                        'whatsapp://send?text=${LinksGetx.to.topicUrl}${widgetData?.topicNo}';
                    MyUrlUtil.openUrl(uri);
                    recordShareData(widgetData?.topicNo ?? '');
                  },
                  iconPath: 'community/share_whatapp'.svgAssets(),
                ),
              if (isXInstalled)
                _buildShareButton(
                  onTap: () {
                    String uri =
                        'twitter://post?message=${LinksGetx.to.topicUrl}${widgetData?.topicNo}';
                    MyUrlUtil.openUrl(uri);
                    recordShareData(widgetData?.topicNo ?? '');
                  },
                  iconPath: 'community/share_x'.svgAssets(),
                ),
              _buildShareButton(
                onTap: () {
                  String uri = '${LinksGetx.to.topicUrl}${widgetData?.topicNo}';
                  CopyUtil.copyText(uri);
                  recordShareData(widgetData?.topicNo ?? '');
                },
                iconPath: 'community/share_copy'.svgAssets(),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildShareButton({
    required VoidCallback onTap,
    required String iconPath,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 37.w,
        height: 37.w,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.colorBorderSubtle),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: MyImage(
            iconPath,
            width: 19.w,
          ),
        ),
      ),
    );
  }
}
