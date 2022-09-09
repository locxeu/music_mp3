import 'package:hive/hive.dart';
part 'song_model.g.dart';
@HiveType(typeId: 0)
class YoutubeSong {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? thumbnail;
  @HiveField(3)
  final String? duration;
  YoutubeSong({this.id, this.duration, this.thumbnail, this.title});
}

// class SongModel {
//   String? id;
//   String? title;
//   String? thumbnail;

//   SongModel({this.id, this.title, this.thumbnail});

//   SongModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     thumbnail = json['thumbnail'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['thumbnail'] = thumbnail;
//     return data;
//   }
// }
