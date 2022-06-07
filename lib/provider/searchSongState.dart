import 'dart:convert';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_mp3_app/provider/baseState.dart';
import 'dart:developer';

import 'package:music_mp3_app/repository/searchSongRepo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchSongState extends BaseState {
  String test = 'var ytInitialData = ';
  bool isLoading = false;
  final searchSongRepo = SearchSongRepo();
  Map<String, dynamic> json = {};
  List<dynamic> listSong = [];
  List<dynamic> listSong1 = [];
  bool isPlaying = false;
  int currentIndexPlaying=0;
    List<AudioSource> playList = [];

  String api = 'aHR0cHM6Ly93d3cueW91dHViZS5jb20vcmVzdWx0cz9zZWFyY2hfcXVlcnk9';
  playSong(){
    isPlaying=!isPlaying;
    notifyListeners();
  }

  getCurrentIndex(int index){
currentIndexPlaying =index;
notifyListeners();
  }
  decode(String linkapi) {
    return utf8.decode(base64.decode(linkapi));
  }

  trimString(String result) {
    int idxStart = result.indexOf("var ytInitialData = ") + test.length;
    result = result.substring(idxStart, result.length);
    int idxEnd = result.indexOf("</script>") - 1;
    result = result.substring(0, idxEnd);
    return result;
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

  Future<dynamic> queryYoutubeApi(String searchText,context) async {
   setLoading(context);
    var result = await searchSongRepo.search(decode(api) + searchText);
    result = trimString(result);
    log('has verticalListRenderer ${result.contains('')}');
    var listItems = [];
    final data = jsonDecode(result);
// log('res: ${data['contents']}');

    if (data['contents']['sectionListRenderer'] != null) {
      listItems.add(data['contents']['sectionListRenderer']['contents']);
      log('listItems1 $listItems');
    } else if (data['contents']['singleColumnBrowseResultsRenderer'] != null) {
      listItems.add(data['contents']['singleColumnBrowseResultsRenderer']);
      log('listItems2 $listItems');
    } else if (data['contents']['twoColumnSearchResultsRenderer'] != null) {
      // log('data ${data['contents']['twoColumnSearchResultsRenderer']['primaryContents']['sectionListRenderer']['contents'][0]['itemSectionRenderer']['contents']}');
      listItems = data['contents']['twoColumnSearchResultsRenderer']
              ['primaryContents']['sectionListRenderer']['contents'][0]
          ['itemSectionRenderer']['contents'];
      log('listItems3 2 length ${listItems.length}');
      //  log('listItems3 2 $listItems');
      log('====================================');
      log('====================================');

// log('listItems3 $listItems');
      // log('listItems $listItems');
    }
        var yt = YoutubeExplode();

    listSong.clear();
    listSong1.clear();
    listSong =
        listItems.where((element) => element['videoRenderer'] != null).toList();
    for (int i = 0; i < listSong.length; i++) {
      listSong1.add({
        'id': '${listSong[i]['videoRenderer']['videoId']}',
        'title': '${listSong[i]['videoRenderer']['title']['runs'][0]['text']}',
        'duration': '0:00',
        'thumbnail':'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Circle-icons-music.svg/1024px-Circle-icons-music.svg.png'
      });
      log('id ${listSong[i]['videoRenderer']['videoId']}');
     var streamInfo = await yt.videos.streamsClient.getManifest(listSong1[i]['id']);

      if (streamInfo.audioOnly.isEmpty) {continue;}
        StreamInfo streamInfo1 = streamInfo.audioOnly.withHighestBitrate();
        print('$i ${streamInfo1.url}');
        
        var stream = yt.videos.streamsClient.get(streamInfo1);
      //Get Duration
      if (listSong[i]['videoRenderer']['lengthText'] != null) {
        if (listSong[i]['videoRenderer']['lengthText']['runs'] != null) {
          listSong1[i]['duration'] =
              listSong[i]['videoRenderer']['lengthText']['runs'][0]['text'];
        }
        if (listSong[i]['videoRenderer']['lengthText']['simpleText'] != null) {
          listSong1[i]['duration'] =
              listSong[i]['videoRenderer']['lengthText']['simpleText'];
        }
      }
      //Get thumbnail

      if (listSong[i]['videoRenderer']["thumbnail"] != null) {
        if (listSong[i]['videoRenderer']["thumbnail"]["thumbnails"] != null) {
          int leng = listSong[i]['videoRenderer']["thumbnail"]["thumbnails"].length;
          if (leng > 0) {
            if (listSong[i]['videoRenderer']["thumbnail"]["thumbnails"][leng -1]['url'] !=
                null) {
                  listSong1[i]['thumbnail']=listSong[i]['videoRenderer']["thumbnail"]["thumbnails"][leng -1]['url'];
            }
          }
        }
      }
      playList.add(AudioSource.uri(streamInfo1.url,
            tag: MediaItem(
                id: i.toString(),
                album: "Đường về",
                title: listSong1[i]['title'],
                artUri: Uri.parse(listSong1[i]['thumbnail']))));
    }
    // log('json $json');
    // log('json $listSong1');
    // log('json ${listSong.length}');
       

    //  log('listSong $listSong');
  
   yt.close();
   setDoneLoading(context);

    notifyListeners();

 }
  getDuration(List test) {}

}
