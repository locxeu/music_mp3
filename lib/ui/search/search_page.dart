import 'package:flutter/material.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/extension/extension.dart';
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

  Future<void> testaudio() async {
    var yt = YoutubeExplode();
    var streamInfo = await yt.videos.streamsClient.getManifest('4JLe7s976k0');
    StreamInfo streamInfo1 = streamInfo.audioOnly.withHighestBitrate();
    print(streamInfo);
    print(streamInfo1.url);
    var stream = yt.videos.streamsClient.get(streamInfo1);
    // Close the YoutubeExplode's http client.
    yt.close();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchSongState>(builder: (_, searchState, __) {
      return Column(children: [
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
                    onTap: () {
                      print('searchText ${searchText.text}');
                   searchState.queryYoutubeApi(searchText.text);
                    },
                    child: const Icon(Icons.search)),
              ),
              border: InputBorder.none,
              hintText: 'Nghệ sĩ, bài hát,...',
            ),
          ),
        ),
     searchState.isLoading?const CircularProgressIndicator(): 
    //  Text(searchState.listSong.length.toString())
      Expanded(
            child: ListView.builder(
                itemCount: searchState.listSong1.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                        searchState.listSong1[index]['thumbnail']),
                    title: Text(searchState.listSong1[index]['title'],style: AppTheme.headLine3),
                    subtitle: Text(searchState.listSong1[index]['duration'],style: AppTheme.headLine3),
                  );
                })),
      ]);
    });
  }
}
