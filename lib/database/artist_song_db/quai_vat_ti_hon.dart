import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/api.dart';
import 'package:music_mp3_app/networkSong.dart';

List<AudioSource> quaiVatTiHonList = [
   AudioSource.uri(Uri.parse(
            'https://vnno-vn-5-tf-mp3-320s1-zmp3.zmdcdn.me/ad9fdd9a66de8f80d6cf/3645735704821854855?authen=exp=1654269846~acl=/ad9fdd9a66de8f80d6cf/*~hmac=5e5e044fd557bb2abbae59c50fd6aab7&fs=MTY1NDA5NzA0NjEwNnx3ZWJWNnwxMDE0NTg5NTAzfDE3MS4yMjkdUngMjI5LjIwNw'),
        tag: MediaItem(
          album: "Đường về",
          title: "Qua ô cửa thời gian",
          id:
              "1",
              
        ),
       ),
    AudioSource.uri(
      Uri.parse(
          'https://vnno-vn-6-tf-mp3-320s1-zmp3.zmdcdn.me/fc708a753131d86f8120/6418773128022984474?authen=exp=1654270675~acl=/fc708a753131d86f8120/*~hmac=4e490d8309442a9e471982ac3e7863ac&fs=MTY1NDA5Nzg3NTg2Nnx3ZWJWNnwxMDE0NTg5NTAzfDE3MS4yMjkdUngMjI5LjIwNw'),
      tag: MediaItem(
        album: "Đường về",
        title: "Ngày hôm qua",
        id:
            "2",
      ),
    ),
    AudioSource.uri(
      Uri.parse( 'https://vnno-vn-5-tf-mp3-320s1-zmp3.zmdcdn.me/153a9a3f217bc825916a/8764302045446552963?authen=exp=1654270734~acl=/153a9a3f217bc825916a/*~hmac=122f1eaec0808567e5e1ce29f6db6559&fs=MTY1NDA5NzkzNDIwMXx3ZWJWNnwxMDE0NTg5NTAzfDE3MS4yMjkdUngMjI5LjIwNw'),
      tag: MediaItem(
        album: "Đường về",
        title: "Ông trời cô đơn",
        id:
            "3",
      ),
    ),
    AudioSource.uri(
      Uri.parse('https://vnno-vn-6-tf-mp3-320s1-zmp3.zmdcdn.me/438cc88973cd9a93c3dc/230115752748697104?authen=exp=1654270774~acl=/438cc88973cd9a93c3dc/*~hmac=4c55a2f75800b31cbc1f80d298540daf&fs=MTY1NDA5Nzk3NDQxMHx3ZWJWNnwxMDE0NTg5NTAzfDE3MS4yMjkdUngMjI5LjIwNw'),
      tag: MediaItem(
        album: "Đường về",
        title: "Vì đời",
        id:
            "4",
    )),
      AudioSource.uri(
      Uri.parse('https://vnno-vn-6-tf-mp3-s1-zmp3.zmdcdn.me/0ea8260c5448bd16e459/2260424156945038103?authen=exp=1654270842~acl=/0ea8260c5448bd16e459/*~hmac=f4db4a57cc4a54e46fc8921f8451c9e1&fs=MTY1NDA5ODA0MjMxMnx3ZWJWNnwxMDE0NTg5NTAzfDE3MS4yMjkdUngMjI5LjIwNw'),
      tag: MediaItem(
        album: "Đường về",
        title: "Trái đất tròn",
        id:
            "5",
    )),
];