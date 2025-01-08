
import 'package:flt_template/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: SplashRoute().location,
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
final currentRouteProvider = Provider((ref) {
  return ref.watch(routeInformationProvider).value.uri;
});