import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/model/playlist_model.dart';

class CreatePlaylistModal extends StatefulWidget {
  final Box<Playlist> playlist;
  const CreatePlaylistModal({Key? key,required this.playlist}) : super(key: key);

  @override
  State<CreatePlaylistModal> createState() => _CreatePlaylistModalState();
}

class _CreatePlaylistModalState extends State<CreatePlaylistModal> {
  final TextEditingController playlistName = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    playlistName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.54,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(top: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('New Playlist', style: AppTheme.headLine2),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 32,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.only(
                  left: 4,
                ),
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(
                  color: Colors.blueAccent,
                  width: 2,
                ))),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: playlistName,
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'create playlist',
                    hintStyle: AppTheme.headLine5,
                    contentPadding: EdgeInsets.zero,
                  ).copyWith(
                    isDense: true,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please type playlist name';
                    }
                    return null;
                  },
                ),
              ),
              const Divider(
                indent: 25,
                endIndent: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Text(
                        'Hủy',
                        style: AppTheme.headLine5,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.playlist.put(playlistName.text, Playlist(name: playlistName.text, song: []));
                      Navigator.pop(context);
                      log('message');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        child: Text(
                          'OK',
                          style: AppTheme.headLine5,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
