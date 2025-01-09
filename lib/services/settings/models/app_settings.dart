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

    /// App 最后初始化的版本号
    String? initializedVersion,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);
}
