import 'package:dart_music_api/music_api.dart';
import 'package:flt_template/components/toast.dart';
import 'package:flt_template/services/music/music_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:styled_widget/styled_widget.dart';

class OnlineSearchPage extends HookConsumerWidget {
  final String query;

  const OnlineSearchPage({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = songSearchProvider(query);
    final onlineSearch = ref.watch(provider);

    final isLoadMore = useState(false);
    final scrollController = useScrollController();

    final playSong = useCallback((Song song) {
      ref.read(playerStateProvider.notifier).play(song).catchError((e) {
        if (!context.mounted) return;
        context.toastError("播放失败，请稍后重试");
      });
    }, []);

    final listener = useCallback(() {
      if (!isLoadMore.value && scrollController.position.pixels >= scrollController.position.maxScrollExtent + 100) {
        isLoadMore.value = true;
        ref.read(provider.notifier).loadMore().then((value) {
          isLoadMore.value = false;
        });
      }
    }, [isLoadMore.value, scrollController]);

    final refresh = useCallback(() async {
      return await ref.refresh(provider.future);
    }, [provider]);

    useEffect(() {
      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    return onlineSearch.when(
      data: (songs) {
        return RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            itemCount: songs.length + 1,
            controller: scrollController,
            itemBuilder: (context, index) {
              // render load more indicator
              if (index == songs.length) {
                return isLoadMore.value
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                      ).width(15).height(15).padding(vertical: 20, bottom: 50).center()
                    : Container();
              }

              final song = songs[index];
              return ListTile(
                title: Text(song.name),
                subtitle: Text(song.artists.map((e) => e.name).join(' / ')),
                onTap: () {
                  playSong(song);
                },
                // album cover
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    song.album.coverImageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () {
        return Skeletonizer(
          enabled: true,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Item number $index as title'),
                  subtitle: const Text('Subtitle here'),
                  leading: Icon(Icons.ac_unit, size: 40),
                ),
              );
            },
          ),
        );
      },
      error: (error, stack) => Text('Error: $error').center(),
    );
  }
}
