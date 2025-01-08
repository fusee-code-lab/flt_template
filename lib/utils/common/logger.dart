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
  ),
  logger: TalkerLogger(
    formatter: const MetaLoggerFormatter(),
    settings: TalkerLoggerSettings(
      enableColors: defaultTargetPlatform != TargetPlatform.iOS,
      colors: {
        LogLevel.error: AnsiPen()..red(),
        LogLevel.debug: AnsiPen(),
        LogLevel.critical: AnsiPen()..rgb(r: 0.96, g: 0.5, b: 0.1),
        LogLevel.warning: AnsiPen()..yellow(),
        LogLevel.verbose:  AnsiPen()..magenta(),
        LogLevel.info: AnsiPen()..blue(),
      },
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
      default:
        return '';
    }
  }
}