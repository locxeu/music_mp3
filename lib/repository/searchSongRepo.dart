import 'package:music_mp3_app/service/network.dart';

class SearchSongRepo {
  Future<dynamic> search(String linkApi) async {
    final result = await networkCall.get(linkApi);
    return result;
  }
}
