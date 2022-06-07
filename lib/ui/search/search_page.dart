import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/extension/extension.dart';
import 'package:music_mp3_app/networkSong.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchText = TextEditingController();
  late String str;
  List<AudioSource> playList = [];
  void handleString() {}
// late YoutubePlayerController ytController;

  @override
  void initState() {
    // ytController= YoutubePlayerController(initialVideoId: '_MhCtjASXZA',
    // flags: const YoutubePlayerFlags(
    //   autoPlay: true,
    //   startAt: 20,
    //   // hideThumbnail: true,
    //   // hideControls: true
    // )
    // );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchText.dispose();
  }

  Future<void> testaudio(List<dynamic> song) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchSongState>(builder: (_, searchState, __) {
      return searchState.isPlaying? NetworkSong(listAudio:searchState.playList, ): Column(children: [
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
            controller: searchText,
            decoration: InputDecoration(
              icon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                    onTap: () async {
                      print('searchText ${searchText.text}');
                      await searchState.queryYoutubeApi(
                          searchText.text, context);
                      // testaudio(searchState.listSong1);
                    },
                    child: const Icon(Icons.search)),
              ),
              border: InputBorder.none,
              hintText: 'Nghệ sĩ, bài hát,...',
            ),
          ),
        ),
        searchState.isLoading
            ? const CircularProgressIndicator()
            :
            //  Text(searchState.listSong.length.toString())
            Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: searchState.listSong1.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Instances.player.seek(Duration.zero, index: index);
                          searchState.playSong();
                          searchState.getCurrentIndex(index);
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ChangeNotifierProvider(
            // create: (context) => SearchSongState(),
            // builder: (context, child) =>  NetworkSong(listAudio: playList,index: index,))),
            //               );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                searchState.listSong1[index]['thumbnail']),
                          ),
                          title: SizedBox(
                              width: context.width * 0.7,
                              child: Text(
                                searchState.listSong1[index]['title'],
                                style: AppTheme.headLine2,
                                maxLines: 1,
                              )),
                          subtitle: Text(
                              searchState.listSong1[index]['duration'],
                              style: AppTheme.headLine5),
                          // trailing: Icon(Icons.h_plus_mobiledata),
                        ),
                      );
                    })),
      ]);
    });
  }
}
