import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';
import 'package:music_mp3_app/config/values/app_api.dart';
import 'package:music_mp3_app/instance/instance.dart';
import 'package:music_mp3_app/provider/baseState.dart';
import 'dart:developer';

import 'package:music_mp3_app/repository/searchSongRepo.dart';
import 'package:music_mp3_app/ui/widget/custom_dialog.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchSongState extends BaseState {
  String test = 'var ytInitialData = ';
  bool isLoading = false;
  final searchSongRepo = SearchSongRepo();
  Map<String, dynamic> json = {};
  List<dynamic> listSong = [];
  List<dynamic> listSong1 = [];
  bool isPlaying = false;
  int currentIndexPlaying = 0;
  List<AudioSource> playList = [];

  String api = 'aHR0cHM6Ly93d3cueW91dHViZS5jb20vcmVzdWx0cz9zZWFyY2hfcXVlcnk9';
  String urlBase = 'aHR0cHM6Ly93d3cueW91dHViZS5jb20=';
  playSong() {
    isPlaying = !isPlaying;
    log('message');
    notifyListeners();
  }

  getCurrentIndex(int index) {
    currentIndexPlaying = index;
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

  Future<void> getAudio(List<dynamic> song, int index) async {
    log('index hiện tại là $index');
    var yt = YoutubeExplode();
    getCurrentIndex(index);
    log('$index id  ${song[index]['id']}');
    var streamInfo =
        await yt.videos.streamsClient.getManifest(song[index]['id']);
    if (streamInfo.audioOnly.isNotEmpty) {
      StreamInfo streamInfo1 = streamInfo.audioOnly.withHighestBitrate();
      print('$index ${streamInfo1.url}');
      playList.clear();
      playList.add(AudioSource.uri(streamInfo1.url,
          tag: MediaItem(
              id: index.toString(),
              album: "Đường về",
              title: song[index]['title'],
              artUri: Uri.parse(song[index]['thumbnail']))));
      Instances.player.setAudioSource(playList[0]);
      Instances.player.play();
      log('title ${song[index]['title']}');
      log('playList ${playList[0]}');
      log('haha');
    }
    yt.close();
  }

  Future<dynamic> queryYoutubeApi(String searchText, context) async {
    setLoading(context);
    try {
      var result =
          await searchSongRepo.search(decode(AppApi().urlSearch) + searchText);
      result = trimString(result);
      var listItems = [];
      final data = jsonDecode(result);

      if (data['contents']['sectionListRenderer'] != null) {
        listItems = data['contents']['sectionListRenderer']['contents'];
        log('listItems1 $listItems');
      } else if (data['contents']['singleColumnBrowseResultsRenderer'] !=
          null) {
        listItems = data['contents']['singleColumnBrowseResultsRenderer'];
        log('listItems2 $listItems');
      } else if (data['contents']['twoColumnSearchResultsRenderer'] != null) {
        // log('data ${data['contents']['twoColumnSearchResultsRenderer']['primaryContents']['sectionListRenderer']['contents'][0]['itemSectionRenderer']['contents']}');
        listItems = data['contents']['twoColumnSearchResultsRenderer']
                ['primaryContents']['sectionListRenderer']['contents'][0]
            ['itemSectionRenderer']['contents'];
        //  log('listItems3 $listItems');
      }
      var yt = YoutubeExplode();
      listSong.clear();
      listSong1.clear();
      playList.clear();
      listSong = listItems
          .where((element) => element['videoRenderer'] != null)
          .toList();
      for (int i = 0; i < listSong.length; i++) {
        log('run in here');
        listSong1.add({
          'id': '${listSong[i]['videoRenderer']['videoId']}',
          'title':
              '${listSong[i]['videoRenderer']['title']['runs'][0]['text']}',
          'duration': '0:00',
          'thumbnail':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Circle-icons-music.svg/1024px-Circle-icons-music.svg.png'
        });
        log('hinh nhu khong run in here');
        log('id ${listSong[i]['videoRenderer']['videoId']}');
        //  var streamInfo = await yt.videos.streamsClient.getManifest(listSong1[i]['id']);
        //  var streamInfo = await yt.videos.streamsClient.getManifest(listSong1[i]['id']);

        //   if (streamInfo.audioOnly.isEmpty) {continue;}
        //     StreamInfo streamInfo1 = streamInfo.audioOnly.withHighestBitrate();
        // print('$i ${}');

        //Get Duration
        if (listSong[i]['videoRenderer']['lengthText'] != null) {
          if (listSong[i]['videoRenderer']['lengthText']['runs'] != null) {
            listSong1[i]['duration'] =
                listSong[i]['videoRenderer']['lengthText']['runs'][0]['text'];
          }
          if (listSong[i]['videoRenderer']['lengthText']['simpleText'] !=
              null) {
            listSong1[i]['duration'] =
                listSong[i]['videoRenderer']['lengthText']['simpleText'];
          }
        }
        //Get thumbnail

        if (listSong[i]['videoRenderer']["thumbnail"] != null) {
          if (listSong[i]['videoRenderer']["thumbnail"]["thumbnails"] != null) {
            int leng =
                listSong[i]['videoRenderer']["thumbnail"]["thumbnails"].length;
            if (leng > 0) {
              if (listSong[i]['videoRenderer']["thumbnail"]["thumbnails"]
                      [leng - 1]['url'] !=
                  null) {
                listSong1[i]['thumbnail'] = listSong[i]['videoRenderer']
                    ["thumbnail"]["thumbnails"][leng - 1]['url'];
              }
            }
          }
        }
        // playList.add(AudioSource.uri(streamInfo1.url,
        //       tag: MediaItem(
        //           id: i.toString(),
        //           album: "Đường về",
        //           title: listSong1[i]['title'],
        //           artUri: Uri.parse(listSong1[i]['thumbnail']))));
      }
      // log('json $json');
      // log('json $listSong1');
      // log('json ${listSong.length}');

      //  log('listSong $listSong');

      yt.close();
      setDoneLoading(context);
    } catch (e) {
      listSong1 = [];
      playList = [];
      showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBox(
                title: 'Sorry',
                descriptions: e.toString(),
                text: 'OK',
                imageFile: Images.error);
          });
      setDoneLoading(context);
    }

    notifyListeners();
  }

  getDuration(List test) {}

  getRawAudioUrl(String idVideo) async {
    // log('raw api ${decode('aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj0=') + 'd9edJZFVSN4'}');
    String result =
        await searchSongRepo.search(decode(AppApi().urlVideo) + idVideo);
    return result;
  }

