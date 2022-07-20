import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
import 'package:share_plus/share_plus.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class SearchPage extends StatefulWidget {
  final String? searchText;
  const SearchPage({Key? key, this.searchText}) : super(key: key);

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

  // * Funtion add song to playist source
  Future<void> _init() async {
    log('init run');

    if (playListSong != null) {
      log('playListSong $playListSong');
      _playlist = ConcatenatingAudioSource(
        children: [
          for (var i = 0; i < playListSong.length; i++) playListSong[i]
        ],
      );
    } else {
      log('playListSong123 $playListSong');

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
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return CustomDialogBox(
                  title: 'ALERT',
                  descriptions: e.toString(),
                  text: 'OK',
                  imageFile: Images.error);
            });
      }
    }
  }

  // * Funtion get url video
  static addToPlayist(List<dynamic> song) async {
    List<AudioSource> playList = [];
    var yt = YoutubeExplode();
    for (int i = 0; i < song.length; i++) {
      var result = await SearchSongState().getRawAudioUrl(song[i]['id']);
      var urlVideo = await SearchSongState().getAudioUrl(result);

      // var streamInfo = await yt.videos.streamsClient.getManifest(song[i]['id']);

      // if (streamInfo.audioOnly.isNotEmpty) {
      //   StreamInfo streamInfo1 = streamInfo.audioOnly.withHighestBitrate();
      // print('$i $urlVideo');
      playList.add(
        AudioSource.uri(
          Uri.parse(urlVideo),
          tag: MediaItem(
            id: i.toString(),
            album: "Đường về",
            title: song[i]['title'],
            artUri: Uri.parse(
              song[i]['thumbnail'],
            ),
          ),
        ),
      );
      //   var stream = yt.videos.streamsClient.get(streamInfo1);
      // }
    }
    yt.close();
    return playList;
  }

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((_) => {
          if (widget.searchText != null)
            {
              context
                  .read<SearchSongState>()
                  .queryYoutubeApi(widget.searchText.toString(), context),
              setState(() {
                context.read<SearchSongState>().isLoadedSoure = false;
              })
            }
        });

    if (!Instances.player.playing) {
      log('alo alo');
      context.read<SearchSongState>().listSong1.clear();
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<SearchSongState>(builder: (_, searchState, __) {
          log('searchState.playList ${searchState.playList}');
          log('searchState.playList ${searchState.isDetailSongPlaying}');

          return searchState.isDetailSongPlaying
              ? NetworkSong(
                  listAudio: searchState.playList,
                )
              : Column(
                  children: [
                    SizedBox(
                      height: context.height * 0.06,
                    ),
                    widget.searchText == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        searchState.listSong1.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    Text(
                                      widget.searchText!.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                    widget.searchText != null
                        ? const SizedBox.shrink()
                        : Text(
                            'Tìm kiếm',
                            style: AppTheme.headLine1,
                          ),
                    widget.searchText != null
                        ? const SizedBox.shrink()
                        : Container(
                            margin: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: AppTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              onFieldSubmitted: (value) async {
                                await searchState.queryYoutubeApi(
                                    searchText.text, context);
                                setState(() {
                                  searchState.isLoadedSoure = false;
                                });
                              },
                              controller: searchText,
                              decoration: InputDecoration(
                                icon: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
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
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                itemCount: searchState.listSong1.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      searchState.playSong();
                                      searchState.getCurrentIndex(index);
                                      //! Khi load xong source bài check để chuyển sang bài mới luôn
                                      if (searchState.isLoadedSoure) {
                                        await Instances.player.seek(
                                          Duration.zero,
                                          index: index,
                                        );
                                        await Instances.player.play();
                                        return;
                                      }
                                      await searchState.getAudio(
                                        searchState.listSong1,
                                        index,
                                      );
                                      // playListSong=await testaudio( searchState.listSong1,);
                                      playListSong = await compute(
                                        addToPlayist,
                                        searchState.listSong1,
                                      );
                                      searchState.playList = playListSong;
                                      await _init();
                                      searchState.isLoadedSoure = true;
                                      log('đã load xong source');
                                    },
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {},
                                            icon: Icons.queue_music,
                                            backgroundColor: Colors.blueAccent,
                                          ),
                                          SlidableAction(
                                            onPressed: (context) async{
                                               String youtubeLink ='https://www.youtube.com/watch?v=';
                                              log(searchState.listSong1[index]['id']);
                                              await Share.share('Hello ${youtubeLink+searchState.listSong1[index]['id']}');
                                            },
                                            icon: Icons.share_rounded,
                                            backgroundColor:
                                                const Color(0xFF0caec7),
                                          )
                                        ],
                                        motion: const StretchMotion(),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Container(
                                                color:
                                                    index == state.currentIndex
                                                        ? Colors.grey.shade900
                                                        : null,
                                                child: Row(children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      child: Image.network(
                                                        searchState.listSong1[
                                                            index]['thumbnail'],
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            searchState
                                                                    .listSong1[
                                                                index]['title'],
                                                            style: AppTheme
                                                                .headLine7,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            searchState.listSong1[
                                                                    index]
                                                                ['duration'],
                                                            style: AppTheme
                                                                .headLine6,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: AppTheme
                                                        .backgroundColor,
                                                    size: 20,
                                                  )
                                                ]),
                                              ),
                                              Divider(
                                                thickness: 0.5,
                                                color: Colors.grey.shade500,
                                                indent: 65,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //  ListTile(
                                        //   tileColor: index == state.currentIndex
                                        //       ? Colors.grey.shade800
                                        //       : null,
                                        //   leading: CircleAvatar(
                                        //     radius: 50,
                                        //     backgroundImage: NetworkImage(
                                        //       searchState.listSong1[index]
                                        //           ['thumbnail'],
                                        //     ),
                                        //   ),
                                        //   title: SizedBox(
                                        //     width: context.width * 0.7,
                                        //     child: Text(
                                        //       searchState.listSong1[index]
                                        //           ['title'],
                                        //       style: AppTheme.headLine2,
                                        //       maxLines: 1,
                                        //     ),
                                        //   ),
                                        //   subtitle: Text(
                                        //     searchState.listSong1[index]
                                        //         ['duration'],
                                        //     style: AppTheme.headLine5,
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
