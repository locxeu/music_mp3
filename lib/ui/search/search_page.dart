import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';
import 'package:music_mp3_app/extension/extension.dart';
import 'package:music_mp3_app/instance/instance.dart';
import 'package:music_mp3_app/networkSong.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:music_mp3_app/ui/widget/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with WidgetsBindingObserver {
  final TextEditingController searchText = TextEditingController();
  late String str;
  var _playlist;
  var playListSong;
  bool isLoadedSoure = false;
  void handleString() {}
  Future<void> _init() async {
    log('init run');
    if (playListSong != null) {
      _playlist = ConcatenatingAudioSource(
        children: [
          for (var i = 0; i < playListSong.length; i++) playListSong[i]
        ],
      );
    } else {
      _playlist = ConcatenatingAudioSource(
        children: [
          for (var i = 0;
              i < context.read<SearchSongState>().listSong1.length;
              i++)
            context.read<SearchSongState>().listSong1[i]
        ],
      );
    }

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
          initialPosition: Instances.currentPosition,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);

      // await  Instances.player.seek(Duration.zero,index:context.read<SearchSongState>().currentIndexPlaying);

    } catch (e) {
      // Catch load errors: 404, invalid url...
      log("Error loading audio source: $e");
      showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBox(
              title: 'ALERT',
              descriptions: e.toString(),
              text: 'OK',
              imageFile: Images.error
            );
          });
    }
  }

  static testaudio(List<dynamic> song) async {
    List<AudioSource> playList = [];
    var yt = YoutubeExplode();
    for (int i = 0; i < song.length; i++) {
      var streamInfo = await yt.videos.streamsClient.getManifest(song[i]['id']);

      if (streamInfo.audioOnly.isNotEmpty) {
        StreamInfo streamInfo1 = streamInfo.audioOnly.withHighestBitrate();
        print('$i ${streamInfo1.url}');
        playList.add(AudioSource.uri(streamInfo1.url,
            tag: MediaItem(
                id: i.toString(),
                album: "Đường về",
                title: song[i]['title'],
                artUri: Uri.parse(song[i]['thumbnail']))));
        var stream = yt.videos.streamsClient.get(streamInfo1);
      }
    }
    yt.close();
    return playList;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    // Instances.player = Instances.player;
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.black,
    // ));
    if (!Instances.player.playing) {
      _init();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);

    searchText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(isLoadedSoure);
    return Consumer<SearchSongState>(builder: (_, searchState, __) {
      return searchState.isPlaying
          ? NetworkSong(
              listAudio: searchState.playList,
            )
          : Column(children: [
              SizedBox(
                height: context.height * 0.06,
              ),
              Text(
                'Tìm kiếm',
                style: AppTheme.headLine1,
              ),
              Container(
                margin: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  onFieldSubmitted: (value) async {
                    print('run');
                var result=  await searchState.getRawAudioUrl();
                // log('result $result');
                await searchState.getAudioUrl(result);

                    // await searchState.queryYoutubeApi(searchText.text, context);
                    //        setState(() {
                    //                 isLoadedSoure = false;
                    //       });
                  },
                  controller: searchText,
                  decoration: InputDecoration(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                          onTap: () async {
                            // print('searchText ${searchText.text}');
                            // await searchState.queryYoutubeApi(
                            //     searchText.text, context);
                            //  playListSong = await compute(
                            //                                   testaudio, searchState.listSong1,);
                            // testaudio(searchState.listSong1);
                            // print('_playlist ${_playlist.toString()}');
                            //  await _init();
                          },
                          child: const Icon(Icons.search)),
                    ),
                    border: InputBorder.none,
                    hintText: 'Nghệ sĩ, bài hát,...',
                  ),
                ),
              ),
              //  Text(searchState.listSong.length.toString())
              Expanded(
                  child: StreamBuilder<SequenceState?>(
                      stream: Instances.player.sequenceStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        final sequence = state?.sequence ?? [];
                        if (state == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: searchState.listSong1.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                searchState.playSong();
                                  if (isLoadedSoure) {
                                    await Instances.player
                                        .seek(Duration.zero, index: index);
                                    await Instances.player.play();
                                    return;
                                  }
                                  await searchState.getAudio(
                                      searchState.listSong1, index);
                                  playListSong = await compute(
                                    testaudio,
                                    searchState.listSong1,
                                  );
                                  await _init();
                                  setState(() {
                                    isLoadedSoure = true;
                                  });
                               },
                                child: Material(
                                  color: Colors.transparent,
                                  child: ListTile(
                                    tileColor: index == state.currentIndex
                                        ? Colors.grey.shade800
                                        : null,
                                    leading: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(searchState
                                          .listSong1[index]['thumbnail']),
                                    ),
                                    title: SizedBox(
                                        width: context.width * 0.7,
                                        child: Text(
                                          searchState.listSong1[index]['title'],
                                          style: AppTheme.headLine2,
                                          maxLines: 1,
                                        )),
                                    subtitle: Text(
                                        searchState.listSong1[index]
                                            ['duration'],
                                        style: AppTheme.headLine5),
                                    // trailing: Icon(Icons.h_plus_mobiledata),
                                  ),
                                ),
                              );
                            });
                      })),
            ]);
    });
  }
}
