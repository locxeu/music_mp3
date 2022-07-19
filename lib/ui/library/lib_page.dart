import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';
import '../playlist/playlistScreen.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Playist',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              GestureDetector(
                onTap: (){
                     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlaylistScreen()),
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
              )
            ],
          ),
        )
      ],
    );
  }
}
