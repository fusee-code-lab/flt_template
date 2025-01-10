import 'package:flt_template/pages/home/online_search_page.dart';
import 'package:flt_template/services/music/music_providers.dart';
import 'package:flt_template/services/settings/models/app_settings.dart';
import 'package:flt_template/services/settings/ui/thme_model_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flt_template/services/settings/app_settings_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelect = ref.watch(appSettingsProvider.select((it) => it.themeModeSelect));
    final searchQuery = useState('');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          title: CupertinoTextField(
            controller: TextEditingController(text: searchQuery.value),
            onSubmitted: (value) => searchQuery.value = value,
            placeholder: '搜索歌曲',
            prefix: Icon(CupertinoIcons.search, size: 20).padding(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            decoration: BoxDecoration(
              color: CupertinoDynamicColor.withBrightness(
                color: CupertinoColors.white,
                darkColor: CupertinoColors.black,
              ),
              border: Border.all(
                color: CupertinoDynamicColor.withBrightness(
                  color: Color(0x33000000),
                  darkColor: Color(0x33FFFFFF),
                ),
                width: 0.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(13.0)),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: '在线'),
              Tab(text: '本地'),
            ],
          ),
          actions: [
            // menu
            PopupMenuButton<ThemeModeSelect>(
              icon: Icon(themeSelect.buildIcon(context)),
              onSelected: (value) {
                ref.read(appSettingsProvider.notifier).updateThemeModeSelect(value);
              },
              itemBuilder: (context) {
                return ThemeModeSelect.values.map((model) {
                  return PopupMenuItem<ThemeModeSelect>(
                    value: model,
                    child: Text(model.tooltip),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            searchQuery.value.isEmpty
                ? Text('搜索歌曲').center()
                : OnlineSearchPage(query: searchQuery.value),
            Container(
              child: Center(
                child: Text('本地'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
