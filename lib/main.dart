import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_mp3_app/model/song_model.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:music_mp3_app/ui/splash_screen.dart';
import 'package:provider/provider.dart';

import 'model/playlist_model.dart';


Future<void> main()async {
   WidgetsFlutterBinding.ensureInitialized();
   FlutterDownloader.initialize();
   await Hive.initFlutter();
   Hive.registerAdapter(YoutubeSongAdapter());
   Hive.registerAdapter(PlaylistAdapter());
   await Hive.openBox<YoutubeSong>('favourite_song');
   await Hive.openBox<Playlist>('playlist');
   await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(ChangeNotifierProvider(
    create: (_)=>SearchSongState(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen()
      //Todo: ADD SLEEP TIMER 
      //Todo: SIDBLE LIST
      
    );
  }
}


