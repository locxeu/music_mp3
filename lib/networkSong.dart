import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';
import 'package:music_mp3_app/controlButton.dart';
import 'package:music_mp3_app/instance/instance.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:music_mp3_app/ui/widget/custom_dialog.dart';
import 'package:music_mp3_app/ui/widget/header_detail_playing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'extension/extension.dart';

class NetworkSong extends StatefulWidget {
  final List<AudioSource> listAudio;
  const NetworkSong({Key? key, required this.listAudio}) : super(key: key);

  @override
  NetworkSongState createState() => NetworkSongState();
}

class NetworkSongState extends State<NetworkSong>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  var _playlist;
  late AnimationController _controller;
  final int _addedCount = 0;
  int progress = 0;
   final Dio dio= Dio();
  void setTimer() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    const Text('enter'),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: const TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 197, 63, 209),
                                      width: 1.0),
                                ),
                                fillColor: Colors.red),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: const TextField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 15),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 197, 63, 209),
                                      width: 1.0),
                                ),
                                fillColor: Colors.red),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _init() async {
    log('init run');
    _playlist = ConcatenatingAudioSource(
      children: [
        for (var i = 0; i < widget.listAudio.length; i++) widget.listAudio[i]
      ],
    );
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    Instances.player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      // Preloading audio is not currently supported on Linux.
      await Instances.player.setAudioSource(_playlist,
          initialIndex: context.read<SearchSongState>().currentIndexPlaying,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
      // await  Instances.player.seek(Duration.zero,index:context.read<SearchSongState>().currentIndexPlaying);
      Instances.player.play();
    } catch (e) {
      // Catch load errors: 404, invalid url...
      log("Error123 loading audio source: $e");
      showDialog(
          context: context,
          builder: (context) {
            return CustomDialogBox(
                title: 'Sorry',
                descriptions: 'Error123 loading audio source: $e'.toString(),
                text: 'OK',
                imageFile: Images.error);
          });
    }
  }

 void _downloadAudio()async{
   log('download');
     final status = await Permission.storage.request();
     if(status.isGranted){
      final baseStorage = await getApplicationSupportDirectory();
log('baseStorage ${baseStorage.path}');
      final id = await FlutterDownloader.enqueue(url: 'https://rr2---sn-42u-i5oes.googlevideo.com/videoplayback?expire=1654875696&ei=0BGjYru4M8aOvcAPqfq8wAE&ip=1.55.108.212&id=o-AGJObCJZwzzg_4LL5kb0geIeghJyco-p7A5ihyDjsby0&itag=140&source=youtube&requiressl=yes&mh=VK&mm=31,26&mn=sn-42u-i5oes,sn-oguesn6s&ms=au,onr&mv=m&mvi=2&pcm2cms=yes&pl=24&initcwndbps=2071250&spc=4ocVC4ZsSCuwhQHT1HT0Jo3-3OKT9E0&vprv=1&mime=audio/mp4&ns=oYzl9fO8ENTtWdNQwGrCEGwG&gir=yes&clen=5455652&dur=337.060&lmt=1639904228545548&mt=1654853580&fvip=2&keepalive=yes&fexp=24001373,24007246&c=WEB&txp=5532434&n=2cprQbCou-2ov9g-7p&sparams=expire,ei,ip,id,itag,source,requiressl,spc,vprv,mime,ns,gir,clen,dur,lmt&lsparams=mh,mm,mn,ms,mv,mvi,pcm2cms,pl,initcwndbps&lsig=AG3C_xAwRQIhAOVWNsyh4DNGRoFj29uj4DjsectWQwKHF5zwF4kafEbCAiBeFPw0o3_H7baW85Nte7tBERQUNLzS4oEcoeoeW8MdzA==&sig=AOq0QJ8wRAIgOSMHU_h6chHEEjg62zs6mT5Mndo29Q2O0YVcJoA7iLcCICXJA1FouK_X2IOpa_5Y0GLafaqhUkJ0o16Cvw6KdiGn'
      , savedDir: baseStorage.path,fileName: 'vutest.mp3',saveInPublicStorage: true,showNotification: true);
     }else{
       log('No permission');
     }
 }
