import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

List<AudioSource> chilliesSongList = [
   AudioSource.uri(Uri.parse(
            "https://www.youtube.com/watch?v=4JLe7s976k0"),
        tag:  MediaItem(
          album: "Qua Khung Cửa Sổ",
          title: "Vùng ký ức",
          id:
              "1",
               artUri: Uri.parse(
            'https://sites.google.com/site/info63q/_/rsrc/1536024229829/config/customLogo.gif?revision=1')
       ),
       ),
    // AudioSource.uri(
    //   Uri.parse(
    //       "https://data.chiasenhac.com/down2/2170/3/2169041-4a4a6ac2/128/Duong%20Chan%20Troi%20Remastered_%20-%20Chillies.mp3"),
    //   tag: MediaItem(
    //     album: "Qua Khung Cửa Sổ",
    //     title: "Đường chân trời",
    //     artwork:
    //         "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    //   ),
    // ),
    // AudioSource.uri(
    //   Uri.parse("https://data3.chiasenhac.com/downloads/2130/3/2129844-9013b480/128/Qua%20Khung%20Cua%20So%20-%20Chillies.mp3"),
    //   tag: MediaItem(
    //     album: "Qua Khung Cửa Sổ",
    //     title: "Qua Khung Cửa Sổ",
    //     artwork:
    //         "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    //   ),
    // ),
    // AudioSource.uri(
    //   Uri.parse("https://data.chiasenhac.com/down2/2232/3/2231724-68fd3f3c/128/Co%20Em%20Doi%20Bong%20Vui%20-%20Chillies.mp3"),
    //   tag: MediaItem(
    //     album: "Qua Khung Cửa Sổ",
    //     title: "Có em đời bỗng vui",
    //     artwork:
    //         "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    // )),
];