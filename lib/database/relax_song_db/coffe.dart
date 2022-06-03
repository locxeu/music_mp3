import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

List<AudioSource> coffePlayist = [
  AudioSource.uri(
    Uri.parse(
        'https://vnno-vn-5-tf-mp3-s1-zmp3.zmdcdn.me/fdb724517e10974ece01/4536349647591238604?authen=exp=1654399603~acl=/fdb724517e10974ece01/*~hmac=0a1f96e894839dd00089b874efae9fc6&fs=MTY1NDIyNjgwMzk4Mnx3ZWJWNnwwfDE4My44MS45My4zNQ'),
    tag: MediaItem(
        album: "Coffe with friends",
        title: "Về nhà",
        id: "1",
        artUri: Uri.parse(
            'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/1/a/1/0/1a109c6c8781f99fe1e01af3ebe377aa.jpg')),
  ),
  AudioSource.uri(
    Uri.parse(
        'https://vnno-vn-5-tf-mp3-s1-zmp3.zmdcdn.me/3230daa0fce715b94cf6/1741674707818029518?authen=exp=1654399698~acl=/3230daa0fce715b94cf6/*~hmac=bba1e6f4d629dc8a7ff0fc1dc5f4f0d6&fs=MTY1NDIyNjg5ODg5Mnx3ZWJWNnwwfDE4My44MS45My4zNQ'),
    tag: MediaItem(
        album: "Coffe with friends",
        title: "Trời giấu trời mang đi",
        id: "2",
        artUri: Uri.parse(
            'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/1/a/1/0/1a109c6c8781f99fe1e01af3ebe377aa.jpg')),
  ),
  AudioSource.uri(
    Uri.parse(
        'https://vnno-vn-6-tf-mp3-s1-zmp3.zmdcdn.me/efad11d2c99620c87987/2245834307933820373?authen=exp=1654399749~acl=/efad11d2c99620c87987/*~hmac=aea9e763aa4cd47c7041fddf88d3745f&fs=MTY1NDIyNjk0OTIxM3x3ZWJWNnwwfDE4My44MS45My4zNQ'),
    tag: MediaItem(
        album: "Coffe with friends",
        title: "Từ ngày em đến",
        id: "3",
        artUri: Uri.parse(
            'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/1/a/1/0/1a109c6c8781f99fe1e01af3ebe377aa.jpg')),
  ),
   AudioSource.uri(
    Uri.parse(
        'https://vnno-zn-5-tf-mp3-s1-zmp3.zmdcdn.me/0d1dec59b6185f460609/3607992160560781065?authen=exp=1654399801~acl=/0d1dec59b6185f460609/*~hmac=23b03b2689f2d855867906208c0b9805&fs=MTY1NDIyNzAwMTA0NXx3ZWJWNnwwfDE4My44MS45My4zNQ'),
    tag: MediaItem(
        album: "Coffe with friends",
        title: "Nếu ngày mai tôi không trở về",
        id: "3",
        artUri: Uri.parse(
            'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/1/a/1/0/1a109c6c8781f99fe1e01af3ebe377aa.jpg')),
  ),
];
