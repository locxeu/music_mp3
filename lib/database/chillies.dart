import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/networkSong.dart';

List<AudioSource> chilliesSongList = [
   AudioSource.uri(Uri.parse(
            "https://data.chiasenhac.com/down2/2170/3/2169036-b7772440/128/Vung%20Ky%20Uc%20Remastered_%20-%20Chillies.mp3"),
        tag: AudioMetadata(
          album: "Qua Khung Cửa Sổ",
          title: "Vùng ký ức",
          artwork:
              "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
              
        ),
       ),
    AudioSource.uri(
      Uri.parse(
          "https://data.chiasenhac.com/down2/2170/3/2169041-4a4a6ac2/128/Duong%20Chan%20Troi%20Remastered_%20-%20Chillies.mp3"),
      tag: AudioMetadata(
        album: "Qua Khung Cửa Sổ",
        title: "Đường chân trời",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
      ),
    ),
    AudioSource.uri(
      Uri.parse("https://data3.chiasenhac.com/downloads/2130/3/2129844-9013b480/128/Qua%20Khung%20Cua%20So%20-%20Chillies.mp3"),
      tag: AudioMetadata(
        album: "Qua Khung Cửa Sổ",
        title: "Qua Khung Cửa Sổ",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
      ),
    ),
    AudioSource.uri(
      Uri.parse("https://data.chiasenhac.com/down2/2232/3/2231724-68fd3f3c/128/Co%20Em%20Doi%20Bong%20Vui%20-%20Chillies.mp3"),
      tag: AudioMetadata(
        album: "Qua Khung Cửa Sổ",
        title: "Có em đời bỗng vui",
        artwork:
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    )),
];