//get url audio raw
  getAudioUrl(String str) async {
    List<String> arrCheckSpecChar = ["\\", "\\\\"];
    String specChar = "";
    String typeVid = "\":140";
    // log("typeVid $typeVid");

    List<String> endJsonArr = ["}"];
    int startJsonIdx =
        str.indexOf("{" + specChar + "\"itag" + specChar + typeVid);
    // log("startJsonIdx $startJsonIdx");
    if (startJsonIdx == -1) {
      // log("itag change structure!!!");
      // log("itag index:${str.indexOf("itag")}");

      if (!str.contains("itag")) {
        return "Error";
      }
      // log(str.substring(str.indexOf("itag") - 20, str.indexOf("itag") + 20));
      for (int i = 0; i < arrCheckSpecChar.length; i++) {
        specChar = arrCheckSpecChar[i];
        startJsonIdx =
            str.indexOf("{" + specChar + "\"itag" + specChar + typeVid);
        if (startJsonIdx != -1) {
          break;
        }
      }
    }
    //========//

    if (startJsonIdx == -1) {
      return "Error";
    }
    //========//
    String newStr = str.substring(startJsonIdx, startJsonIdx + 5000);
    // 5000 là cái đầu buồi gì ????
    // log('newStr $newStr');
    int indexUrl = newStr.indexOf("url");
    int endJsonIdx = newStr.indexOf(endJsonArr[0]);
    // log('endJsonIdx $endJsonIdx');
    // log('indexUrl $indexUrl');
    if (endJsonIdx < indexUrl) {
      // trước khi có link url
      endJsonIdx = newStr.indexOf(endJsonArr[0], indexUrl);
    }
    //========//
    while (true) {
      log('run while');

      if (newStr[endJsonIdx] == '}' ||
          newStr[endJsonIdx] == '"' ||
          newStr[endJsonIdx] == '\\' ||
          newStr[endJsonIdx] == ']' ||
          newStr[endJsonIdx] == ',') {
        endJsonIdx--;
      } else {
        endJsonIdx++; // trả ký tự cuối
        break;
      }
    }

    String strData = newStr.substring(0, endJsonIdx);
    int idxSigCipher = strData.indexOf("signatureCipher");
    String urlDecode = "";
    String ytbUrl = "";

    if (idxSigCipher == -1) {
      urlDecode = (strData.substring(
          strData.indexOf("http"), strData.indexOf("\",\"")));
      urlDecode = urlDecode.replaceAll("\\u0026", "&");
      ytbUrl = urlDecode;
    } else {
      String strDataSigCipher = strData.substring(idxSigCipher, strData.length);
      String signature = strDataSigCipher.substring(
          strDataSigCipher.indexOf("=") + 1,
          strDataSigCipher.indexOf(specChar + "\\u0026"));
      String keySig = strData.substring(
          strData.indexOf("sp="), strData.indexOf(specChar + "\\u0026url"));
      urlDecode =
          strData.substring(strData.indexOf("url=") + 4, strData.length);
      signature = Uri.decodeFull(signature);
      keySig = keySig.substring(3, keySig.length); //= keySig.slice(3);
      urlDecode = Uri.decodeFull(Uri.decodeFull(Uri.decodeFull(urlDecode)));
      urlDecode = urlDecode.replaceAll("\\\\", "");

      //"/\\\\/"

      int idx = str.indexOf("base.js");
      String tempBase = str.substring(idx - 100, idx + 7);
      specChar = "";
      int idxStartBase = tempBase
          .indexOf(specChar + "/s" + specChar + "/player" + specChar + "/");

      if (idxStartBase == -1) {
        // log("basejs change structure!!!");
        for (int i = 0; i < arrCheckSpecChar.length; i++) {
          specChar = arrCheckSpecChar[i];
          idxStartBase = tempBase
              .indexOf(specChar + "/s" + specChar + "/player" + specChar + "/");
          if (startJsonIdx != -1) {
            break;
          }
        }
      }
      String baseLink = tempBase.substring(idxStartBase, tempBase.length);
      baseLink = baseLink.replaceAll("/\\/", "");
      baseLink = decode(urlBase) + baseLink;
      String baseData = await searchSongRepo.search(baseLink);
      String sigAfter = handleFunctionBase(baseData, signature);

      ytbUrl = urlDecode + "&" + keySig + "=" + sigAfter;
    }
    return ytbUrl;
  }

  handleFunctionBase(String str, String signature) {
    String dataText = str;
    String txtReverse = "function(a){a.reverse()";
    String txtSplice = "function(a,b){a.splice(0,b)}";
    String txtSwap =
        "function(a,b){var c=a[0];a[0]=a[b%a.length];a[b%a.length]=c}";
    String txtMain1 = "function(a){a=a.split(\"\");";
    String txtMain2 = "return a.join(\"\")};";
    int idxMain = 0;
    String charReverse = "", charSplice = "", charSwap = "";
    List<String> lines = dataText.split("\n");
    var trimline = lines.removeLast();
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains(txtMain1) && lines[i].contains(txtMain2)) {
        idxMain = i;
      }
      if (lines[i].contains(txtReverse)) {
        charReverse = lines[i].substring(
            lines[i].indexOf(txtReverse) - 3, lines[i].indexOf(txtReverse) - 1);
      }
      if (lines[i].contains(txtSplice)) {
        charSplice = lines[i].substring(
            lines[i].indexOf(txtSplice) - 3, lines[i].indexOf(txtSplice) - 1);
      }
      if (lines[i].contains(txtSwap)) {
        charSwap = lines[i].substring(
            lines[i].indexOf(txtSwap) - 3, lines[i].indexOf(txtSwap) - 1);
      }
    }

    try {
      List<String> linesMain = lines[idxMain].split(";");
      linesMain.removeLast();
      for (int i = 0; i < linesMain.length; i++) {
        //? Split to another funtion
        if (linesMain[i].contains(charReverse)) {
          String numStr = linesMain[i]
              .substring(linesMain[i].indexOf("("), linesMain[i].indexOf(")"));
          signature = handleString(
              signature, "reverse", numStr.replaceAll(RegExp(r'[^0-9]'), ''));
        }
        if (linesMain[i].contains(charSplice)) {
          String numStr = linesMain[i]
              .substring(linesMain[i].indexOf("("), linesMain[i].indexOf(")"));
          signature = handleString(
              signature, "splice", numStr.replaceAll(RegExp(r'[^0-9]'), ''));
        }
        if (linesMain[i].contains(charSwap)) {
          String numStr = linesMain[i]
              .substring(linesMain[i].indexOf("("), linesMain[i].indexOf(")"));
          signature = handleString(
              signature, "swap", numStr.replaceAll(RegExp(r'[^0-9]'), ''));
        }
      }
    } catch (e) {
      log("Exception handleFunctionBase ${e.toString()}");
    }
    return signature;
  }

  handleString(String str, String type, String idx) {
    log('=======>> handle string');
    if (idx == "") {
      return str;
    }
    int index = int.parse(idx);
    if (type == "reverse") {
      return StringBuffer(str).toString().split('').reversed.join();
    } else if (type == "splice") {
      if (index + 1 < str.length) {
        return str.substring(index, str.length);
      } // || index+1
    } else if (type == "swap") {
      if (index < str.length) {
        String s = str;
        var l = s[0], r = s[index];
        s = replaceCharAt(s, 0, r);
        s = replaceCharAt(s, index, l);
        return s.toString();
      }
    }
    return str;
  }

//function to replace one character in String to another because in Flutter String is imumtabe so String can't be change
  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }
}
