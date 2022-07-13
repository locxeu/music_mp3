import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:provider/provider.dart';

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.volume_up,
            color: AppTheme.backgroundColor,
          ),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_previous, color: AppTheme.backgroundColor),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_arrow, color: AppTheme.backgroundColor),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause, color: AppTheme.backgroundColor),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay, color: AppTheme.backgroundColor),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero,
                    index: player.effectiveIndices!.first),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => Consumer<SearchSongState>(
            builder: (_, nextSong, __) => IconButton(
                icon: Icon(Icons.skip_next, color: AppTheme.backgroundColor),
                onPressed: player.hasNext
                    ? () {
                        player.seekToNext();
                        print(player.currentIndex);
                      }
                    : () {
                        nextSong.getAudio(nextSong.listSong1,
                            nextSong.currentIndexPlaying + 1);
                      }),
          ),
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: AppTheme.headLine3),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}
