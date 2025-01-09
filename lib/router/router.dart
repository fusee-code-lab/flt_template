
import 'package:flt_template/router/routes.dart';
import 'package:flt_template/services/settings/app_settings_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injector/injector.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final routerProvider = Provider<GoRouter>((ref) {
  // 根据版本号判断是否需要进入欢迎界面
  final latestInitializedVersion = ref.watch(latestInitializedVersionProvider);
  final curretVersion = Injector.appInstance.get<PackageInfo>().version;

  var initialRoute = SplashRoute().location;
  if (latestInitializedVersion != null && latestInitializedVersion == curretVersion) {
    initialRoute = HomeRoute().location;
  }

  final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: initialRoute,
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    redirect: (context, state) {
      // handle redirect logic here
      return null;
    },
  );
  ref.onDispose(router.dispose);

  return router;
});

final routeInformationProvider = ChangeNotifierProvider<GoRouteInformationProvider>((ref) {
  final router = ref.watch(routerProvider);
  return router.routeInformationProvider;
});

/// 最新的路由 Uri
/// TODO: chck pop action can be triggered?
/// see: https://github.com/flutter/flutter/issues/134013
final currentRouteProvider = Provider((ref) {
  return ref.watch(routeInformationProvider).value.uri;
});