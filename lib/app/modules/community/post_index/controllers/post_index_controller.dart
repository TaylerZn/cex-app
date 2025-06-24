import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/index.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/getX/videoEditor_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/community/focus.dart';
import 'package:nt_app_flutter/app/models/community/hot_topic.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/post_quote_widget.dart';
import 'package:nt_app_flutter/app/modules/community/enum.dart';
import 'package:nt_app_flutter/app/modules/community/post_index/widgets/coin_kchat_widget.dart';
import 'package:nt_app_flutter/app/modules/community/post_index/widgets/post_editor_tool_widget.dart';
import 'package:nt_app_flutter/app/modules/community/post_index/widgets/timer_picker_page.dart';
import 'package:nt_app_flutter/app/modules/community/video_editor_set_cover_page.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/community/text/my_special_text_span_builder.dart';
import 'package:nt_app_flutter/app/widgets/components/post_image_editor/post_image_editor.dart';
import 'package:nt_app_flutter/app/widgets/components/post_image_editor/post_image_editor_logic.dart';
import 'package:nt_app_flutter/app/widgets/dialog/post_status_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../models/communit_referenc_card_model.dart';

enum PostShowTypeEnum {
  public,
  at,
  topic,
}

enum PostFocusNodeType {
  title,
  content,
}

