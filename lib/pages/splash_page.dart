import 'package:flt_template/constants.dart';
import 'package:flt_template/router/routes.dart';
import 'package:flt_template/services/settings/app_settings_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injector/injector.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:styled_widget/styled_widget.dart';

/// App 欢迎界面和引导界面，会根据版本号判断是否加载该界面，详见 [routerProvider]
class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          Text("Welcome to $appTitle").textStyle(Theme.of(context).textTheme.titleLarge!),
          TextButton(
            onPressed: () {
              final curVersion = Injector.appInstance.get<PackageInfo>().version;
              ref.read(appSettingsProvider.notifier).updateInitializedVersion(curVersion);
              const HomeRoute().pushReplacement(context);
            },
            child: Text("Go To Home"),
          ),
        ],
      ).width(double.infinity),
    );
  }
}
