import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/model/song_model.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late Box<YoutubeSong> favouriteSong;
  @override
  void initState() {
    favouriteSong = Hive.box('favourite_song');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppTheme.backgroundColor,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Favourite Song',
                          style: AppTheme.headLine3,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: favouriteSong.listenable(),
                builder: (context, Box<YoutubeSong> box, _) {
                  List<YoutubeSong> favour =
                      box.values.toList().cast<YoutubeSong>();
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: favour.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: Image.network(
                                      favour[index].thumbnail!,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          favour[index].title!,
                                          style: AppTheme.headLine7,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          favour[index].duration ?? '00:00',
                                          style: AppTheme.headLine6,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.more_vert,
                                  color: AppTheme.backgroundColor,
                                  size: 20,
                                )
                              ]),
                              Divider(
                                thickness: 0.5,
                                color: Colors.grey.shade500,
                                indent: 65,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          )),
    );
  }
}
