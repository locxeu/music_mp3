import 'package:flutter/material.dart';
import 'package:music_mp3_app/model/song_model.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:provider/provider.dart';

import '../../networkSong.dart';
import '../widget/display_song.dart';
import '../widget/header_playlist.dart';

class PlaylistScreen extends StatefulWidget {
  final String title;
  final List<YoutubeSong> playlistSong;
  const PlaylistScreen(
      {Key? key, required this.playlistSong, required this.title})
      : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    print('rebuild parent');
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            HeaderPlaylist(title: widget.title),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.playlistSong.length,
                itemBuilder: ((context, index) {
                  return Consumer<SearchSongState>(
                    builder: (_, value, __) => value.isDetailSongPlaying
                        ? NetworkSong(
                            listAudio: value.playList,
                          )
                        : GestureDetector(
                            onTap: () {
                              value.playSong();
                              value.getAudio(widget.playlistSong, index);
                            },
                            child: DisplaySong(
                              playSong: () {
                                setState(() {
                                  print('abc');
                                });
                              },
                              title: widget.playlistSong[index].title!,
                              imageUrl: widget.playlistSong[index].thumbnail!,
                              duration: widget.playlistSong[index].duration!,
                            ),
                          ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
