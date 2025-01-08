# Flutter 应用开发模板

这是一个 Flutter 应用开发模板，一个音乐搜索播放 Demo App，集成了当前 Flutter 生态中最佳实践和主流技术栈。

## Features

- 完整的项目结构设计
- 现代化的状态管理方案
- 类型安全的路由系统
- 日志追踪
- 支持暗黑模式切换

## 🛠 技术栈

### 核心依赖

- **状态管理**: riverpod + hooks_riverpod - 官方推荐的反应式状态管理与缓存框架，搭配 hooks 使用
- **路由方案**: go_router - 支持类型安全的声明式路由
- **网络请求**: dio + retrofit - 类型安全的网络请求方案
- **数据序列化**: freezed + json_serializable - 数据类生成方案
- **工具扩展**: dartx - Dart 语言扩展集合
- **日志系统**: talker - 日志追踪解决方案
- **UI组件**：styled_widget - 一种更简单的方式来构建 Flutter UI

## 🎯 快速开始

### 环境准备

确保已经安装了最新版本的 Flutter SDK，然后执行：

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

## 📚 相关资源

- rierpod 阅读资料
  - [官方文档](https://riverpod.dev/docs/essentials/first_request)
  - [原理讲解博客, Flutter Riverpod 全面深入解析，为什么官方推荐它？](https://juejin.cn/post/7063111063427874847#heading-10)
- [styled_widget官方文档](https://github.com/ReinBentdal/styled_widget)

- 寻找优秀 dart & flutter 库: https://fluttergems.dev/
- dart 宏 (试验中): https://dart.dev/language/macros

## TODOS

- [ ] talker router logger
- [ ] 保存日志到文件
- [ ] 路由权限管理 Demo
- [ ] Database
- [ ] i18n
- [ ] AppError 设计
  - 音乐 API error handler 返回统一错误，在统一的 CommonHandler 进行处理