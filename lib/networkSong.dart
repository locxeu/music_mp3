import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/allSong.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/controlButton.dart';
import 'package:music_mp3_app/database/chillies.dart';
import 'package:music_mp3_app/database/quai_vat_ti_hon.dart';
import 'package:music_mp3_app/enum.dart';
import 'package:music_mp3_app/instance/instance.dart';
import 'package:rxdart/rxdart.dart';

class NetworkSong extends StatefulWidget {
  final List<AudioSource> listAudio;
  const NetworkSong({Key? key,required this.listAudio}) : super(key: key);

  @override
  NetworkSongState createState() => NetworkSongState();
}

class NetworkSongState extends State<NetworkSong> with WidgetsBindingObserver {
  // late AudioPlayer Instances.player;
    var _playlist = null;

  // final _playlist =
  // Remove this audio source from the Windows and Linux version because it's not supported yet
  // if (kIsWeb ||
  //     ![TargetPlatform.windows, TargetPlatform.linux]
  //         .contains(defaultTargetPlatform))
  //    AudioSource.uri(Uri.parse(
  //         "https://data.chiasenhac.com/down2/2170/2/2169036-b7772440/128/Vung%20Ky%20Uc%20Remastered_%20-%20Chillies.mp3"),
  //     tag: AudioMetadata(
  //       album: "Qua Khung Cửa Sổ",
  //       title: "Vùng ký ức",
  //       artwork:
  //           "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",

  //     ),
  //    ),
  // AudioSource.uri(
  //   Uri.parse(
  //       "https://data3.chiasenhac.com/downloads/2127/2/2126153-5a5ec369/128/Duong%20chan%20troi%20-%20Chillies.mp3"),
  //   tag: AudioMetadata(
  //     album: "Qua Khung Cửa Sổ",
  //     title: "Đường chân trời",
  //     artwork:
  //         "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  //   ),
  // ),
  // AudioSource.uri(
  //   Uri.parse("https://data3.chiasenhac.com/downloads/2130/2/2129844-9013b480/128/Qua%20Khung%20Cua%20So%20-%20Chillies.mp3"),
  //   tag: AudioMetadata(
  //     album: "Qua Khung Cửa Sổ",
  //     title: "Qua Khung Cửa Sổ",
  //     artwork:
  //         "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  //   ),
  // ),
  // AudioSource.uri(
  //   Uri.parse("https://data.chiasenhac.com/down2/2232/2/2231724-68fd3f3c/128/Co%20Em%20Doi%20Bong%20Vui%20-%20Chillies.mp3"),
  //   tag: AudioMetadata(
  //     album: "Qua Khung Cửa Sổ",
  //     title: "Có em đời bỗng vui",
  //     artwork:
  //         "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  //   ),
  // ),

  int _addedCount = 0;

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    // Instances.player = Instances.player;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }
  // Future<void> loadNetworkSource async(){
         
  // }

  Future<void> _init() async {
    _playlist= ConcatenatingAudioSource(
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
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Instances.player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      Instances.player.stop();
    }
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back_ios_new)),
              // InkWell(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => AllSong()),
              //       );
              //     },
              //     child: Text('to local',style: TextStyle(fontSize: 20),)),
              Expanded(
                child: StreamBuilder<SequenceState?>(
                  stream: Instances.player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) {
                      return const SizedBox();
                    }
                    final metadata = state!.currentSource!.tag as AudioMetadata;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Center(child: Image.network(metadata.artwork)),
                          ),
                        ),
                        Text(metadata.album,
                            style: Theme.of(context).textTheme.headline6),
                        Text(metadata.title),
                      ],
                    );
                  },
                ),
              ),
              ControlButtons(Instances.player),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
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
              SizedBox(
                height: 240.0,
                child: StreamBuilder<SequenceState?>(
                  stream: Instances.player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final sequence = state?.sequence ?? [];
                    return ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        if (oldIndex < newIndex) newIndex--;
                        _playlist.move(oldIndex, newIndex);
                      },
                      children: [
                        for (var i = 0; i < sequence.length; i++)
                          Dismissible(
                            key: ValueKey(sequence[i]),
                            background: Container(
                              color: Colors.blue,
                              alignment: Alignment.centerRight,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            onDismissed: (dismissDirection) {
                              _playlist.removeAt(i);
                            },
                            child: Material(
                              color: i == state!.currentIndex
                                  ? Colors.grey.shade300
                                  : null,
                              child: ListTile(
                                title: Text(sequence[i].tag.title as String),
                                onTap: () {
                                  Instances.player.seek(Duration.zero, index: i);
                                },
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _playlist.add(AudioSource.uri(
              Uri.parse("asset:///audio/nature.mp3"),
              tag: AudioMetadata(
                album: "Public Domain",
                title: "Nature Sounds ${++_addedCount}",
                artwork:
                    "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
              ),
            ));
          },
        ),
      ),
    );
  }
}



class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata({
    required this.album,
    required this.title,
    required this.artwork,
  });
}
