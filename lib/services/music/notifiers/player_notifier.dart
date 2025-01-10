import 'package:dart_music_api/music_api.dart';
import 'package:flt_template/services/music/music_providers.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';

sealed class MusicPlayerState {
  final Song song;
  final bool isPlaying;

  const MusicPlayerState(this.song, {this.isPlaying = true});

  MusicPlayerState copyWith({Song? song, bool? isPlaying}) {
    return MusicPlayerStateSingle(
      song ?? this.song,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

class MusicPlayerStateSingle extends MusicPlayerState {
  const MusicPlayerStateSingle(super.song, {super.isPlaying = true});
}

class PlayerNotifier extends AutoDisposeNotifier<MusicPlayerState?> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  MusicPlayerState? build() {
    ref.onDispose(() {
      talker.info("audio player disposed");
      _audioPlayer.dispose();
    });

    return null;
  }

  Future<void> play(Song song) async {
    if (_audioPlayer.audioSource != null) {
      await _audioPlayer.stop();
      talker.info("audio player stopped");
    }

    final url = ref.read(musicApiProvider).simpleSongUrl(song.id);
    talker.info("will play music from $url");

    try {
      final duration = await _audioPlayer.setUrl(url);
      talker.info("song loadded ${song.name} (duration: $duration)");

      _audioPlayer.play();
      talker.info("song played ${song.name}");

      state = MusicPlayerStateSingle(song, isPlaying: true);
    } catch (e) {
      talker.error("failed to play music: $e");
      state = null;

      rethrow;
    }
  }

  void pause() {
    _audioPlayer.pause();
    talker.info("song paused");

    state = state?.copyWith(isPlaying: false);
  }

  void resume() {
    _audioPlayer.play();
    talker.info("song resumed");

    state = state?.copyWith(isPlaying: true);
  }

  void toggle() {
    if (state == null) {
      return;
    }
    if (state!.isPlaying) {
      pause();
    } else {
      resume();
    }
  }
}
