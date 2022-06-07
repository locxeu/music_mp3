
import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/custom_message/awsome_snack_bar.dart';
import 'package:music_mp3_app/custom_message/content_type.dart';
import 'package:music_mp3_app/instance/instance.dart';
import 'package:music_mp3_app/testDetailSong.dart';
import 'package:music_mp3_app/ui/widget/custom_dialog.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:music_mp3_app/extension/extension.dart';
class LocalPage extends StatefulWidget {
  const LocalPage({Key? key}) : super(key: key);

  @override
  State<LocalPage> createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  List<AudioSource> localAudioSource = [];
  var playlist;
  List<SongModel> listLocalSong = [];
  bool isTabPlay = false;
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          Instances.player.positionStream,
          Instances.player.bufferedPositionStream,
          Instances.player.durationStream,
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
      if(listLocalSong.isEmpty){
        showDialog(
          context: context,
          builder: (context) {
            return AwesomeSnackbarContent(
              title: 'On Sorry!',
              message: 'No Song Were Found!',
              contentType: ContentType.failure,
            );
          });
      }
      for (var i = 0; i < listLocalSong.length; i++) {
        localAudioSource.add(
          AudioSource.uri(
            Uri.parse(listLocalSong[i].uri!),
            tag: MediaItem(
              album: listLocalSong[i].album!,
              title: listLocalSong[i].displayNameWOExt,
              // artwork: listLocalSong[i].id.toString(),
              id: listLocalSong[i].id.toString()
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

  // late AudioPlayer Instances.player;
  @override
  void initState() {
    // TODO: implement initState
    requestPermission();
    // Instances.player = AudioPlayer();
    _init();
    super.initState();

    // ganB();
  }

  Future<void> _init() async {
    await ganB();
    // final session = await AudioSession.instance;
    // await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    Instances.player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      log('khong loi');
      // Preloading audio is not currently supported on Linux.
      await Instances.player.setAudioSource(playlist,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
          if(localAudioSource.isEmpty){
             showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBox( title: 'Oh Sorry', descriptions: 'No song were found'.toString(), text: 'OK',);
          });
          }
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
      showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBox( title: 'ALERT', descriptions: e.toString(), text: 'OK',);
          });
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


  final _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    print('init state ???');
    return !isTabPlay
        ? Column(
            children: [
             SizedBox(
               height: context.height*0.06,
             ),
              Text('Local Source Music',style: AppTheme.headLine2,),
              Expanded(
                child: StreamBuilder<SequenceState?>(
                  stream: Instances.player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final sequence = state?.sequence ?? [];
                    if(sequence.isEmpty){
                      return Center(child: Text('',style: AppTheme.headLine2,),);
                    }
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
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            onDismissed: (dismissDirection) {
                              playlist.removeAt(i);
                            },
                            child: Column(children: [
                              Material(
                                color: Colors.transparent,
                                child: ListTile(
                                  tileColor: 
                                  i == state!.currentIndex?
                                   Colors.grey.shade800
                                      : null,
                                  leading: QueryArtworkWidget(
                                    id: listLocalSong[i].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: Image.asset(
                                        'assets/images/music_icon.png'),
                                  ),
                                  title: Text(sequence[i].tag.title as String,style: AppTheme.headLine3,),
                                  onTap: () {
                                    Instances.player.seek(Duration.zero, index: i);
                                    setState(() {
                                      isTabPlay = true;
                                    });
                                  },
                                ),
                              ),
                               Divider(
                                color: AppTheme.subTitle,
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
        //                 Instances.player.play();
        //                 print('Instances.player.hasNext ${Instances.player.hasNext}');
        //                 print('Instances.player.hasPrevious ${Instances.player.hasPrevious}');
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

        : DetailSong2(
            audioPlayer: Instances.player,
            onTap: changeStatus,
            songmodel: listLocalSong,
            positionData: _positionDataStream,
          );
  }
}