class PostIndexController extends GetxController
    with GetTickerProviderStateMixin, WidgetsBindingObserver {
  var videoFile = Rx<AssetEntity?>(null);
  var videoCoverFile = Rx<File?>(null);
  PostEditorTooType postType = PostEditorTooType.smooth;
  RxBool isScheduled = false.obs;
  RxBool isVideo = false.obs;
  Rx<DateTime> publishTime = DateTime.now().obs;
  Rx<TextEditingController> titleControll = TextEditingController().obs;
  RxList<String> voteList = <String>[].obs;
  RxList<ContractInfo> symbolList = <ContractInfo>[].obs;
  List<String> symbolMatchedStringsList = [];
  String? quoteId;
  RxInt titleLength = 0.obs;
  FocusNode titleFocusNode = FocusNode();
  Rx<TextEditingController> contentControll = TextEditingController().obs;
  RxInt contentLength = 0.obs;
  FocusNode contentFocusNode = FocusNode();
  RxList<Widget> childWidget = <Widget>[].obs;
  RxList<PostChildWrapper> itemList = <PostChildWrapper>[].obs;

  RxInt titleMin = 3.obs;
  RxInt titleMax = 100.obs;
  RxInt contentMin = 10.obs;
  RxInt contentMax = 4000.obs;
  RxList<AssetEntity> picDefaultList = <AssetEntity>[].obs;
  RxList<EditImageModel> picList = <EditImageModel>[].obs;
  RxInt selectIndex = 1.obs;
  RxDouble KeyboardHeight = 0.0.obs;
  RxBool isShowScheduled = false.obs;
  RxInt votingDeadline = 1.obs;

  bool get allowKline => symbolList.length < 3;
  //特殊TextSpan

  MySpecialTextSpanBuilder contentSpecialTextSpanBuilder =
      MySpecialTextSpanBuilder(
          showAtBackground: false,
          defaultTextStyle: AppTextStyle.f_14_400.tradingYel);

  Rx<PostShowTypeEnum> bottomShowType = PostShowTypeEnum.public.obs;
  RxList<TopicFocusListModel> focusList = <TopicFocusListModel>[
    TopicFocusListModel(nickName: '测试短-At文本-名字欧诺斯两三块死你的课看娜姐啊撒大声地绿色', uid: 11),
    TopicFocusListModel(nickName: '测试-At文本-名字欧诺斯', uid: 11),
    TopicFocusListModel(nickName: '测试-At文本-1', uid: 11),
    TopicFocusListModel(nickName: '测试-At文本-名字欧诺斯两三块死你的课看娜姐啊撒大声地绿色', uid: 11)
  ].obs;
  RxList<HotTopicModel> topicList = <HotTopicModel>[].obs;

  //是否展示媒体文件选择框
  RxBool isShowMediaFiles = false.obs;

  List<ContractInfo> contractInfoList = [];

  //引用卡片模型
  Rx<CommunityReferenceCardModel?> cardmodel =
      Rx<CommunityReferenceCardModel?>(null);

  //是否有引用
  RxBool isReference = false.obs;

  //上一次点击的输入框
  Rx<PostFocusNodeType> lastTimeFocused = PostFocusNodeType.content.obs;

  @override
  void onInit() {
    if (ObjectUtil.isNotEmpty(Get.arguments?['quoteId'])) {
      itemList.add(PostChildWrapper(
          type: PostChild.quote,
          widget: PostQuoteWidget(quoteId: Get.arguments?['quoteId'])));
    }
    //防止有新#或@后不更新文本长度问题，使用控制器监听，不使用onChanged
    contentControll.value.addListener(() {
      contentLength.value = contentControll.value.text.length;
      validateText(contentControll);
      //   addCoinGraph(contentControll.value.text);
    });
    titleControll.value.addListener(() {
      titleLength.value = titleControll.value.text.length;
    });
    titleFocusNode.addListener(() {
      closeTags();
    });

    contentFocusNode.addListener(() {
      lastTimeFocused.value = PostFocusNodeType.content;
    });

    //检查是否引用
    loadQuoteContent();

    getFocusList(null);
    topicTalkingPointList(null); // 热门话题
    fetchReferceCard();
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  void clearCoinMarket() {
    List<PostChildWrapper?> list =
        itemList.where((element) => element.type == PostChild.graph).toList();
    list.forEach((element) {
      itemList.remove(element);
    });
  }

  void showTimeDialog(bool stat) {
    isScheduled.value = stat;
    publishTime.value = DateTime.now().add(Duration(minutes: 30));

    if (stat) {
      showModalBottomSheet(
          context: Get.context!,
          isDismissible: false,
          builder: (builder) {
            return TimePickerPage(onCancel: () {
              isScheduled.value = false;
            }, tapTime: (time) {
              publishTime.value = time;
            });
          });
    } else {
      publishTime.value = DateTime.now();
    }
  }

  void addItem(List<PostChildWrapper> list) {
    itemList.addAll(list);
    itemList.sort((a, b) => a.type!.index.compareTo(b.type!.index));
  }

  void removeItemList(String tag) {
    if (tag == 'vote') {
      voteList.clear();
    }
    PostChildWrapper wrapper =
        itemList.firstWhere((element) => element.tag == tag);
    itemList.remove(wrapper);
  }

  bool get enabledVote =>
      (ObjectUtil.isEmpty(picList) || ObjectUtil.isEmpty(videoFile)) &&
      ObjectUtil.isEmpty(
          itemList.firstWhereOrNull((element) => element.tag == 'vote'));
  bool get existVote => ObjectUtil.isNotEmpty(
      itemList.firstWhereOrNull((element) => element.tag == 'vote'));

  void loadQuoteContent() {
    if (ObjectUtil.isNotEmpty(Get.arguments) &&
        ObjectUtil.isNotEmpty(Get.arguments['quoteId'])) {
      quoteId = Get.arguments['quoteId'];
      childWidget.add(PostQuoteWidget(quoteId: Get.arguments['quoteId']));
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    final double newKeyboardHeight =
        MediaQuery.of(Get.context!).viewInsets.bottom;
    KeyboardHeight.value = newKeyboardHeight;
  }

  // 添加@文本
  addAtWidget(String name, String uid) {
    var value = '[25738CEBDAC49C49{$name|$uid}]';
    addControlText(value);
  }

  // 添加#文本
  addTopicWidget(String text) {
    var value = '#$text ';
    addControlText(value);
  }

  // 手动添加#文本
  clickAddTopicWidget(String textS) {
    var value = '$textS ';
    TextEditingController controller;
// 根据焦点判断使用哪个控制器
    if (lastTimeFocused.value == PostFocusNodeType.title) {
      controller = titleControll.value;
    } else if (lastTimeFocused.value == PostFocusNodeType.content) {
      controller = contentControll.value;
    } else {
      return; // 如果没有合适的焦点，则返回
    }
    // 获取光标位置
    int cursorPosition = controller.selection.start;

    // 检查光标位置是否有效
    if (cursorPosition < 0 || cursorPosition > controller.text.length) {
      cursorPosition = controller.text.length; // 默认将光标位置设置为文本末尾
    }

    String text = controller.text;

    // 插入新的文本到光标位置
    String newText = text + value + controller.text.substring(cursorPosition);
    controller.text = newText;

    // 将光标移动到插入文本之后
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length + value.length));
  }

  String coinIdenttity(ContractInfo? info) {
    return '[0f250d4882f9ebb9{${info?.type}|${info?.id}}]';
  }

// 添加币对文本
  void addCoinWidget(ContractInfo? info) {
    clearCoinMarket();
    symbolList.add(info!);
    //symbolMatchedStringsList = matchedStrings;
    List<PostChildWrapper> widget = symbolList.map((e) {
      return PostChildWrapper(
          tag: '${e.id}',
          type: PostChild.graph,
          widget: Container(
              margin: EdgeInsets.only(top: 10.h),
              child: CommunityCoinKchatWidget(
                  contractInfo: e,
                  type: CommunityCoinKChatType.post,
                  onClose: (info) {
                    String value = coinIdenttity(info);
                    contentControll.value.text = contentControll.value.text
                        .replaceAll(value, ''); // = value;
                    symbolList.remove(info);
                    removeItemList('${e.id}');
                  })));
    }).toList();
    addItem(widget);

    String value = coinIdenttity(info);
    TextEditingController controller;

    // 根据焦点判断使用哪个控制器
    if (lastTimeFocused.value == PostFocusNodeType.title) {
      controller = titleControll.value;
    } else if (lastTimeFocused.value == PostFocusNodeType.content) {
      controller = contentControll.value;
    } else {
      return; // 如果没有合适的焦点，则返回
    }

    // 获取光标位置
    int cursorPosition = controller.selection.start;

    // 检查光标位置是否有效
    if (cursorPosition < 0 || cursorPosition > controller.text.length) {
      cursorPosition = controller.text.length;
    }

    String text = controller.text;

    String newText = text.substring(0, cursorPosition) +
        value +
        text.substring(cursorPosition);
    // controller.text = newText;
    // controller.selection = TextSelection.fromPosition(
    //     TextPosition(offset: cursorPosition + value.length));

    // 调用 addCoinGraph 方法
    addCoinGraph(newText);
  }

  void addCoinGraph(String text) {
    RegExp regExp = RegExp(r'\[0f250d4882f9ebb9\{[^\|]+\|[^\}]+\}\]');

    // 使用正则表达式查找所有匹配项，并将其提取到数组中
    Iterable<Match> matches = regExp.allMatches(text);
    List<String> matchedStrings = matches.map((m) => m.group(0)!).toList();
    if (!listEquals(symbolMatchedStringsList, matchedStrings)) {
      List<ContractInfo> idsData = [];

      for (var i = 0; i < matchedStrings.length; i++) {
        String str = matchedStrings[i];
        ContractInfo? postCoinData = CommodityDataStoreController.to
            .getContractInfoByContractId(
                num.parse((str.split('{')[1].split('}')[0]).split('|')[1]));

        if (postCoinData != null) {
          idsData.add(postCoinData);
        }
      }
    }
  }

  void closeTags() {
    bottomShowType.value = PostShowTypeEnum.public;
  }

  void addControlText(String value) {
    TextEditingController controller;

    // 根据焦点判断使用哪个控制器
    if (lastTimeFocused.value == PostFocusNodeType.title) {
      controller = titleControll.value;
    } else if (lastTimeFocused.value == PostFocusNodeType.content) {
      controller = contentControll.value;
    } else {
      return;
    }

    // 获取光标位置
    int cursorPosition = controller.selection.start;

    // 检查光标位置是否有效
    if (cursorPosition < 0 || cursorPosition > controller.text.length) {
      cursorPosition = controller.text.length; // 默认将光标位置设置为文本末尾
    }

    String text = controller.text;

    // 查找光标前的最后一个 @ 和 # 符号位置
    int lastAtIndex = text.substring(0, cursorPosition).lastIndexOf('@');
    int lastHashIndex = text.substring(0, cursorPosition).lastIndexOf('#');

    // 初始化删除内容的起始位置
    int deleteStartIndex = -1;

    // 如果找到 @ 符号，直接设置为删除起始位置
    if (lastAtIndex != -1) {
      deleteStartIndex = lastAtIndex;
    }

    // 确保 # 存在，并且后面的内容不包含空格
    if (lastHashIndex != -1) {
      String afterHashText = text.substring(lastHashIndex + 1, cursorPosition);
      if (!afterHashText.contains(' ')) {
        // 如果 # 后面没有空格，则删除 # 及其后面的内容
        deleteStartIndex = lastHashIndex;
      }
    }

    // 如果找到了有效的起始位置，删除符号及其后面的内容
    if (deleteStartIndex != -1) {
      text = text.substring(0, deleteStartIndex);
    }

    // 插入新的文本到光标位置
    String newText = text + value + controller.text.substring(cursorPosition);
    controller.text = newText;

    // 将光标移动到插入文本之后
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length + value.length));

    bottomShowType.value = PostShowTypeEnum.public;
  }

