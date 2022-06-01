import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/controlButton.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DetailSong2 extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final VoidCallback onTap;
  final List<SongModel> songmodel;
  final Stream<PositionData> positionData;
  const DetailSong2(
      {Key? key,
      required this.audioPlayer,
      required this.onTap,
      required this.songmodel,
      required this.positionData})
      : super(key: key);

  @override
  State<DetailSong2> createState() => _DetailSong2State();
}

class _DetailSong2State extends State<DetailSong2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(minutes: 6),
      vsync: this,
    );
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: widget.onTap, icon:const Icon(Icons.arrow_back_ios)),
                const Text(
                  'Now Playing',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                 IconButton(onPressed: (){}, icon:const Icon(Icons.alarm),)
              ],
            ),
            const SizedBox(
              height: 100,
            ),
                StreamBuilder(
                stream: widget.audioPlayer.currentIndexStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child:  Text(''),
                    );
                  }
                  return   RotationTransition(
              turns: Tween(begin: 0.0, end: 5.0).animate(_controller),
              child: QueryArtworkWidget(
                  id: widget.songmodel[int.parse(snapshot.data.toString())].id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 200,
                  artworkHeight: 200,
                  artworkBorder: BorderRadius.circular(100),
                  keepOldArtwork: true,
                  nullArtworkWidget: const CircleAvatar(
                    radius: 100, // Image radius
                    backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Circle-icons-music.svg/2048px-Circle-icons-music.svg.png'),
                  )),
            );
                }),
          
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: widget.audioPlayer.currentIndexStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child:  Text(''),
                    );
                  }
                  return SizedBox(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                        child: Text(
                          widget.songmodel[int.parse(snapshot.data.toString())]
                              .displayNameWOExt,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style:
                              TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ],
                    ),
                  );
                }),
                      const SizedBox(
                height: 10,
              ),
               StreamBuilder(
                stream: widget.audioPlayer.currentIndexStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child:  Text(''),
                    );
                  }
                  return Center(
                    child: Text(
                      widget.songmodel[int.parse(snapshot.data.toString())]
                          .artist!,
                      textAlign: TextAlign.center,
                      style:
                         const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  );
                }),
             const SizedBox(
              height: 10,
            ),
            StreamBuilder<PositionData>(
              stream: widget.positionData,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: (newPosition) {
                    widget.audioPlayer.seek(newPosition);
                  },
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ControlButtons(widget.audioPlayer),
            Row(
                children: [
                  StreamBuilder<LoopMode>(
                    stream: widget.audioPlayer.loopModeStream,
                    builder: (context, snapshot) {
                      final loopMode = snapshot.data ?? LoopMode.off;
                      const icons = [
                        Icon(Icons.repeat, color: Colors.grey),
                        Icon(Icons.repeat, color: Colors.orange),
                        Icon(Icons.repeat_one, color: Colors.orange),
                      ];
                      const cycleModes = [
                        LoopMode.off,
                        LoopMode.all,
                        LoopMode.one,
                      ];
                      final index = cycleModes.indexOf(loopMode);
                      return IconButton(
                        icon: icons[index],
                        onPressed: () {
                          widget.audioPlayer.setLoopMode(cycleModes[
                              (cycleModes.indexOf(loopMode) + 1) %
                                  cycleModes.length]);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Local Song",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: widget.audioPlayer.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? const Icon(Icons.shuffle, color: Colors.orange)
                            : const Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () async {
                          final enable = !shuffleModeEnabled;
                          if (enable) {
                            await widget.audioPlayer.shuffle();
                          }
                          await widget.audioPlayer.setShuffleModeEnabled(enable);
                        },
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
