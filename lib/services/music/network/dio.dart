import 'package:dio/dio.dart';

import 'package:flt_template/constants.dart';
import 'package:flt_template/services/music/network/common_handler.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

void configureMusicDio(Dio dio, {bool debugMode = kDebugMode}) {
  dio.options.connectTimeout =
      Duration(seconds: debugMode ? 1 : releaseNetworkConnectTimeoutSeconds);
  dio.options.receiveTimeout =
      Duration(seconds: debugMode ? 1 : releaseNetworkReceiveTimeoutSeconds);

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
