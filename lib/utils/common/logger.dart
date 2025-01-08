import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';

class MetaLoggerFormatter implements LoggerFormatter {
  const MetaLoggerFormatter();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    final msgBorderedLines = msg.split('\n');
    if (!settings.enableColors) {
      // apply emoji
      final emojiLines = msgBorderedLines.mapIndexed((i, e) => '${i == 0 ? details.level.emoji : ""} $e').toList();
      return emojiLines.join('\n');
    }
    var lines = msgBorderedLines;
    lines = lines.map((e) => details.pen.write(e)).toList();
    final coloredMsg = lines.join('\n');
    return coloredMsg;
  }
}

final talker = Talker(
  settings: TalkerSettings(
    useConsoleLogs: kDebugMode,
    colors: {
        TalkerLogType.error.key: AnsiPen()..red(),
        TalkerLogType.debug.key: AnsiPen(),
        TalkerLogType.critical.key: AnsiPen()..rgb(r: 0.96, g: 0.5, b: 0.1),
        TalkerLogType.warning.key: AnsiPen()..yellow(),
        TalkerLogType.verbose.key:  AnsiPen()..magenta(),
        TalkerLogType.info.key: AnsiPen()..blue(),

        /// Riverpod section
        TalkerLogType.riverpodAdd.key: AnsiPen()..green(),
        TalkerLogType.riverpodUpdate.key: AnsiPen()..green(),
        TalkerLogType.riverpodDispose.key: AnsiPen()..xterm(198),
        TalkerLogType.riverpodFail.key: AnsiPen()..red(),
    }
  ),
  logger: TalkerLogger(
    formatter: const MetaLoggerFormatter(),
    settings: TalkerLoggerSettings(
      enableColors: defaultTargetPlatform != TargetPlatform.iOS,
    ),
  )
);


extension LogLevelExt on LogLevel {
  // emoji
  String get emoji {
    switch (this) {
      case LogLevel.error:
        return '❌';
      case LogLevel.debug:
        return '🐛';
      case LogLevel.critical:
        return '🚨';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.verbose:
        return '🔍';
      case LogLevel.info:
        return 'ℹ️';
    }
  }
}