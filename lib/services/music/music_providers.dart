import 'package:dart_music_api/music_api.dart';
import 'package:flt_template/services/music/network/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final neteaseProvider = Provider<MusicApi>((ref) {
  return MusicPlatform.netEasy.api..configureDio(configureMusicDio);
});

// TODO: support set by user
final musicApiProvider = Provider<MusicApi>((ref) {
  return ref.watch(neteaseProvider);
});
