import 'package:flt_template/router/router.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:flt_template/utils/ui/fonts.dart';
import 'package:flt_template/utils/ui/scroll_behavior.dart';
import 'package:flt_template/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

void main() async {
  // init application
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: talker)],
      child: const TingApp(),
    ),
  );

  talker.info('App started');
}

class TingApp extends ConsumerWidget {
  const TingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cupertinoTextTheme = CupertinoTextThemeData();

    // TODO: theme setup

    final router = ref.watch(routerProvider);

    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: cupertinoTextTheme.withFontFeatures(
          const [FontFeature.proportionalFigures()],
        ),
      ),
      child: MaterialApp.router(
        title: appTitle,
        themeAnimationStyle: kIsWeb ? AnimationStyle.noAnimation : null,
        debugShowCheckedModeBanner: false,
        scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
        supportedLocales: const [
          // 加上该配置是为了解决部分平台下中文字体渲染的问题
          Locale('zh', "CN")
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
      ),
    );
  }
}
