import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/networkSong.dart';

List<AudioSource> bucTuong = [
   AudioSource.uri(Uri.parse(
            'https://vnso-zn-15-tf-mp3-320s1-zmp3.zmdcdn.me/1f55c8406d04845add15/2362640419301409750?authen=exp=1654320049~acl=/1f55c8406d04845add15/*~hmac=aec7f573d47dc734c453d19f2aaa8f32&fs=MTY1NDE0NzI0OTM4N3x3ZWJWNnwxMDE0NTg5NTAzfDE4My44MS45My4zNQ'),
        tag: MediaItem(
            id: '1',
          album: "Đường về",
          title: "Cơn mưa tháng năm",
        )
       ),
    AudioSource.uri(
      Uri.parse(
          'https://vnso-zn-16-tf-mp3-320s1-zmp3.zmdcdn.me/1cbf2871ab3642681b27/5590839013893260074?authen=exp=1654320114~acl=/1cbf2871ab3642681b27/*~hmac=fed5a880fee8d5abcff49d9c79282151&fs=MTY1NDE0NzMxNDI0Nnx3ZWJWNnwxMDE0NTg5NTAzfDE4My44MS45My4zNQ'),
      tag: MediaItem(
          id:'2',
        album: "Đường về",
        title: "Mắt đen",
    
      ),
    ),
    AudioSource.uri(
      Uri.parse( 'https://vnso-zn-10-tf-mp3-320s1-zmp3.zmdcdn.me/42caed845ec0b79eeed1/5353489836732543949?authen=exp=1654320143~acl=/42caed845ec0b79eeed1/*~hmac=137f2150a6fcd2e618e3deb002f2aa92&fs=MTY1NDE0NzM0MzE5N3x3ZWJWNnwxMDE0NTg5NTAzfDE4My44MS45My4zNQ'),
      tag: const MediaItem(
        album: "Đường về",
        title: "Tâm hồn của đá",
        id:
            "3",
      ),
    ),
];