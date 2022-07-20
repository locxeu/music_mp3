import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_mp3_app/model/playlist_model.dart';
import 'package:music_mp3_app/ui/library/widget/create_playlist_modal.dart';

import '../../config/theme/app_theme.dart';
import '../playlist/playlistScreen.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late Box<Playlist> playlist;

  @override
  void initState() {
    playlist = Hive.box('playlist');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              const SizedBox(
                width: 11,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Playlist',
                    style: AppTheme.headLine3,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showCreatePlaylist(context);
                },
                icon: Icon(
                  Icons.add,
                  color: AppTheme.backgroundColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlaylistScreen()),
                  );
                },
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/favorite_song.png',
                  ),
                  title: const Text(
                    'Favourite Songs',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    '1 bài hát',
                    style: AppTheme.headLine6,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: playlist.listenable(),
                  builder: (context, Box<Playlist> box, _) {
                    List<Playlist> playlist =
                        box.values.toList().cast<Playlist>();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: playlist.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: Image.asset(
                            'assets/images/favorite_song.png',
                          ),
                          title:  Text(
                           playlist[index].name,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                             playlist[index].song.length.toString()+' bài hát',
                            style: AppTheme.headLine6,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        );
                      }),
                    );
                  })
            ],
          ),
        )
      ],
    );
  }

  void showCreatePlaylist(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.grey.shade800,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        builder: (context) {
          return  CreatePlaylistModal(playlist: playlist,);
        });
  }
}
