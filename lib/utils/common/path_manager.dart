import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PathManager {
  // singleton
  static final PathManager _instance = PathManager._();

  factory PathManager() {
    return _instance;
  }

  PathManager._();

  /// Get the path for the cookies
  Future<String> getCookiePath({bool create = true}) async {
    if (kIsWeb) {
      return '';
    }

    final base = await getApplicationSupportDirectory();
    final cookiePath = path.join(base.path, 'cookies');

    if (create && !await Directory(cookiePath).exists()) {
      await Directory(cookiePath).create(recursive: true);
    }

    return cookiePath;
  }

  /// 获取应用存储文件夹路径，用户自己的数据，但是不期望用户能容易地 (比如 ～/Documents) 直接访问
  Future<String> getAppStoragePath() async {
    var storePath = kIsWeb ? "" : await getApplicationDocumentsDirectory().then((i) => i.path);
    // only macos use sandbox
    if (!kIsWeb && [TargetPlatform.linux, TargetPlatform.windows].contains(defaultTargetPlatform)) {
      storePath = await getApplicationSupportDirectory().then((i) => i.path);
    }
    return storePath;
  }

  /// 获取用户数据备份文件夹路径，如果需要备份一些数据，可以使用这个路径
  Future<String> getBackupPath({bool create = true, required String username}) async {
    final base = await getApplicationSupportDirectory();
    final backupPath = path.join(base.path, 'backup', username);

    if (create && !await Directory(backupPath).exists()) {
      await Directory(backupPath).create(recursive: true);
    }

    return backupPath;
  }
}
