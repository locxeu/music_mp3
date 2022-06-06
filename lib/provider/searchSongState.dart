import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:music_mp3_app/repository/searchSongRepo.dart';

class SearchSongState extends ChangeNotifier {
  String test = 'var ytInitialData = ';
  final searchSongRepo = SearchSongRepo();
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

  Future<dynamic> queryYoutubeApi(String searchText) async {
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
      log('====================================');
      log('====================================');

// log('listItems3 $listItems');
      // log('listItems $listItems');
      List<Map<String, dynamic>> jsonResults = [];
      for (int i = 0; i < listItems.length; i++) {
//
//  log('listItems $i ====> ${listItems[i]['videoRenderer']}');
//  log('==============cccxxxxccc======================');
        if (listItems[i]['videoRenderer'] != null) {
          log('index $i ${listItems[i]['videoRenderer']['videoId']}');
          jsonResults
              .add({'id': '${listItems[i]['videoRenderer']['videoId']}'});
          jsonResults.add({
            'title':
                '${listItems[i]['videoRenderer']['title']['runs'][0]['text']}'
          });
        }
//   log('listItems ${listItems[0]['longBylineText']}');
//   log('listItems ${listItems[0]['publishedTimeText']}');

      }
      print('json $jsonResults');
    }
  }
}
