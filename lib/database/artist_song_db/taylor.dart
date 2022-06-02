import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/networkSong.dart';


List<AudioSource> taylorSwift = [
   AudioSource.uri(Uri.parse(
            'https://rr4---sn-42u-i5oll.googlevideo.com/videoplayback?expire=1654182224&ei=73yYYszOOcObvcAPztSB8Ag&ip=183.81.93.35&id=o-ADvKYsRDIAvh8lykAJR6wlqw3PBr9AXmPuf80DbVufPX&itag=251&source=youtube&requiressl=yes&mh=D_&mm=31%2C26&mn=sn-42u-i5oll%2Csn-npoldn7l&ms=au%2Conr&mv=m&mvi=4&pl=24&initcwndbps=2445000&spc=4ocVC21RYvHoun3xrAwPRCsbRdBgINLY1EBTllVrsQ&vprv=1&mime=audio%2Fwebm&ns=acegNC365xNcbGorDBlFriYG&gir=yes&clen=3027154&dur=232.501&lmt=1616737436074428&mt=1654160227&fvip=4&keepalive=yes&fexp=24001373%2C24007246&c=WEB&txp=5431432&n=iR7dQP-hZ_5JZw&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cspc%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhAIrWoxkJVZ0SJUDQVmwh_GEEqpORD4bQalTsZiDkCiVSAiASS5NIcZ5ToG2nRfQErt2FAp-gQvYf4_26obZ8j2Zang%3D%3D&alr=yes&sig=AOq0QJ8wRQIhAO0uBtMuDAUz44h9emzxN-A6EykhnCSeYdL_ge3uLNwxAiBGFrvtiHIqQesVGGTQ3AUUGvLZIk61x1ulO4cmhTwJSw%3D%3D&cpn=WB0T25cElJJ6ZxI6&cver=2.20220531.00.00&rn=3805&rbuf=0&pot=GpIBCmVcWSfWdXMpWCAVOYQayqccOTMkkdWuUXPj8DxiZ9zWcW9PDvk9awmYPrtnxMaSD7Mj--MBx-1-BwDxpKL9O7hyXBwnSFzyKeiF1T1EbRf8qtg-_QOOSlqcfuWzoq9-3PYkNEAZnBIpATwYQQ7wz1077VmKaAAeWqgd-ad4mSd9dAWOZfx3UTPirOikAnZsp7g='),
        tag: AudioMetadata(
          album: "Đường về",
          title: "You Belong With Me",
          artwork:
              "https://cdnmedia.thethaovanhoa.vn/2015/06/01/01/18/Taylor-Swift.jpg",
              
        ),
       ),
    AudioSource.uri(
      Uri.parse(
          'https://rr2---sn-42u-i5oll.googlevideo.com/videoplayback?expire=1654182317&ei=TH2YYoySMNWQvcAPxPWf0A8&ip=183.81.93.35&id=o-AB9-RFloQPxbtQmH2bC3SXJOl9nsj7TrEzhfx1LnvILq&itag=251&source=youtube&requiressl=yes&mh=gZ&mm=31%2C26&mn=sn-42u-i5oll%2Csn-npoe7ns7&ms=au%2Conr&mv=m&mvi=2&pl=24&initcwndbps=2445000&spc=4ocVC9rpyeMJ07THkpki-KljtMuqWPekAmwrcuUIBA&vprv=1&mime=audio%2Fwebm&ns=0EYR4TaF5W9dHA1kzwd4igMG&gir=yes&clen=4913623&dur=293.461&lmt=1621680829517596&mt=1654160227&fvip=5&keepalive=yes&fexp=24001373%2C24007246&c=WEB&txp=5531432&n=cZbX43QaATvNRg&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cspc%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAK7QYDDushzj_ueXJWfw9h2PiZRk6fU6vUEJH5TdC3GRAiEAivXvvka1AoQ4UpdNjw7axiCZTEep11LXVc10P-oL7dI%3D&alr=yes&sig=AOq0QJ8wRAIgHSoOiiuYQt8iDDDrggdSbeX5pNahhS0Hu-sG2YwaRPQCIG0JBFsIGfgixq2KEdo4_hLL8VKL3jvNEgr7ee-W2zMi&cpn=stIER2mfMC9voqG5&cver=2.20220531.00.00&rn=3819&rbuf=0&pot=GpIBCmVcWSfWdXMpWCAVOYQayqccOTMkkdWuUXPj8DxiZ9zWcW9PDvk9awmYPrtnxMaSD7Mj--MBx-1-BwDxpKL9O7hyXBwnSFzyKeiF1T1EbRf8qtg-_QOOSlqcfuWzoq9-3PYkNEAZnBIpATwYQQ7wz1077VmKaAAeWqgd-ad4mSd9dAWOZfx3UTPirOikAnZsp7g='),
      tag: AudioMetadata(
        album: "Đường về",
        title: "Back To December",
        artwork:
            "https://cdnmedia.thethaovanhoa.vn/2015/06/01/01/18/Taylor-Swift.jpg",
      ),
    ),
    AudioSource.uri(
      Uri.parse( 'https://rr5---sn-42u-i5oey.googlevideo.com/videoplayback?expire=1654182359&ei=d32YYvuhJe6uvcAP6NmK2A8&ip=183.81.93.35&id=o-ADJ-RHXx-_tcXfac3LwUYJKGLdVHqXV3N2fczbXikxGw&itag=251&source=youtube&requiressl=yes&mh=u2&mm=31%2C26&mn=sn-42u-i5oey%2Csn-npoe7ner&ms=au%2Conr&mv=m&mvi=5&pl=24&initcwndbps=2138750&spc=4ocVCxoDUrMp3cTyOhcnUU7wPQKXnOG9cBuqer4OcA&vprv=1&mime=audio%2Fwebm&ns=WOfnMGpXRJ9kWpo3TOmXBpoG&gir=yes&clen=3269753&dur=186.161&lmt=1654008164025060&mt=1654160467&fvip=2&keepalive=yes&fexp=24001373%2C24007246&c=WEB&txp=5318224&n=8ldOCaVT4SqKLw&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cspc%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhAP9Bi6MMKgpG9k70_yD7EX_ZQUiEfjYPfA67hMysZsY_AiBZMBdx5gJ3vgMac23w4m93qGjfjgMWKEcgrxEn4KA_yw%3D%3D&alr=yes&sig=AOq0QJ8wRAIgbcbko6YfZKTI0n1rkmc0vYN--mIlcrgKmzffOjNUnI8CIHAcyPLDug483taAszKyzxfmJsSSNlO_Ru3wy8rAmHFo&cpn=OQPwLcN9p7tt5nX0&cver=2.20220531.00.00&rn=3830&rbuf=0&pot=GpIBCmVcWSfWdXMpWCAVOYQayqccOTMkkdWuUXPj8DxiZ9zWcW9PDvk9awmYPrtnxMaSD7Mj--MBx-1-BwDxpKL9O7hyXBwnSFzyKeiF1T1EbRf8qtg-_QOOSlqcfuWzoq9-3PYkNEAZnBIpATwYQQ7wz1077VmKaAAeWqgd-ad4mSd9dAWOZfx3UTPirOikAnZsp7g='),
      tag: AudioMetadata(
        album: "Đường về",
        title: "Crazier",
        artwork:
            "https://cdnmedia.thethaovanhoa.vn/2015/06/01/01/18/Taylor-Swift.jpg",
      ),
    ),
];