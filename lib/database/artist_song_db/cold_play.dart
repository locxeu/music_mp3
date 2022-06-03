import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/networkSong.dart';


List<AudioSource> coldPlay = [
   AudioSource.uri(Uri.parse(
            'https://c1-ex-swe.nixcdn.com/Warner_Audio35/Everglow-Coldplay-6426704.mp3?st=jRldjZObGT24LH_koik82A&e=1654247979&t=1654161579598'),
        tag: const MediaItem(
          album: "Đường về",
          title: "Everglow",
          id:
              "1",
              
        ),
       ),
    AudioSource.uri(
      Uri.parse(
          'https://c1-ex-swe.nixcdn.com/Warner_Audio33/Yellow-Coldplay-6302129.mp3?st=hG2j8ILwnW9LlJsqUd1plQ&e=1654247887&t=1654161488010'),
      tag: const MediaItem(
        album: "Đường về",
        title: "Yellow",
        id:
            "2",
      ),
    ),
    AudioSource.uri(
      Uri.parse( 'https://c1-ex-swe.nixcdn.com/Warner_Audio36/EveryTeardropIsAWaterfall-Coldplay-6432483.mp3?st=9ZD0q-6y51sCCzyqmSlpaw&e=1654247930&t=1654161531166'),
      tag: const MediaItem(
        album: "Đường về",
        title: "Every Teardrop Is A Waterfall",
        id:
            "3",
      ),
    ),
];