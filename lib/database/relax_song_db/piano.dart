import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/networkSong.dart';


List<AudioSource> piano = [
   AudioSource.uri(Uri.parse(
            'https://vnso-zn-23-tf-mp3-320s1-zmp3.zmdcdn.me/8077692b176afe34a77b/3258429524891323207?authen=exp=1654335145~acl=/8077692b176afe34a77b/*~hmac=0ce84428de66cae63b3c1671e5384e09&fs=MTY1NDE2MjM0NTmUsIC3Nnx3ZWJWNnwxMDE0NTg5NTAzfDE4My44MS45My4zNQ'),
        tag: MediaItem(
          album: "Đường về",
          title: "Everglow",
          id:
              "1",
              
        ),
       ),
    AudioSource.uri(
      Uri.parse(
          'https://vnso-zn-15-tf-mp3-320s1-zmp3.zmdcdn.me/3775f8c65f82b6dcef93/1992858661715627415?authen=exp=1654334874~acl=/3775f8c65f82b6dcef93/*~hmac=cd7ba6ecfcbc6a7053d6829f3a381e12&fs=MTY1NDE2MjA3NDE3NHx3ZWJWNnwxMDmUsIC5NjA2MzAzfDI3LjmUsIC3LjI0Mi4yMjE'),
      tag: MediaItem(
        album: "Đường về",
        title: "Yellow",
        id:
            "2",
      ),
    ),
    AudioSource.uri(
      Uri.parse( 'https://vnso-zn-10-tf-mp3-320s1-zmp3.zmdcdn.me/c97e65b1b4f55dab04e4/258784745468951003?authen=exp=1654334752~acl=/c97e65b1b4f55dab04e4/*~hmac=d1d733cae0199b7be706b86e129fda28&fs=MTY1NDE2MTk1MjmUsICxOXx3ZWJWNnwwfDExOC42OC4xNTMdUngMTE1'),
      tag: MediaItem(
        album: "Đường về",
        title: "Every Teardrop Is A Waterfall",
        id:
            "3",
      ),
    ),
];