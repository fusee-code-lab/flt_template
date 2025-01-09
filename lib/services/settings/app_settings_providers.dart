import 'package:flt_template/services/settings/models/app_settings.dart';
import 'package:flt_template/services/settings/app_settings_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider((ref) {
  return Injector.appInstance.get<SharedPreferences>();
});

final appSettingsProvider = NotifierProvider.autoDispose<AppSettingsNotifier, AppSettings>(() {
  return AppSettingsNotifier();
});

final latestInitializedVersionProvider = Provider<String?>((ref) {
  final preferences = ref.watch(appSettingsProvider);
  return preferences.initializedVersion;
});