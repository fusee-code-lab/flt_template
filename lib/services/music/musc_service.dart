import 'package:dart_music_api/music_api.dart';
import 'package:flt_template/components/toast.dart';
import 'package:flt_template/services/music/network/dio.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

Future<void> initializeMusicService(BuildContext context) async {
  final netease = MusicPlatform.netEasy.api;
  netease.configureDio(configureMusicDio);
  Injector.appInstance.registerSingleton<NetEasyApi>(() => netease as NetEasyApi);

  try {
    talker.info("init music service...");
    await netease.init();
    talker.info("init music service success");
  } catch (e) {
    talker.warning("init music service failed: $e");

    if (context.mounted) {
      context.toastWarning("匿名登录失败，请检查网络连接");
    }
  }
}
