import 'package:music_mp3_app/model/song_model.dart';

import 'package:hive/hive.dart';
part 'playlist_model.g.dart';
@HiveType(typeId: 1)
class Playlist {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<YoutubeSong> song;
  Playlist({required this.name, required this.song});
}
