import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/community.dart';
import 'package:nt_app_flutter/app/enums/file_upload.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/community/hot_topic.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/main_tab/widgets/home_buttom_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';

class MyCommunityUtil {
  static RxBool showSocialMenu = false.obs;
  static GlobalKey<HomeButtonWidgetState> homeButton = GlobalKey();
  static String? socialMenu;

  static Future<void> jumpToTopicDetail(TopicdetailModel? model) async {
    if (model?.type == CommunityFileTypeEnum.VIDEO) {
      await Get.toNamed(Routes.COMMUNITY_VIDEO_INFO,
          arguments: {'topicNo': model?.topicNo, 'data': model},
          preventDuplicates: false);
    } else {
      await Get.toNamed(Routes.COMMUNITY_INFO,
          arguments: {'topicNo': model?.topicNo, 'data': model},
          preventDuplicates: false);
    }
  }

  static pushToUserInfo(num? memberId) {
    // var model = FollowKolInfo()..uid = memberId ?? 0;
    Get.toNamed(Routes.FOLLOW_TAKER_INFO,
        arguments: {'uid': memberId ?? 0}, preventDuplicates: false);
  }

// 帖子内容转换成所需格式
  static RichText specialStringtToWidget(
      String content, SpecialContentEnum specialType,
      {TextStyle? textStyle,
      TextStyle? specialTextStyle,
      bool maxLines = true,
      int? lines = 6}) {
    // 识别三种格式的正则表达式
    RegExp atRegex = RegExp(r'\[25738CEBDAC49C49\{([^|]+)\|([^\}]+)\}\]');
    RegExp coinRegex = RegExp(r'\[0f250d4882f9ebb9\{([^|]+)\|([^\}]+)\}\]');
    RegExp topicRegex = RegExp(r'#(\S{1,64})\s');

    List<InlineSpan> textspanList = [];

    // 处理文本中的每一个部分
    content.splitMapJoin(
      atRegex,
      onMatch: (Match match) {
        String name = match.group(1) ?? '';
        String id = match.group(2) ?? '';
        textspanList.add(TextSpan(
          text: '@$name ',
          style: specialTextStyle ?? AppTextStyle.f_15_400,
          recognizer: specialType == SpecialContentEnum.postTitle
              ? null
              : TapGestureRecognizer()
            ?..onTap = () {
              print('艾特ID: $id');
              // var model = FollowKolInfo()..uid = num.parse(id);
              // Get.toNamed(Routes.FOLLOW_TAKER_INFO,
              //     arguments: {'model': model});
              pushToUserInfo(num.parse(id));
            },
        ));
        return '';
      },
      onNonMatch: (String text) {
        text.splitMapJoin(
          coinRegex,
          onMatch: (Match match) {
            String id = match.group(2) ?? '';
            ContractInfo? postCoinData = CommodityDataStoreController.to
                .getContractInfoByContractId(num.parse(id));
            textspanList.add(TextSpan(
              text: '${postCoinData?.firstName}${postCoinData?.secondName} ',
              style: specialTextStyle ?? AppTextStyle.f_15_400,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('币种ID: $id');

                  ContractInfo? contractInfo = CommodityDataStoreController.to
                      .getContractInfoByContractId(num.parse(id));
                  if (contractInfo != null) {
                    goToCommodityKline(contractInfo: contractInfo);
                  }
                },
            ));
            return '';
          },
          onNonMatch: (String text) {
            text.splitMapJoin(
              topicRegex,
              onMatch: (Match match) {
                String topic = match.group(1) ?? '';
                textspanList.add(TextSpan(
                  text: '#$topic ',
                  style: specialTextStyle ?? AppTextStyle.f_15_400,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('话题: $topic');
                      var a = HotTopicModel(name: topic);
                      RouteUtil.goTo(Routes.HOT_DETAIL_TOPIC,
                          parameters: {'data': topic});

                      print(a.toJson());
                      // return;

                      // Get.toNamed(Routes.HOT_DETAIL_TOPIC,
                      //     arguments: {'model': HotTopicModel(name: topic)});
                    },
                ));
                return '';
              },
              onNonMatch: (String text) {
                textspanList.add(TextSpan(
                  text: text,
                  style: textStyle ?? AppTextStyle.f_15_400,
                ));
                return '';
              },
            );
            return '';
          },
        );
        return '';
      },
    );
    if (!maxLines) {
      return RichText(text: TextSpan(children: textspanList));
    }
    return RichText(
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: textspanList),
    );
  }

// 帖子内容恢复正常格式
  static String specialStringtToCommonString(String content) {
    String text = content;

    // 识别三种格式的正则表达式
    RegExp atRegex = RegExp(r'\[25738CEBDAC49C49\{([^|]+)\|([^\}]+)\}\]');
    RegExp coinRegex = RegExp(r'\[0f250d4882f9ebb9\{([^|]+)\|([^\}]+)\}\]');
    RegExp topicRegex = RegExp(r'#(\S{1,64})\s');

    // 替换艾特内容为对应的文本
    text = text.replaceAllMapped(atRegex, (Match match) {
      String name = match.group(1) ?? '';
      return '@$name';
    });

    // 替换币种内容为对应的文本
    text = text.replaceAllMapped(coinRegex, (Match match) {
      String id = match.group(2) ?? '';
      ContractInfo? postCoinData = CommodityDataStoreController.to
          .getContractInfoByContractId(num.parse(id));
      return '${postCoinData?.firstName}${postCoinData?.secondName}';
    });

    // 替换话题内容为对应的文本
    text = text.replaceAllMapped(topicRegex, (Match match) {
      String topic = match.group(1) ?? '';
      return '#$topic';
    });

    return text;
  }
}
