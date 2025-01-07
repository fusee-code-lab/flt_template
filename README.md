# flt_template

Flutter app 开发模版

## Prepare

安装依赖

```bash
flutter pub get
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

- [rverpod]
  - [hooks_riverpod]