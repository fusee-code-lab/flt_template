// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      themeModeSelect: $enumDecodeNullable(
              _$ThemeModeSelectEnumMap, json['themeModeSelect']) ??
          ThemeModeSelect.system,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'themeModeSelect': _$ThemeModeSelectEnumMap[instance.themeModeSelect]!,
    };

const _$ThemeModeSelectEnumMap = {
  ThemeModeSelect.system: 'system',
  ThemeModeSelect.light: 'light',
  ThemeModeSelect.dark: 'dark',
};
