import 'package:flt_template/constants.dart';
import 'package:flt_template/utils/ui/fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ThemeData buildLightThemeData(BuildContext context) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Color(lightMaterialColorSeed),
    brightness: Brightness.light,
  );
  final textTheme = Typography.material2021(
    platform: defaultTargetPlatform,
    colorScheme: colorScheme,
  );

  return ThemeData(
    brightness: Brightness.light,
    textTheme: Theme.of(context)
        .textTheme
        .merge(textTheme.black)
        .withFontFeatures(const [FontFeature.proportionalFigures()]),
    useMaterial3: true,
    // TODO: need this when 2025?
    // highlightColor: kIsWeb ? Colors.transparent : null,
    // splashFactory: kIsWeb ? NoSplash.splashFactory : null,
    colorScheme: colorScheme,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
      ),
      titleTextStyle: textTheme.white.titleLarge!.copyWith(
        color: colorScheme.onSurface,
        // fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      toolbarHeight: 44,
    ),
    cardTheme: const CardTheme(
      elevation: 10,
      // custom corner radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      shadowColor: Colors.transparent,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        ),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(0),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
  );
}

ThemeData buildDarkThemeData(BuildContext context) {
  final colorSchemeDark = ColorScheme.fromSeed(
    seedColor: Color(darkMaterialColorSeed),
    brightness: Brightness.dark,
  );

  final textThemeDark = Typography.material2021(
    platform: defaultTargetPlatform,
    colorScheme: colorSchemeDark,
  );

  return ThemeData(
    brightness: Brightness.dark,
    textTheme: Theme.of(context)
        .textTheme
        .merge(textThemeDark.white)
        .withFontFeatures(const [FontFeature.proportionalFigures()]),
    useMaterial3: true,
    // TODO: need this when 2025?
    // highlightColor: kIsWeb ? Colors.transparent : null,
    // splashFactory: kIsWeb ? NoSplash.splashFactory : null,
    colorScheme: colorSchemeDark,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: colorSchemeDark.onSurface,
      ),
      titleTextStyle: textThemeDark.white.titleLarge!.copyWith(
        color: colorSchemeDark.onSurface,
        // fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      toolbarHeight: 44,
    ),
    cardTheme: const CardTheme(
      elevation: 10,
      // custom corner radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      shadowColor: Colors.transparent,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        ),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(0),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
  );
}
