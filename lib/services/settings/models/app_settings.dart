import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

enum ThemeModeSelect {
  system,
  light,
  dark,
}

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(ThemeModeSelect.system) ThemeModeSelect themeModeSelect,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);
}