//识别文本
  void validateText(Rx<TextEditingController> textControl) {
    String text = textControl.value.text;

    if (text.isNotEmpty) {
      //识别空格和换行

      String sub = text.substring(text.length - 1);

      if (sub == ' ' || sub == '\n') {
        closeTags();
      }
      print("cccc");
    }

    // 获取光标位置
    int cursorPosition = textControl.value.selection.start;

    // 检查光标位置是否有效
    if (cursorPosition < 0 || cursorPosition > text.length) {
      cursorPosition = text.length; // 默认将光标位置设置为文本末尾
    }

    // 只检查光标前的文本
    String beforeCursorText = text.substring(0, cursorPosition);

    // 找到最后一个符号的位置
    int lastAtIndex = beforeCursorText.lastIndexOf('@');
    int lastHashIndex = beforeCursorText.lastIndexOf('#');

    String? specialText;

    if (lastAtIndex > lastHashIndex) {
      // 只匹配最后一个 @ 符号之后的文本
      String atText = beforeCursorText.substring(lastAtIndex);
      RegExp atRegex = RegExp(r'^@(\S{0,10})$');
      if (atRegex.hasMatch(atText)) {
        print('peyton- 艾特 Text');

        bottomShowType.value = PostShowTypeEnum.at;
        specialText = atText.substring(1); // 去掉 '@'
        getFocusList(specialText);
      }
    } else if (lastHashIndex > lastAtIndex) {
      // 只匹配最后一个 # 符号之后的文本
      String hashText = beforeCursorText.substring(lastHashIndex);
      RegExp hashRegex = RegExp(r'^#(\S{0,64})$');
      if (hashRegex.hasMatch(hashText)) {
        print('peyton- 话题 Text');

        bottomShowType.value = PostShowTypeEnum.topic;
        specialText = hashText.substring(1); // 去掉 '#'
        topicTalkingPointList(specialText);
      }
    } else {
      // 如果没有匹配到 @ 或 # 符号
      bottomShowType.value = PostShowTypeEnum.public;
      print('peyton- 普通 Text');
    }
  }

