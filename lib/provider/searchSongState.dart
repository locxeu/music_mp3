import 'dart:convert';

import 'package:music_mp3_app/provider/baseState.dart';
import 'dart:developer';

import 'package:music_mp3_app/repository/searchSongRepo.dart';

class SearchSongState extends BaseState {
  String test = 'var ytInitialData = ';
  bool isLoading = false;
  final searchSongRepo = SearchSongRepo();
  Map<String, dynamic> json = {};
  List<dynamic> listSong = [];
  List<dynamic> listSong1 = [];

  String api = 'aHR0cHM6Ly93d3cueW91dHViZS5jb20vcmVzdWx0cz9zZWFyY2hfcXVlcnk9';
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
    }
    log('json $json');
    log('json $listSong1');
    log('json ${listSong.length}');
   setDoneLoading(context);

    //  log('listSong $listSong');
    notifyListeners();
  }

  getDuration(List test) {}
}
