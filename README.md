# 项目Wikipedia
https://e4gueo9t6d9.sg.larksuite.com/wiki/TfjAwGn4Ni9cI7kdleElPMsOgic

git 提交前缀
"feat"（新功能）
"fix"（修复 bug）
"style"（样式调整）
"optimize"（对代码进行优化<没有实质性功能改动，比如提高性能、体验>）
"perf" (性能优化)
"refactor"（重构）
"test"（测试）
"config"(配置文件调整)
"revert"(撤销以前的 commit)
"security" - 安全相关的改动
"chore"（构建过程或辅助工具的变动)
"ci"(修改 CI/CD 流程、配置文件等)

├── app
│   ├── api     所有的接口API放这里，写法参考已有
│   │   ├── account_api.dart
│   │   └── account_api.g.dart
│   ├── cache       app数据缓存放这里，里面对基本类做了 枚举类型扩展
│   │   └── app_cache.dart
│   ├── config      app的配置中心
│   │   ├── env
│   │   │   └── env_config.dart 基础环境配置
│   │   ├── lang
│   │   │   ├── local_enum.dart     国际化语言枚举类型
│   │   │   └── translation_service.dart
│   │   ├── preinit         app启动初始化
│   │   │   └── pre_init.dart
│   │   └── theme           app主题配置
│   │       ├── app_color.dart
│   │       └── app_theme.dart
│   ├── extension           基本类型扩展
│   │   ├── num_extension.dart
│   │   └── string_extension.dart
│   ├── models          模型类
│   │   ├── req         请求实体类，对应的API的接口参数实体对象
│   │   │   └── login_request.dart
│   │   └── res         接口返回数据data对象
│   │       └── user_info.dart
│   ├── modules         业务模块
│   │   ├── main_tab
│   │   │   ├── bindings
│   │   │   │   └── main_tab_binding.dart
│   │   │   ├── controllers
│   │   │   │   └── main_tab_controller.dart
│   │   │   └── views
│   │   │       └── main_tab_view.dart
│   │   └── splash
│   │       ├── bindings
│   │       │   └── splash_binding.dart
│   │       ├── controllers
│   │       │   └── splash_controller.dart
│   │       └── views
│   │           └── splash_view.dart
│   ├── network     网络层
│   │   ├── app_dio.dart
│   │   ├── request_interceptor.dart    // 请求拦截器
│   │   └── response_interceptor.dart   // 响应拦截器
│   ├── routes      路由
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   ├── utils       工具类
│   │   └── bus
│   │       ├── event_bus.dart  事件总线
│   │       └── event_type.dart 事件类型
│   └── widgets     基础组件
│       ├── image_view.dart
│       └── sliver_header_delegate.dart
├── generated       CLI生成的 .g.dart文件
│   ├── json
│   │   ├── base
│   │   │   ├── json_convert_content.dart
│   │   │   └── json_field.dart
│   │   └── user_info.g.dart
│   └── locales.g.dart
└── main.dart
```

## GetX CLI的使用
运行命令flutter pub global activate get_cli 安装CLI

```agsl
// 创建page:
// (页面包括 controller, view, 和 binding)
// 注: 你可以随便命名, 例如: `get create page:login`
// 注: 选择了 Getx_pattern 结构才用这个选项
get create page:home

// 在指定文件夹创建新 controller:
// 注: 你无需引用文件夹, Getx 会自动搜索 home 目录,
// 并把你的controller放在那儿
get create controller:dialogcontroller on home

// 在指定文件夹创建新 view:
// 注: 你无需引用文件夹,Getx 会自动搜索 home 目录,
// 并把你的 view 放在那儿
get create view:dialogview on home

// 生成国际化文件:
// 注: 你在 'assets/locales' 目录下的翻译文件应该是json格式的
get generate locales assets/locales
```

## 快速开发插件
FlutterJsonBeanFactory ： json转dart实体类插件，注意将 Setting - Tools - FlutterJsonBeanFactory - model suffix 设置为 info 统一模型文件后缀
Flutter-Toolkit ： 生成API接口请求代码插件。每个API类都有一个静态工厂方法，不要放到getx中管理。

## 资源文件
assets 管理图标、图片、字体等资源文件。按照模块划分。注意命名规范。
locales 管理国际化文件。按照模块划分。注意命名规范。

## 单模块开发
```
使用 getxcli 的 get create page:home 命令创建页面，会自动生成 controller, view, binding 三个文件。
根据模块复杂性，选择性拆分。 如果模块简单，可以不用拆分，直接在模块目录下创建 controller, view, binding 三个文件。
如果复杂，多出来 state 状态管理，widgets 小组件。

