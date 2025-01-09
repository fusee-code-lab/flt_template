import 'package:flt_template/services/settings/models/app_settings.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flt_template/services/settings/app_settings_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelect = ref.watch(appSettingsProvider.select((it) => it.themeModeSelect));

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$themeSelect'),
          // dropdown menu
          DropdownButton<ThemeModeSelect>(
            value: themeSelect,
            onChanged: (value) {
              ref.read(appSettingsProvider.notifier).updateThemeModeSelect(value!);
            },
            items: ThemeModeSelect.values.map((ThemeModeSelect value) {
              return DropdownMenuItem<ThemeModeSelect>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
        ],
      ).center()
    );
  }
}