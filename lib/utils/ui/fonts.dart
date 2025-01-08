import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

extension FontExt on TextTheme {
  TextTheme withFontFeatures(List<FontFeature> features) {
    return copyWith(
      displayLarge: displayLarge?.copyWith(fontFeatures: features),
      displayMedium: displayMedium?.copyWith(fontFeatures: features),
      displaySmall: displaySmall?.copyWith(fontFeatures: features),
      headlineLarge: headlineLarge?.copyWith(fontFeatures: features),
      headlineMedium: headlineMedium?.copyWith(fontFeatures: features),
      headlineSmall: headlineSmall?.copyWith(fontFeatures: features),
      titleLarge: titleLarge?.copyWith(fontFeatures: features),
      titleMedium: titleMedium?.copyWith(fontFeatures: features),
      titleSmall: titleSmall?.copyWith(fontFeatures: features),
      bodyLarge: bodyLarge?.copyWith(fontFeatures: features),
      bodyMedium: bodyMedium?.copyWith(fontFeatures: features),
      bodySmall: bodySmall?.copyWith(fontFeatures: features),
      labelLarge: labelLarge?.copyWith(fontFeatures: features),
      labelMedium: labelMedium?.copyWith(fontFeatures: features),
      labelSmall: labelSmall?.copyWith(fontFeatures: features),
    );
  }
}

// do for cuperino
extension CupertinoFontExt on CupertinoTextThemeData {
  CupertinoTextThemeData withFontFeatures(List<FontFeature> features) {
    return copyWith(
      textStyle: textStyle.copyWith(fontFeatures: features),
      actionTextStyle: actionTextStyle.copyWith(fontFeatures: features),
      tabLabelTextStyle: tabLabelTextStyle.copyWith(fontFeatures: features),
      navTitleTextStyle: navTitleTextStyle.copyWith(fontFeatures: features),
      navLargeTitleTextStyle:
          navLargeTitleTextStyle.copyWith(fontFeatures: features),
      navActionTextStyle: navActionTextStyle.copyWith(fontFeatures: features),
      pickerTextStyle: pickerTextStyle.copyWith(fontFeatures: features),
      dateTimePickerTextStyle:
          dateTimePickerTextStyle.copyWith(fontFeatures: features),
    );
  }
}