├── bindings        依赖绑定
│   └── main_tab_binding.dart
├── controllers     控制器，业务逻辑，数据处理
│   └── main_tab_controller.dart
├── state           状态管理：避免使用obx，尽量使用GetBuilder，单项更新id的方式。好处是统一更新UI。
├── views           视图表现层
│   └── main_tab_view.dart
└── widgets         小组件
```

# Peyton Model

序列化命令(Model类更改后，重新执行)

* flutter pub run build_runner build
* flutter pub run build_runner watch 持续监听
* flutter pub run build_runner build --delete-conflicting-outputs

## 命名规范
1. 类文件命名：小写字母，单词之间用下划线分割。
2. 类名命名：大写字母开头，单词之间不用分割。大驼峰命名法。
3. 文件夹命名：小写字母。

## 列表：支持下拉刷新，上拉加载更多，空数据，错误重试，加载中。
使用方式参考：CommodityHistoryTradeController 和 CommodityHistoryTradeView
### GetListController
控制器基类：继承 GetListController<T>，实现 fetchData 方法，返回数据列表。内部实现了下拉刷新，上拉加载更多，空数据，错误重试，加载中等逻辑。
注意：范形 T 是列表项数据类型.
```dart
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/locales.g.dart';

abstract class GetListController<T> extends GetxController
    with StateMixin<List<T>> {
  /// 初始化页码
  int pageIndex = 1;
  /// 每页数量
  int pageSize = 10;
  /// 刷新控制器
  late RefreshController refreshController;
  /// 数据列表
  List<T> dataList = [];

  @override
  void onInit() {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  /// 刷新
  /// [pull] 是否是下拉刷新
  refreshData(bool pull) async {
    try {
      pageIndex = 1;
      dataList.clear();
      if (!pull) {
        change(dataList, status: RxStatus.loading());
      }
      final res = await fetchData();
      dataList.addAll(res);
      change(dataList,
          status: res.isEmpty ? RxStatus.empty() : RxStatus.success());
      if (pull) {
        refreshController.refreshCompleted();
      }
    } catch (e) {
      if (pull) {
        refreshController.refreshFailed();
      } else {
        change(null, status: RxStatus.error(LocaleKeys.trade42.tr));
      }
    }
  }

  /// 上拉加载更多
  loadMoreData() async {
    try {
      pageIndex++;
      final res = await fetchData();
      dataList.addAll(res);
      change(dataList, status: RxStatus.success());
      if(res.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
    }
  }

  /// 获取数据
  Future<List<T>> fetchData();
}
```

### GetStateListExtension
扩展了 StateMixin。提供了相应状态的试图。可以配合 GetListController 使用。也可以单独使用
```dart
  /// 页面状态
  /// [widget] 页面构建
  /// [onLoading] 加载中
  /// [onError] 错误
  /// [onEmpty] 空数据
  /// [onRetryRefresh] 重试回调
  Widget pageObx(NotifierBuilder<T?> widget,
      {Widget? onLoading,
      Widget Function(String)? onError,
      Widget? onEmpty,
      VoidCallback? onRetryRefresh}) {
    return SimpleBuilder(builder: (_) {
      /// 加载中
      if (status.isLoading) {
        return onLoading ?? const Center(child: LoadingWidget());
      }
      /// 错误重试
      if (status.isError) {
        return onError != null
            ? onError(status.errorMessage ?? LocaleKeys.public55.tr)
            : Center(
                child: NetworkErrorWidget(
                  onTap: onRetryRefresh ?? () => {},
                ),
              );
      }
      /// 空数据
      if (status.isEmpty) {
        return onEmpty ??
            noDataWidget(
              Get.context,
              text: LocaleKeys.public8.tr,
            ); // Also can be widget(null); but is risky
      }
      /// 成功
      return widget(value);
    });
  }
```