//获取热门话题李彪
  topicTalkingPointList(String? test) async {
    try {
      TopicTalkingPointListModel? res =
          await CommunityApi.instance().topicTalkingPointList(keyword: test);
      if (res != null) {
        topicList.value = res.talkingPointList!;
      }
      update();
    } catch (e) {
      Get.log('error when getFocusList: $e');
    }
  }

//获取@数据列表
  getFocusList(String? text) async {
    var search = text == '' ? null : text;

    try {
      List<TopicFocusListModel>? res =
          await CommunityApi.instance().topicFocusAt(search);
      if (res != null) {
        focusList.value = res;
      }
      update();
    } catch (e) {
      Get.log('error when getFocusList: $e');
    }
  }

  fetchReferceCard() {
    //TODO: 转发时获取的信息
    // try {
    //   CommunityReferenceCardModel? res = await CommunityApi.instance()
    //       .fetchReferceCard(topicNo, UserGetx.to.uid);
    //   if (res != null) {
    //     cardmodel.value = res;
    //   }
    //   update();
    // } catch (e) {
    //   Get.log('error when fetchReferceCard: $e');
    // }
    cardmodel.value = CommunityReferenceCardModel(
      memberHeadUrl:
          'https://img.souyoutu.com/2020/0713/20200713084200998.jpg.420.420.jpg',
      topicTitle: '转发的标题',
      topicContent: '转发的内容',
      topicNo: '转发的编号',
      // isActive: true,
    );
    isReference.value = true;
  }

  //发帖
  submitOntap() async {
    if (titleControll.value.text.length < titleMin.value ||
        titleControll.value.text.length > titleMax.value) {
      UIUtil.showToast(
          LocaleKeys.community18.trArgs(['$titleMin', '$titleMax']));
      return false;
    }

    if (contentControll.value.text.length < contentMin.value ||
        contentControll.value.text.length > contentMax.value) {
      UIUtil.showToast(
          LocaleKeys.community20.trArgs(['$contentMin', '$contentMax']));
      return false;
    }

    Map<String, dynamic> data;

    if (isVideo.value == false) {
      data = {
        "type": CommunityFileTypeEnum.PIC,
        "topicTitle": titleControll.value.text,
        "topicContent": contentControll.value.text,
        'picList': picList
      };

      if (isScheduled.value) {
        if (publishTime.value.toUtc().isBefore(DateTime.now().toUtc())) {
          UIUtil.showToast(LocaleKeys.community121.tr);
          return;
        }
        data['postTime'] = DateUtil.formatDate(publishTime.value.toUtc(),
            format: 'yyyy-MM-dd HH:mm:ss');
      }

      if (postType == PostEditorTooType.bearish) {
        data['trendDirection'] = TrendDirection.down.key;
      } else if (postType == PostEditorTooType.bullish) {
        data['trendDirection'] = TrendDirection.up.key;
      }

      if (ObjectUtil.isNotEmpty(symbolList)) {
        data['symbolList'] =
            symbolList.map((element) => element.symbol).toList();
      }
      if (ObjectUtil.isNotEmpty(quoteId)) {
        data['quoteTopicId'] = quoteId;
      }
      if (ObjectUtil.isNotEmpty(voteList)) {
        String? search =
            voteList.firstWhereOrNull((e) => ObjectUtil.isEmpty(e));
        if (search?.isEmpty == true) {
          UIUtil.showToast(LocaleKeys.community120.tr);
          return;
        }
        data['votingDeadline'] = votingDeadline.value;
        data['votingOptionList'] =
            voteList; //.map((element) => element).toList();//.map((element) => element.id).toList();
      }

      //
      // bool allElementsSame = voteList.any((element) => element == voteList.first);
      // if(checkDuplicates(voteList) || allElementsSame){
      //   UIUtil.showToast('投票选项不能相同');
      //   return;
      // }

      postStatusDialog(data, sendType: SendType.sendImage);
    } else {
      data = {
        "type": CommunityFileTypeEnum.VIDEO,
        "topicTitle": titleControll.value.text,
        "topicContent": contentControll.value.text,
        "videoList": [videoFile.value],
        "coverInfo": videoCoverFile.value,
        // 'votingOptionList': voteList
      };
      if (ObjectUtil.isNotEmpty(quoteId)) {
        data['quoteTopicId'] = quoteId;
      }
      postStatusDialog(data, sendType: SendType.sendVideo);
    }
  }

  bool checkDuplicates(List list) {
    return list
        .any((item1) => list.any((item2) => item1 == item2 && item1 != item2));
  }

  //打开相册
  void getPhotos() async {
    if (UserGetx.to.goIsLogin()) {
      if (await requestPhotosPermission()) {
        final List<AssetEntity>? result = await AssetPicker.pickAssets(
            Get.context!,
            pickerConfig: AssetPickerConfig(
                maxAssets: isVideo.value == false ? 9 : 1,
                selectedAssets: isVideo.value == false ? picDefaultList : null,
                requestType: picDefaultList.isNotEmpty
                    ? RequestType.image
                    : RequestType.common,
                specialPickerType: picDefaultList.isNotEmpty
                    ? null
                    : SpecialPickerType.wechatMoment));
        if (result != null) {
          var videoEditorGetx = VideoEditorGetx();
          Get.put<VideoEditorGetx>(videoEditorGetx);
          if (result[0].videoDuration.inMicroseconds > 0) {
            var file = await result[0].file;
            await Get.find<VideoEditorGetx>().getController(file);
            Get.to(
              VideoEditorSetCoverPage(videoFile: result[0]),
              transition: Transition.cupertino,
            )?.then((value) {
              if (value != null) {
                videoFile.value = result[0];
                videoCoverFile.value = value;
                isVideo.value = true;
                update();
              }
            });
          } else {
            onAddImage(result);
            isVideo.value = false;
            update();
          }
        }
      }
    }
  }

  /// 添加图片
  void onAddImage(List<AssetEntity> result) {
    Get.to(
      PostImageEditor(
        imageAssets: result,
      ),
      transition: Transition.cupertino,
    )?.then((value) {
      if (value != null) {
        picList.value = value;
        picDefaultList.value = result;
      }
    });
  }

  /// 删除图片
  void onDeleteImage(index) {
    picList.removeAt(index);
    picDefaultList.removeAt(index);
    update();
  }

  /// 删除视频
  void onDeleteVideo() {
    videoFile.value = null;
    videoCoverFile.value = null;
    isVideo.value = false;
    update();
  }

  /// 展开或关闭（+）更多功能
  void showOrHideScheduled({bool? change}) {
    isShowScheduled.value = change ?? !isShowScheduled.value;
    update();
  }

  /// 展开或关闭（媒体文件）
  void showOrHideMediaFiles({bool? change}) {
    isShowMediaFiles.value = change ?? !isShowMediaFiles.value;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
