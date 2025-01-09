import 'package:flt_template/services/settings/models/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ThemeModeSelectUI on ThemeModeSelect {
  IconData buildIcon(BuildContext context) {
    switch (this) {
      case ThemeModeSelect.system:
        if (Theme.of(context).brightness == Brightness.dark) {
          return CupertinoIcons.moon;
        } else {
          return CupertinoIcons.sun_max;
        }
      case ThemeModeSelect.light:
        return CupertinoIcons.sun_max_fill;
      case ThemeModeSelect.dark:
        return CupertinoIcons.moon_fill;
    }
  }

  String get tooltip {
    switch (this) {
      case ThemeModeSelect.system:
        return '跟随系统';
      case ThemeModeSelect.light:
        return '明亮';
      case ThemeModeSelect.dark:
        return '暗黑';
    }
  }
}

extension ThemeModeSelectFlutter on ThemeModeSelect {
  ThemeMode toFltterThemeMode() {
    switch (this) {
      case ThemeModeSelect.system:
        return ThemeMode.system;
      case ThemeModeSelect.light:
        return ThemeMode.light;
      case ThemeModeSelect.dark:
        return ThemeMode.dark;
    }
  }
}