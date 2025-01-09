import 'package:flt_template/services/music/music_lib.dart';
import 'package:flt_template/router/router.dart';
import 'package:flt_template/services/settings/app_settings_providers.dart';
import 'package:flt_template/services/settings/ui/thme_model_ui.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:flt_template/utils/network/dio.dart';
import 'package:flt_template/utils/ui/fonts.dart';
import 'package:flt_template/utils/ui/scroll_behavior.dart';
import 'package:flt_template/constants.dart';
import 'package:flt_template/utils/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

void main() async {
  // init application
  WidgetsFlutterBinding.ensureInitialized();

  // init services
  await initializeGloblDio(debugMode: kDebugMode);
  final musicSDK = await MusicSDK.initializeMusicSDK();
  final sharedPreferences = await SharedPreferences.getInstance();

  // register injector
  Injector.appInstance.registerSingleton<MusicSDK>(() => musicSDK);
  Injector.appInstance
      .registerSingleton<SharedPreferences>(() => sharedPreferences);

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
    final userThemeSelect =
        ref.watch(appSettingsProvider.select((it) => it.themeModeSelect));
    final router = ref.watch(routerProvider);

    final lightThemeData = buildLightThemeData(context);
    final darkThemeData = buildDarkThemeData(context);
    final cupertinoTextTheme = CupertinoTextThemeData();

    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: cupertinoTextTheme.withFontFeatures(
          const [FontFeature.proportionalFigures()],
        ),
      ),
      child: MaterialApp.router(
        title: appTitle,
        // 在 Web 上不使用动画以确保性能？
        // themeAnimationStyle: kIsWeb ? AnimationStyle.noAnimation : null,
        debugShowCheckedModeBanner: false,
        scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
        theme: lightThemeData,
        darkTheme: darkThemeData,
        themeMode: userThemeSelect.toFltterThemeMode(),
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
