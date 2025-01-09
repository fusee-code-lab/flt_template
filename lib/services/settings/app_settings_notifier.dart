import 'package:flt_template/services/settings/models/app_settings.dart';
import 'package:flt_template/services/settings/app_settings_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppSettingsNotifier extends AutoDisposeNotifier<AppSettings> {
  @override
  AppSettings build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final keys = preferences.getKeys();

    final Map<String, Object> preferencesMap = keys.fold({}, (previousValue, element) {
      final value = preferences.get(element)!;
      previousValue[element] = value;
      return previousValue;
    });

    return AppSettings.fromJson(preferencesMap);
  }

  void updateThemeModeSelect(ThemeModeSelect themeModeSelect) {
    final preferences = ref.watch(sharedPreferencesProvider);
    preferences.setString('themeModeSelect', themeModeSelect.name);
    state = state.copyWith(themeModeSelect: themeModeSelect);
  }
}