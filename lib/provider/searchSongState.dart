import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:music_mp3_app/repository/searchSongRepo.dart';

class SearchSongState extends ChangeNotifier {
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

  Future<dynamic> queryYoutubeApi(String searchText) async {
    isLoading = true;
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
      if (listSong[i]['videoRenderer']['lengthText'] != null) {
        print('null');
        if (listSong[i]['videoRenderer']['lengthText']['runs'] != null) {
          print('here');
          listSong1[i]['duration'] =
              listSong[i]['videoRenderer']['lengthText']['runs'][0]['text'];
        }
        if (listSong[i]['videoRenderer']['lengthText']['simpleText'] != null) {
          print('hello');
          listSong1[i]['duration'] =
              listSong[i]['videoRenderer']['lengthText']['simpleText'];
        }
      }

      if (listSong[i]['videoRenderer']["thumbnail"] != null) {
//                        System.out.println("log1 ");
//                        System.out.println(itemSong.optJSONObject("thumbnail"));
        if (listSong[i]['videoRenderer']["thumbnail"]["thumbnails"] != null) {
//                            System.out.println("log2 ");
          int leng = listSong[i]['videoRenderer']["thumbnail"]["thumbnails"].length;
          if (leng > 0) {
//                                System.out.println("log3 ");
//                                System.out.println(itemSong.getJSONObject("thumbnail").getJSONArray("thumbnails").getJSONObject(leng - 1));
            if (listSong[i]['videoRenderer']["thumbnail"]["thumbnails"][leng -1]['url'] !=
                null) {
                  listSong1[i]['thumbnail']=listSong[i]['videoRenderer']["thumbnail"]["thumbnails"][leng -1]['url'];
//                                    System.out.println("log4 ");
//                                    System.out.println(itemSong.getJSONObject("thumbnail").getJSONArray("thumbnails").getJSONObject(leng - 1).getString("url"));

            }
          }
        }
      }
    }
//       for (int i = 0; i < listItems.length; i++) {
// //  log('listItems $i ====> ${listItems[i]['videoRenderer']}');
// //  log('==============cccxxxxccc======================');
//         // if (listItems[i]['videoRenderer'] != null) {
//         //   log('index $i ${listItems[i]['videoRenderer']['videoId']}');

//         //   listSong
//         //       .add({'id': '${listItems[i]['videoRenderer']['videoId']}','title':
//         //         '${listItems[i]['videoRenderer']['title']['runs'][0]['text']}','duration':''});
//         //   //       listSong.addAll(json['id']);
//         //     //  listSong.addAll({'duration':'${listItems[i]['videoRenderer']['videoId']}'})
//         // }
//    listSong
//               .add({'id': '${listSong[i]['videoRenderer']['videoId']}','title':
//                 '${listSong[i]['videoRenderer']['title']['runs'][0]['text']}','duration':''});
//                 listSong[i]['duration']=listSong[i]['videoRenderer']['videoId'];

// //   if(listSong[i]["lengthText"] == null){
// //     return
// //   }
// //                         if(listSong[i]['lengthText']['runs'] != null) {
// //                             obj.put("duration", listSong.getJSONObject("lengthText").getJSONArray("runs").getJSONObject(0).get("text").toString());
// //                         }else if(listSong.getJSONObject("lengthText").optString("simpleText") != null) {
// //                             obj.put("duration", listSong.getJSONObject("lengthText").get("simpleText").toString());
// //                         }else{
// //                             System.out.println("NULL DURATION");
// // //                            System.out.println(listSong.getJSONObject("lengthText"));
// //                             obj.put("duration","00:00");
// //                         }
// //                     }else{
// //                         obj.put("duration","00:00");
// //                     }
//       }

    log('json $json');
    log('json $listSong1');
    log('json ${listSong.length}');

    isLoading = false;
    //  log('listSong $listSong');
    notifyListeners();
  }

  getDuration(List test) {}
}
