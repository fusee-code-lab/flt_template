# flt_template

Flutter app 开发模版

## Prepare

安装依赖

```bash
flutter pub get
```

运行 app 之前，运行代码生成 watched

```bash
flutter pub run build_runner watch
```

确保 build_ruunner 生成的代码是最新的

```bash
flutter test test/ensure_build_test.dart
```

## Dart Basics

- [freezed](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md): 自动生成数据类的序列化代码，hashCode，equals，copyWith等方法
- [json_serializable](https://pub.dev/packages/json_serializable): 自动生成 json 序列化代码, 代码生成阶段而不是运行阶段，dart 生态很多内容会依赖该库
- [dartx](https://pub.dev/packages/dartx): dart extensions 合集，如下: ([相关博客](https://juejin.cn/post/6844904191488425992))
```dart
final nestedList = [[1, 2, 3], [4, 5, 6]];
final flattened = nestedList.flatten(); // [1, 2, 3, 4, 5, 6]
```
- 日志选择了 [talker], 详见:

## 网络

- [dio]
  - [dio_cookie_manager]
  - [cookie_jar]
- [retrofit]

## Flutter Basics

- [flutter_hooks]
- [flutter_use]
- [styled_widget]

## State & Router

使用 riverpod 进行状态管理，使用 hooks_riverpod 以配合 flutter_hooks 使用，但不启用代码生成, 查看 [快速入门文档](https://riverpod.dev/zh-Hans/docs/introduction/getting_started)。同时采用 [talker_riverpod_logger](https://pub.dev/packages/talker_riverpod_logger) 来跟踪 riverpod 日志到 talker。

mark [riverpod#1033](https://github.com/rrousselGit/riverpod/issues/1033) ，devtools 开发进展，鸽。。

使用 [go_router](https://pub.dev/packages/go_router) 作为路由方案，并使用[类型安全路由](https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html)，查看 [文档](https://pub.dev/documentation/go_router/latest/), 以及 [Flutter go_router 路由管理全面指南](https://juejin.cn/post/7270343009790853172)。

## Resources

- 寻找优秀 dart & flutter 库: https://fluttergems.dev/
- dart 宏 (试验中): https://dart.dev/language/macros

## TODOS

- [ ] talker router logger
- [ ] save talker logs to file
- [ ] 路由权限管理
- [ ] AppError
  - 音乐 API error handler 返回统一错误，在统一的 CommonHandler 进行处理