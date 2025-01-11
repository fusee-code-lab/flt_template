import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flt_template/constants.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:flt_template/utils/common/path_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

late final Dio globalDio;
late final PersistCookieJar globalCookieJar;

Future<void> initializeGloblDio({bool debugMode = true}) async {
  final instance = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: debugMode ? 1 : releaseNetworkConnectTimeoutSeconds),
      receiveTimeout: Duration(seconds: debugMode ? 1 : releaseNetworkReceiveTimeoutSeconds),
      responseType: ResponseType.json,
    ),
  );

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
  if (kIsWeb) {
    // TODO:
  } else {
    final cookieDir = await PathManager().getCookiePath(create: true);
    final jar = PersistCookieJar(storage: FileStorage(cookieDir));
    instance.interceptors.add(CookieManager(jar));
    talker.info('Cookie storage path: $cookieDir');
    globalCookieJar = jar;
  }

  globalDio = instance;
}
