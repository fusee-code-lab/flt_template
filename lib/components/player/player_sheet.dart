import 'package:dart_music_api/music_api.dart';
import 'package:flt_template/services/music/music_providers.dart';
import 'package:flt_template/services/music/notifiers/player_notifier.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:styled_widget/styled_widget.dart';

class PlayerSheet extends HookConsumerWidget {
  const PlayerSheet({super.key});

  Widget _buildPlayer(
      BuildContext context, WidgetRef ref, MusicPlayerState state, VoidCallback toggle) {
    final MusicPlayerState(:song, :isPlaying) = state;

    final playerIcon = isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow);

    return Row(children: [
      Image.network(song.album.coverImageUrl, width: 50, height: 50).clipRRect(all: 13),
      const SizedBox(width: 7),
      Text(song.name)
          .textStyle(Theme.of(context).textTheme.bodyMedium!)
          .fontWeight(FontWeight.bold),

      // spacer
      const Spacer(),

      // play button
      IconButton(onPressed: toggle, icon: playerIcon)
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);

    final toggle = useCallback(() {
      ref.read(playerStateProvider.notifier).toggle();
    }, [playerState]);

    return (playerState == null ? Container() : _buildPlayer(context, ref, playerState, toggle))
        .constrained(width: double.infinity, height: double.infinity)
        .padding(horizontal: 5, vertical: 5)
        .card(
          elevation: 10,
          color: Theme.of(context).colorScheme.primaryContainer,
          borderOnForeground: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        )
        .padding(horizontal: 5, vertical: 2);
  }
}
