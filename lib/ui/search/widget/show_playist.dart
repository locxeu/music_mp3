import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/model/song_model.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/image_path.dart';
import '../../../model/playlist_model.dart';

class ShowPlaylist extends StatefulWidget {
  final int index;
  const ShowPlaylist({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _ShowPlaylistState createState() => _ShowPlaylistState();
}

class _ShowPlaylistState extends State<ShowPlaylist> {
  late Box<Playlist> playlist;
  @override
  void initState() {
    playlist = Hive.box('playlist');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppTheme.padding,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: AppTheme.padding,
              top: AppTheme.avatarRadius + AppTheme.padding,
              right: AppTheme.padding,
              bottom: AppTheme.padding),
          margin: const EdgeInsets.only(
            top: AppTheme.avatarRadius,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                AppTheme.padding,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 200,
                child: ValueListenableBuilder(
                  valueListenable: playlist.listenable(),
                  builder: (context, Box<Playlist> box, _) {
                    List<Playlist> playlist =
                        box.values.toList().cast<Playlist>();
                    return playlist.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: playlist.length,
                            itemBuilder: ((context, index) {
                              return Material(
                                child: Consumer<SearchSongState>(
                                  builder: (_, addToPlaylist, __) => InkWell(
                                    onTap: () {
                                      box.get(playlist[index].name)!.song.add(
                                                          YoutubeSong(
                                                id: addToPlaylist
                                                        .listSong1[widget.index]
                                                    ['id'],
                                                thumbnail: addToPlaylist
                                                        .listSong1[widget.index]
                                                    ['thumbnail'],
                                                duration: addToPlaylist
                                                        .listSong1[widget.index]
                                                    ['duration'],
                                                title: addToPlaylist
                                                        .listSong1[widget.index]
                                                    ['title']),
                                      );
                                      box.values.last.save();
                                      // playlist[index].song.add(
                                      //       YoutubeSong(
                                      //           id: addToPlaylist
                                      //                   .listSong1[widget.index]
                                      //               ['id'],
                                      //           thumbnail: addToPlaylist
                                      //                   .listSong1[widget.index]
                                      //               ['thumbnail'],
                                      //           duration: addToPlaylist
                                      //                   .listSong1[widget.index]
                                      //               ['duration'],
                                      //           title: addToPlaylist
                                      //                   .listSong1[widget.index]
                                      //               ['title']),
                                      //     );
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      child: Text(playlist[index].name),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        : const Text(
                            'Hiện tại chưa có playlist nào',
                          );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Add To Playlist',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: AppTheme.padding,
          right: AppTheme.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: AppTheme.avatarRadius,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppTheme.avatarRadius,
                ),
              ),
              child: Image.asset(
                Images.playlist,
                width: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