// downloadFile()async{
//   bool download = await saveFile('https://rr2---sn-42u-i5oes.googlevideo.com/videoplayback?expire=1654875696&ei=0BGjYru4M8aOvcAPqfq8wAE&ip=1.55.108.212&id=o-AGJObCJZwzzg_4LL5kb0geIeghJyco-p7A5ihyDjsby0&itag=140&source=youtube&requiressl=yes&mh=VK&mm=31,26&mn=sn-42u-i5oes,sn-oguesn6s&ms=au,onr&mv=m&mvi=2&pcm2cms=yes&pl=24&initcwndbps=2071250&spc=4ocVC4ZsSCuwhQHT1HT0Jo3-3OKT9E0&vprv=1&mime=audio/mp4&ns=oYzl9fO8ENTtWdNQwGrCEGwG&gir=yes&clen=5455652&dur=337.060&lmt=1639904228545548&mt=1654853580&fvip=2&keepalive=yes&fexp=24001373,24007246&c=WEB&txp=5532434&n=2cprQbCou-2ov9g-7p&sparams=expire,ei,ip,id,itag,source,requiressl,spc,vprv,mime,ns,gir,clen,dur,lmt&lsparams=mh,mm,mn,ms,mv,mvi,pcm2cms,pl,initcwndbps&lsig=AG3C_xAwRQIhAOVWNsyh4DNGRoFj29uj4DjsectWQwKHF5zwF4kafEbCAiBeFPw0o3_H7baW85Nte7tBERQUNLzS4oEcoeoeW8MdzA==&sig=AOq0QJ8wRAIgOSMHU_h6chHEEjg62zs6mT5Mndo29Q2O0YVcJoA7iLcCICXJA1FouK_X2IOpa_5Y0GLafaqhUkJ0o16Cvw6KdiGn', 
//   'buocquamuacodon.mp3');
//   if(download){
//     print('download sucess');
//   }else{
//   print('download loi');

//   }
// }
//   Future<bool> saveFile(String url, String fileName) async {
//     Directory? directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getApplicationDocumentsDirectory();
//           // String newPath='';
//           // List<String> folders= directory!.path.split('/');
//           // for(int x=1;x<folders.length;x++){
//           //   String folder=folders[x];
//           //   if(folder!="Android"){
//           //     newPath+='/'+folder;
//           //   }
//           //   else{
//           //     break;
//           //   }
//           // }
//           // newPath=newPath+'/musicApp';
//           // directory =Directory(newPath);
//      log('path ${directory.path}');
//         }
//       }
//       if(!await directory!.exists()){
//         await directory.create(recursive:true);
//       }
//       if(await directory.exists()){
//         File savefile=File(directory.path+'/$fileName');
//         log('savefile ${savefile.toString()}');
//        await dio.download(url, savefile.path,onReceiveProgress: (downloaded,totalSize){
//          setState(() {
//            progress=downloaded/totalSize*100;
//          });
//        });
//        return true;
//       }
//     } catch (e) {
// print(e);
//     }
//     return false;
//   }

