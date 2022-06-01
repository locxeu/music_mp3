import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/controlButton.dart';
import 'package:music_mp3_app/detail_song.dart';
import 'package:music_mp3_app/networkSong.dart';
import 'package:music_mp3_app/testDetailSong.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class AllSong extends StatefulWidget {
  const AllSong({Key? key}) : super(key: key);

  @override
  State<AllSong> createState() => _AllSongState();
}

class _AllSongState extends State<AllSong> {
  List<AudioSource> localAudioSource = [];
  var playlist = null;
  List<SongModel> listLocalSong = [];
  bool isTabPlay = false;
    Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  Future<List<SongModel>> test() async {
    return _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);
  }

  ganB() async {
    await test().then((value) {
      listLocalSong = value;
      print('b $listLocalSong');
      for (var i = 0; i < listLocalSong.length; i++) {
        localAudioSource.add(
          AudioSource.uri(
            Uri.parse(listLocalSong[i].uri!),
            tag: AudioMetadata(
              album: listLocalSong[i].album!,
              title: listLocalSong[i].displayNameWOExt,
              artwork: listLocalSong[i].id.toString(),
            ),
          ),
        );
      }
      playlist = ConcatenatingAudioSource(
        children: [
          for (var i = 0; i < listLocalSong.length; i++) localAudioSource[i]
        ],
      );
      print('playlist $playlist');
    });
  }

  late AudioPlayer _player;
  @override
  void initState() {
    // TODO: implement initState
    requestPermission();
    _player = AudioPlayer();
    _init();
    super.initState();

    // ganB();
  }

  Future<void> _init() async {
    await ganB();
    // final session = await AudioSession.instance;
    // await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      // Preloading audio is not currently supported on Linux.
      await _player.setAudioSource(playlist,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
    }
  }

  void requestPermission() {
    Permission.storage.request();
  }

  void changeStatus() {
    setState(() {
      isTabPlay = !isTabPlay;
    });
  }

  final _audioQuery = new OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    print('init state ???');
    return !isTabPlay
        ? SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: Text('mp3'),
                ),
                body: Column(
                  children: [
                    // ControlButtons(_player),
                    Expanded(
                      child: StreamBuilder<SequenceState?>(
                        stream: _player.sequenceStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          final sequence = state?.sequence ?? [];
                          return ListView(
                            //  onReorder: (int oldIndex, int newIndex) {
                            //    if (oldIndex < newIndex) newIndex--;
                            //    playlist.move(oldIndex, newIndex);
                            //  },
                            children: [
                              for (var i = 0; i < sequence.length; i++)
                                Dismissible(
                                  key: ValueKey(sequence[i]),
                                  background: Container(
                                    color: Colors.blue,
                                    alignment: Alignment.centerRight,
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onDismissed: (dismissDirection) {
                                    playlist.removeAt(i);
                                  },
                                  child: Column(children: [
                                    ListTile(
                                      tileColor: i == state!.currentIndex
                                          ? Colors.grey.shade300
                                          : null,
                                      leading: QueryArtworkWidget(
                                        id: listLocalSong[i].id,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: Image.asset(
                                            'assets/images/music_icon.png'),
                                      ),
                                      title:
                                          Text(sequence[i].tag.title as String),
                                      onTap: () {
                                        _player.seek(Duration.zero, index: i);
                                        setState(() {
                                          isTabPlay = true;
                                        });
                                      },
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      indent: 80,
                                      height: 10,
                                    )
                                  ]),
                                ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
                // FutureBuilder<List<SongModel>>(
                //   future: _audioQuery.querySongs(
                //       sortType: null,
                //       orderType: OrderType.ASC_OR_SMALLER,
                //       uriType: UriType.EXTERNAL,
                //       ignoreCase: true),
                //   builder: (context, item) {
                //     if (item.data == null) {
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //     if (item.data!.isEmpty) {
                //       return const Center(
                //         child: Text('No song'),
                //       );
                //     }
                //     return ListView.builder(
                //       itemBuilder: (context, index) {
                //         return Column(
                //           children: [
                //             ListTile(
                //               onTap: () {
                //                 _player.play();
                //                 print('_player.hasNext ${_player.hasNext}');
                //                 print('_player.hasPrevious ${_player.hasPrevious}');
                //                 // Navigator.push(
                //                 //   context,
                //                 //   MaterialPageRoute(
                //                 //       builder: (context) => DetailSong(
                //                 //             songModel: item.data!,
                //                 //             audioPlayer: _audioPlayer,
                //                 //             index: index,
                //                 //           )),
                //                 // );
                //               },
                //               leading: QueryArtworkWidget(
                //                 id: item.data![index].id,
                //                 type: ArtworkType.AUDIO,
                //                 nullArtworkWidget:
                //                     Image.asset('assets/images/music_icon.png'),
                //               ),
                //               title: Text(item.data![index].displayName),
                //               subtitle: Text(item.data![index].artist ?? 'Unknow Artist'),
                //               trailing: const Icon(Icons.more_horiz),
                //             ),
                //             const Divider(
                //               thickness: 1,
                //               indent: 80,
                //             )
                //           ],
                //         );
                //       },
                //       itemCount: item.data!.length,
                //     );
                //   },
                // ),
                ),
          )
        : DetailSong2(
            audioPlayer: _player,
            onTap: changeStatus,
            songmodel: listLocalSong,
            positionData: _positionDataStream,
          );
  }
}
