import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flt_template/constants.dart';
import 'package:flt_template/services/music/network/common_handler.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:flt_template/utils/common/path_manager.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class MusicSDKNetworkPack {
  final Dio dio;
  final PersistCookieJar cookieJar;

  const MusicSDKNetworkPack({
    required this.dio,
    required this.cookieJar,
  });
}

Future<MusicSDKNetworkPack> createMusicNetwork(String domain, { bool debugMode = true }) async {
  final instance = Dio(
    BaseOptions(
      baseUrl: domain,
      connectTimeout: Duration(seconds: debugMode ? 1 : releaseNetworkConnectTimeoutSeconds),
      receiveTimeout: Duration(seconds: debugMode ? 1 : releaseNetworkReceiveTimeoutSeconds),
      responseType: ResponseType.json,
    ),
  );

  // business logic common
  instance.interceptors.add(CommonHandler());

  // logger
  instance.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: false,
        printResponseMessage: true,
        responsePen: AnsiPen()..cyan(),
      ),
    ),
  );

  // cookie
  final cookieDir = await PathManager().getCookiePath(create: true);
  final jar = PersistCookieJar(storage: FileStorage(cookieDir));
  instance.interceptors.add(CookieManager(jar));
  talker.info('Cookie storage path: $cookieDir');

  return MusicSDKNetworkPack(dio: instance, cookieJar: jar);
}