//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//   }

  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    super.initState();
    // ambiguate(WidgetsBinding.instance)!.addObserver(this);
    // Instances.player = Instances.player;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    // _init();
    _controller = AnimationController(
      duration: const Duration(minutes: 6),
      vsync: this,
    );
    if (mounted) {
      _controller.forward();
    }
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, 'downloadingVideo');
    receivePort.listen((message) {
      setState(() {
        progress = message;
      });
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static downloadCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName('downloadingVideo')!;
    sendPort.send(progress);
  }

  @override
  void dispose() {
    // ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Instances.player.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.paused) {
    //   // Release the player's resources when not in use. We use "stop" so that
    //   // if the app resumes later, it will still remember what position to
    //   // resume from.
    //   Instances.player.stop();
    // }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          Instances.player.positionStream,
          Instances.player.bufferedPositionStream,
          Instances.player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchSongState>(builder: (_, networkSong, __) {
      print(Instances.player.playerState);
      print(Instances.player.playing);

      return Material(
        child: Container(
          decoration: const BoxDecoration(
              // color: Colors.red
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.height * 0.1,
              ),
              HeaderPlayingSong(
                onTap: () {
                  networkSong.playSong();
                },
                setTimer: setTimer,
              ),
              SizedBox(
                height: context.height * 0.06,
              ),
              StreamBuilder<SequenceState?>(
                stream: Instances.player.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state?.sequence.isEmpty ?? true) {
                    return const SizedBox();
                  }
                  final metadata = state!.currentSource!.tag as MediaItem;
                  // log('url ${networkSong.listSong1[0]}');
                  return SizedBox(
                    height: context.height * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: RotationTransition(
                              turns: Tween(begin: 0.0, end: 5.0)
                                  .animate(_controller),
                              child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(
                                    metadata.artUri.toString(),
                                  )),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                          child: Marquee(
                            velocity: 40,
                            text: metadata.title,
                            style: AppTheme.headLine3,
                            scrollAxis: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ControlButtons(Instances.player),
              StreamBuilder(
                  stream: Instances.player.currentIndexStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text(''),
                      );
                    }
                    return Center(
                      child: Text(
                        snapshot.data.toString(),
                        textAlign: TextAlign.center,
                        style: AppTheme.headLine2,
                      ),
                    );
                  }),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  Instances.currentPosition =
                      positionData?.position ?? Duration.zero;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: (newPosition) {
                      Instances.player.seek(newPosition);
                    },
                  );
                },
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder<LoopMode>(
                    stream: Instances.player.loopModeStream,
                    builder: (context, snapshot) {
                      final loopMode = snapshot.data ?? LoopMode.off;
                      const icons = [
                        Icon(Icons.repeat, color: Colors.grey),
                        Icon(Icons.repeat, color: Colors.orange),
                        Icon(Icons.repeat_one, color: Colors.orange),
                      ];
                      const cycleModes = [
                        LoopMode.off,
                        LoopMode.all,
                        LoopMode.one,
                      ];
                      final index = cycleModes.indexOf(loopMode);
                      return IconButton(
                        icon: icons[index],
                        onPressed: () {
                          Instances.player.setLoopMode(cycleModes[
                              (cycleModes.indexOf(loopMode) + 1) %
                                  cycleModes.length]);
                        },
                      );
                    },
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      )),
                  IconButton(
                      onPressed: _downloadAudio,
                      icon: const Icon(
                        Icons.download,
                        color: Colors.grey,
                      )),
                  StreamBuilder<bool>(
                    stream: Instances.player.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? const Icon(Icons.shuffle, color: Colors.orange)
                            : const Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () async {
                          final enable = !shuffleModeEnabled;
                          if (enable) {
                            await Instances.player.shuffle();
                          }
                          await Instances.player.setShuffleModeEnabled(enable);
                        },
                      );
                    },
                  ),
                ],
              ),
              Text(
                progress.toString(),
                style: AppTheme.headLine3,
              )
              // SizedBox(
              //   height: 240.0,
              //   child: StreamBuilder<SequenceState?>(
              //     stream: Instances.player.sequenceStateStream,
              //     builder: (context, snapshot) {
              //       final state = snapshot.data;
              //       final sequence = state?.sequence ?? [];
              //       return ReorderableListView(
              //         onReorder: (int oldIndex, int newIndex) {
              //           if (oldIndex < newIndex) newIndex--;
              //           _playlist.move(oldIndex, newIndex);
              //         },
              //         children: [
              //           for (var i = 0; i < sequence.length; i++)
              //             Dismissible(
              //               key: ValueKey(sequence[i]),
              //               background: Container(
              //                 color: Colors.blue,
              //                 alignment: Alignment.centerRight,
              //                 child: const Padding(
              //                   padding: EdgeInsets.only(right: 8.0),
              //                   child: Icon(Icons.delete, color: Colors.white),
              //                 ),
              //               ),
              //               onDismissed: (dismissDirection) {

              //                 _playlist.removeAt(i);
              //               },
              //               child: Material(
              //                 color: Colors.transparent,
              //                 child: ListTile(
              //                      tileColor: i == state!.currentIndex
              //                           ? Colors.grey.shade700
              //                           : null,
              //                            trailing:i == state.currentIndex? AudioWave(
              //                     height: 32,
              //                     width: 32,
              //                     spacing: 2.5,
              //                    alignment: 'center',
              //                    animation: true,
              //                    beatRate : const Duration(milliseconds: 200),
              //                     bars: [
              //                       AudioWaveBar(
              //                           heightFactor: 0.5,
              //                           color: Colors.lightBlueAccent),
              //                       AudioWaveBar(
              //                           heightFactor: 0.3, color: Colors.blue),
              //                       AudioWaveBar(
              //                           heightFactor: 0.7, color: Colors.black),
              //                       AudioWaveBar(heightFactor: 0.4),
              //                     ],
              //                   ):null,
              //                   title: Text(sequence[i].tag.title as String,
              //                     style: AppTheme.headLine3),
              //                   onTap: () {
              //                     Instances.player.seek(Duration.zero, index: i);
              //                                                      print(' 123 ${ state.currentIndex}');

              //                   },
              //                 ),
              //               ),
              //             ),
              //         ],
              //       );
              //     },
              //   ),
              // ),
            ],

            // floatingActionButton: FloatingActionButton(
            //   child: const Icon(Icons.add),
            //   onPressed: () {
            //     _playlist.add(AudioSource.uri(
            //       Uri.parse("asset:///audio/nature.mp3"),
            //       tag: AudioMetadata(
            //         album: "Public Domain",
            //         title: "Nature Sounds ${++_addedCount}",
            //         artwork:
            //             "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
            //       ),
            //     ));
            //   },
            // ),
          ),
        ),
      );
    });
  }
}

// class MediaItem {
//   final String album;
//   final String title;
//   final String artwork;

//   MediaItem({
//     required this.album,
//     required this.title,
//     required this.artwork,
//   });
// }
