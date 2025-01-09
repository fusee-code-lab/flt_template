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

void configureMusicDio(Dio dio, { bool debugMode = true }) {
  dio.options.connectTimeout = Duration(seconds: debugMode ? 1 : releaseNetworkConnectTimeoutSeconds);
  dio.options.receiveTimeout = Duration(seconds: debugMode ? 1 : releaseNetworkReceiveTimeoutSeconds);

  // business logic common
  dio.interceptors.add(CommonHandler());

  // logger
  dio.interceptors.add(
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
}
