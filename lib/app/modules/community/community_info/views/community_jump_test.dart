import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';

import '../../../../../generated/locales.g.dart';

class CommentSection extends StatefulWidget {
  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final ScrollController _scrollController = ScrollController();
  Map<int, GlobalKey> _keys = {}; // 一级评论的 GlobalKeys
  Map<String, GlobalKey> _subCommentKeys = {}; // 二级评论的 GlobalKeys
  int? _targetIndex; // 目标一级评论的索引(暂存，是否有用)
  int? _targetSubIndex; // 目标二级评论的索引

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MyButton(
              text: LocaleKeys.community82.tr,//'跳转到2-2',
              onTap: () {
                _scrollToComment(2, 2); // 跳转到指定的二级评论
              },
            ),
            MyButton(
              text: LocaleKeys.community83.tr,//'跳转到2-25',
              onTap: () {
                _scrollToComment(2, 25); // 跳转到指定的二级评论
              },
            ),
            MyButton(
              text: LocaleKeys.community84.tr,//'跳转到第3',
              onTap: () {
                _scrollToComment(3); // 仅跳转到第3个一级评论
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CommentItem(
                  index: index,
                  comment: '${LocaleKeys.community86.tr} $index',// '一级评论 $index',
                  targetSubIndex: _targetSubIndex,
                  onScrollToSubComment: (subIndex) {
                    _scrollToComment(index, subIndex);
                  },
                  keys: _keys,
                  subCommentKeys: _subCommentKeys,
                );
              },
              childCount: 1000,
            ),
          ),
        ],
      ),
    );
  }

  // 滚动到指定评论位置
  void _scrollToComment(int index, [int? subIndex]) {
    setState(() {
      _targetIndex = index;
      _targetSubIndex = subIndex;
    });

    // 在下一帧完成后执行滚动操作
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalKey? key;
      if (subIndex == null) {
        print('执行到了_keys');
        key = _keys[index]; // 获取一级评论的 GlobalKey
      } else {
        print('执行到了_subCommentKeys');
        key = _subCommentKeys['$index-$subIndex']; // 获取二级评论的 GlobalKey
      }

      // 如果 GlobalKey 关联的 Widget 存在，滚动到该 Widget 位置
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: Duration(milliseconds: 300),
          alignment: 0.5,
        );
      }
    });
  }
}

class CommentItem extends StatelessWidget {
  final int index; // 一级评论的索引
  final String comment; // 一级评论的内容
  final int? targetSubIndex; // 目标二级评论索引
  final void Function(int subIndex) onScrollToSubComment;
  final Map<int, GlobalKey>
      keys; // 一级评论的 GlobalKeys（放在里侧，因为要以一级评论为标准，而不是整体CommentItem）
  final Map<String, GlobalKey> subCommentKeys; // 二级评论的 GlobalKeys

  const CommentItem({
    Key? key,
    required this.index,
    required this.comment,
    required this.onScrollToSubComment,
    this.targetSubIndex,
    required this.keys,
    required this.subCommentKeys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          key: keys.putIfAbsent(
              index, () => GlobalKey()), // 为一级评论创建或获取 GlobalKey
          title: Text(comment),
          onTap: () {},
        ),
        // 动态生成二级评论列表
        ...List.generate(
          50,
          (subIndex) => Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: ListTile(
              key: subCommentKeys.putIfAbsent('$index-$subIndex',
                  () => GlobalKey()), // 为二级评论创建或获取 GlobalKey
              title: Text("${LocaleKeys.community87.tr} $subIndex  from ${LocaleKeys.community88.tr} $index"),
              onTap: () {
                onScrollToSubComment(subIndex); // 暂时，为了点哪儿跳哪儿
              },
            ),
          ),
        ),
      ],
    );
  }
}
