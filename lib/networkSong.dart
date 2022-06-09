import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';
import 'package:music_mp3_app/controlButton.dart';
import 'package:music_mp3_app/instance/instance.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:music_mp3_app/ui/widget/custom_dialog.dart';
import 'package:music_mp3_app/ui/widget/header_detail_playing.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'extension/extension.dart';

class NetworkSong extends StatefulWidget {
  final List<AudioSource> listAudio;
  const NetworkSong({Key? key, required this.listAudio}) : super(key: key);

  @override
  NetworkSongState createState() => NetworkSongState();
}

class NetworkSongState extends State<NetworkSong>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  var _playlist;
  late AnimationController _controller;
  final int _addedCount = 0;
  @override
  void initState() {
    super.initState();
    // ambiguate(WidgetsBinding.instance)!.addObserver(this);
    // Instances.player = Instances.player;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    // _init();
    _controller = AnimationController(
      duration: const Duration(minutes: 6),
      vsync: this,
    );
    if (mounted) {
      _controller.forward();
    }
  }

  void setTimer() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    const Text('enter'),
                    Row(
                      children:   [
                        Expanded(
                            child: Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                         borderRadius: BorderRadius.circular(10)
                              ),
                              child: const TextField(
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 197, 63, 209), width: 1.0),
                              ),
                              fillColor: Colors.red
                          ),
                        ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                        const Text(':'),
                        const SizedBox(
                              width: 10,
                            ),
                         Expanded(
                            child: Container(
                              width: 100,
                                  height: 80,
                              decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                         borderRadius: BorderRadius.circular(10)
                              ),
                              child: const TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                            border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 197, 63, 209), width: 1.0),
                              ),
                              fillColor: Colors.red
                          ),
                        ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _init() async {
    log('init run');
    _playlist = ConcatenatingAudioSource(
      children: [
        for (var i = 0; i < widget.listAudio.length; i++) widget.listAudio[i]
      ],
    );
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    Instances.player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      // Preloading audio is not currently supported on Linux.
      await Instances.player.setAudioSource(_playlist,
          initialIndex: context.read<SearchSongState>().currentIndexPlaying,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
      // await  Instances.player.seek(Duration.zero,index:context.read<SearchSongState>().currentIndexPlaying);
      Instances.player.play();
    } catch (e) {
      // Catch load errors: 404, invalid url...
      log("Error123 loading audio source: $e");
      showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBox(
                title: 'Sorry',
                descriptions: 'Error123 loading audio source: $e'.toString(),
                text: 'OK',
                imageFile: Images.error);
          });
    }
  }

  @override
  void dispose() {
    // ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Instances.player.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.paused) {
    //   // Release the player's resources when not in use. We use "stop" so that
    //   // if the app resumes later, it will still remember what position to
    //   // resume from.
    //   Instances.player.stop();
    // }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          Instances.player.positionStream,
          Instances.player.bufferedPositionStream,
          Instances.player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchSongState>(builder: (_, networkSong, __) {
      print(Instances.player.playerState);
      print(Instances.player.playing);

      return Material(
        child: Container(
          decoration: const BoxDecoration(
              // color: Colors.red
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.height * 0.1,
              ),
              HeaderPlayingSong(
                onTap: () {
                  networkSong.playSong();
                },
                setTimer: setTimer,
              ),
              SizedBox(
                height: context.height * 0.06,
              ),
              StreamBuilder<SequenceState?>(
                stream: Instances.player.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state?.sequence.isEmpty ?? true) {
                    return const SizedBox();
                  }
                  final metadata = state!.currentSource!.tag as MediaItem;
                  return SizedBox(
                    height: context.height * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //             RotationTransition(
                        //   turns: Tween(begin: 0.0, end: 5.0).animate(_controller),
                        //   child: QueryArtworkWidget(
                        //       id: widget.songmodel[int.parse(snapshot.data.toString())].id,
                        //       type: ArtworkType.AUDIO,
                        //       artworkWidth: 200,
                        //       artworkHeight: 200,
                        //       artworkBorder: BorderRadius.circular(100),
                        //       keepOldArtwork: true,
                        //       nullArtworkWidget: const CircleAvatar(
                        //         radius: 100, // Image radius
                        //         backgroundImage: NetworkImage(
                        //             'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Circle-icons-music.svg/2048px-Circle-icons-music.svg.png'),
                        //       )),
                        // );
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: RotationTransition(
                              turns: Tween(begin: 0.0, end: 5.0)
                                  .animate(_controller),
                              child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(
                                    metadata.artUri.toString(),
                                  )),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                          child: Marquee(
                            velocity: 40,
                            text: metadata.title,
                            style: AppTheme.headLine3,
                            scrollAxis: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ControlButtons(Instances.player),
              StreamBuilder(
                  stream: Instances.player.currentIndexStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text(''),
                      );
                    }
                    return Center(
                      child: Text(
                        snapshot.data.toString(),
                        textAlign: TextAlign.center,
                        style: AppTheme.headLine2,
                      ),
                    );
                  }),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  Instances.currentPosition =
                      positionData?.position ?? Duration.zero;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: (newPosition) {
                      Instances.player.seek(newPosition);
                    },
                  );
                },
              ),
              // Text(  Instances.currentPosition.toString(),style: AppTheme.headLine3),
              // StreamBuilder<PositionData>(
              //   stream: _positionDataStream,
              //   builder: (context, snapshot) {
              //   return Text(snapshot.data?.position.toString()??'00',style: AppTheme.headLine3,);
              //   },
              // ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  StreamBuilder<LoopMode>(
                    stream: Instances.player.loopModeStream,
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
                          Instances.player.setLoopMode(cycleModes[
                              (cycleModes.indexOf(loopMode) + 1) %
                                  cycleModes.length]);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Playlist",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: Instances.player.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? const Icon(Icons.shuffle, color: Colors.orange)
                            : const Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () async {
                          final enable = !shuffleModeEnabled;
                          if (enable) {
                            await Instances.player.shuffle();
                          }
                          await Instances.player.setShuffleModeEnabled(enable);
                        },
                      );
                    },
                  ),
                ],
              ),
              // SizedBox(
              //   height: 240.0,
              //   child: StreamBuilder<SequenceState?>(
              //     stream: Instances.player.sequenceStateStream,
              //     builder: (context, snapshot) {
              //       final state = snapshot.data;
              //       final sequence = state?.sequence ?? [];
              //       return ReorderableListView(
              //         onReorder: (int oldIndex, int newIndex) {
              //           if (oldIndex < newIndex) newIndex--;
              //           _playlist.move(oldIndex, newIndex);
              //         },
              //         children: [
              //           for (var i = 0; i < sequence.length; i++)
              //             Dismissible(
              //               key: ValueKey(sequence[i]),
              //               background: Container(
              //                 color: Colors.blue,
              //                 alignment: Alignment.centerRight,
              //                 child: const Padding(
              //                   padding: EdgeInsets.only(right: 8.0),
              //                   child: Icon(Icons.delete, color: Colors.white),
              //                 ),
              //               ),
              //               onDismissed: (dismissDirection) {

              //                 _playlist.removeAt(i);
              //               },
              //               child: Material(
              //                 color: Colors.transparent,
              //                 child: ListTile(
              //                      tileColor: i == state!.currentIndex
              //                           ? Colors.grey.shade700
              //                           : null,
              //                            trailing:i == state.currentIndex? AudioWave(
              //                     height: 32,
              //                     width: 32,
              //                     spacing: 2.5,
              //                    alignment: 'center',
              //                    animation: true,
              //                    beatRate : const Duration(milliseconds: 200),
              //                     bars: [
              //                       AudioWaveBar(
              //                           heightFactor: 0.5,
              //                           color: Colors.lightBlueAccent),
              //                       AudioWaveBar(
              //                           heightFactor: 0.3, color: Colors.blue),
              //                       AudioWaveBar(
              //                           heightFactor: 0.7, color: Colors.black),
              //                       AudioWaveBar(heightFactor: 0.4),
              //                     ],
              //                   ):null,
              //                   title: Text(sequence[i].tag.title as String,
              //                     style: AppTheme.headLine3),
              //                   onTap: () {
              //                     Instances.player.seek(Duration.zero, index: i);
              //                                                      print(' 123 ${ state.currentIndex}');

              //                   },
              //                 ),
              //               ),
              //             ),
              //         ],
              //       );
              //     },
              //   ),
              // ),
            ],

            // floatingActionButton: FloatingActionButton(
            //   child: const Icon(Icons.add),
            //   onPressed: () {
            //     _playlist.add(AudioSource.uri(
            //       Uri.parse("asset:///audio/nature.mp3"),
            //       tag: AudioMetadata(
            //         album: "Public Domain",
            //         title: "Nature Sounds ${++_addedCount}",
            //         artwork:
            //             "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
            //       ),
            //     ));
            //   },
            // ),
          ),
        ),
      );
    });
  }
}

// class MediaItem {
//   final String album;
//   final String title;
//   final String artwork;

//   MediaItem({
//     required this.album,
//     required this.title,
//     required this.artwork,
//   });
// }