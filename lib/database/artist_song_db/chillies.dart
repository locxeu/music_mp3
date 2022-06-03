import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/networkSong.dart';

List<AudioSource> chilliesSongList = [
   AudioSource.uri(Uri.parse(
            "https://rr5---sn-42u-i5ols.googlevideo.com/videoplayback?expire=1654173426&ei=kVqYYo6IOs23vcAP3qCLmAg&ip=183.81.93.35&id=o-AB1ThZyk_KFY8hJzXi9wL8UIvIZTGG5-ceLQ_FGsaxGf&itag=251&source=youtube&requiressl=yes&mh=LS&mm=31%2C26&mn=sn-42u-i5ols%2Csn-npoe7n7y&ms=au%2Conr&mv=m&mvi=5&pcm2cms=yes&pl=24&initcwndbps=2005000&spc=4ocVC2fSAhKgNTNBHIg3zhWv0KnN-G1OcBxPNULXkg&vprv=1&mime=audio%2Fwebm&ns=pv_fUROtRqPIY43uSkzi220G&gir=yes&clen=5903155&dur=464.921&lmt=1540172790042363&mt=1654151349&fvip=1&keepalive=yes&fexp=24001373%2C24007246&c=WEB&txp=5411222&n=DCbfywZny2prWw&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cspc%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRQIhANsrqJVvIFYQup1J710I3ldntHvxKinmweS9HCllLPa2AiB5CUeiObgSuAunXGbzA2usV_aTbb_e6geyx-upq8PQoQ%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpcm2cms%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgAvXw8G5l51x1gt1rezqbUxT-XY32XxVcRdOa0As-opMCIQDIVBOcFmiTRBAUg3AyOjz_RsxZ18yHCx0K0yQHgKJqkQ%3D%3D&alr=yes&cpn=aaczZkmZ3HVw7kPo&cver=2.20220531.08.00&rn=294&rbuf=119717&pot=GpIBCmUNgL4aRgfLrEAAKdRQmdB-IiW2J-B07VS8zNuMnQ_dTT2QM4at3PUv0ta2DHQdtMhLzov46JHgAJJ6ZxyApXAaSVOQIlQ0GOJGN7QRWJjh8ZLg5U1VuNndjqHHqDRELX6KLIg2mRIpATwYQQ5WWqSV8QXnqA8an1twEiSu4-3LaUwAFtas7knZcg3KWfpe-sQ="),
        tag: MediaItem(
          album: "Qua Khung Cửa Sổ",
          title: "Vùng ký ức",
          id:
              "1",
              
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