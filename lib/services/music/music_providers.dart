import 'package:dart_music_api/music_api.dart';
import 'package:flt_template/services/music/network/dio.dart';
import 'package:flt_template/services/music/notifiers/player_notifier.dart';
import 'package:flt_template/services/music/notifiers/search_pagination_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final neteaseProvider = Provider<MusicApi>((ref) {
  return MusicPlatform.netEasy.api..configureDio(configureMusicDio);
});

// TODO: support set by user
final musicApiProvider = Provider<MusicApi>((ref) {
  return ref.watch(neteaseProvider);
});

typedef SongSearchNotifier = SearchPaginationNotifier<String, Song>;
final songSearchProvider = AsyncNotifierProvider.autoDispose.family<SongSearchNotifier, List<Song>, String>(() {
  return SongSearchNotifier(
    pageSize: 15,
    buildCursor: (api, query) {
      return api.searchSongs(query);
    },
  );
});

final playerStateProvider = NotifierProvider.autoDispose<PlayerNotifier, MusicPlayerState?>(() {
  return PlayerNotifier();
});