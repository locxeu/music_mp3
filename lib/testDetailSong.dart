
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_mp3_app/common.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/controlButton.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'extension/extension.dart';
class DetailSong2 extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final VoidCallback onTap;
  final List<SongModel> songmodel;
  final Stream<PositionData> positionData;
  const DetailSong2(
      {Key? key,
      required this.audioPlayer,
      required this.onTap,
      required this.songmodel,
      required this.positionData})
      : super(key: key);

  @override
  State<DetailSong2> createState() => _DetailSong2State();
}

class _DetailSong2State extends State<DetailSong2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(minutes: 6),
      vsync: this,
    );
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            // HeaderPlayingSong(onTap: widget.onTap,),
             SizedBox(
              height: context.height*0.08,
            ),
                StreamBuilder(
                stream: widget.audioPlayer.currentIndexStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child:  Text(''),
                    );
                  }
                  return   RotationTransition(
              turns: Tween(begin: 0.0, end: 5.0).animate(_controller),
              child: QueryArtworkWidget(
                  id: widget.songmodel[int.parse(snapshot.data.toString())].id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 200,
                  artworkHeight: 200,
                  artworkBorder: BorderRadius.circular(100),
                  keepOldArtwork: true,
                  nullArtworkWidget: const CircleAvatar(
                    radius: 100, // Image radius
                    backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Circle-icons-music.svg/2048px-Circle-icons-music.svg.png'),
                  )),
            );
                }),
          
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: widget.audioPlayer.currentIndexStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child:  Text(''),
                    );
                  }
                  return SizedBox(
                    height: 82,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                        child: Text(
                          widget.songmodel[int.parse(snapshot.data.toString())]
                              .displayNameWOExt,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style:
                              AppTheme.headLine1,
                        ),
                      ),
                      ],
                    ),
                  );
                }),
                      const SizedBox(
                height: 10,
              ),
               StreamBuilder(
                stream: widget.audioPlayer.currentIndexStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child:  Text(''),
                    );
                  }
                  return Center(
                    child: Text(
                      widget.songmodel[int.parse(snapshot.data.toString())]
                          .artist??'Unknow',
                      textAlign: TextAlign.center,
                      style:
                         AppTheme.headLine2,
                    ),
                  );
                }),
             const SizedBox(
              height: 10,
            ),
            StreamBuilder<PositionData>(
              stream: widget.positionData,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: (newPosition) {
                    widget.audioPlayer.seek(newPosition);
                  },
                );
              },
            ),
             SizedBox(
              height: context.height*0.02,
            ),
            ControlButtons(widget.audioPlayer),
            Row(
                children: [
                  StreamBuilder<LoopMode>(
                    stream: widget.audioPlayer.loopModeStream,
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
                          widget.audioPlayer.setLoopMode(cycleModes[
                              (cycleModes.indexOf(loopMode) + 1) %
                                  cycleModes.length]);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Local Song",
                      style: AppTheme.headLine3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: widget.audioPlayer.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? const Icon(Icons.shuffle, color: Colors.orange)
                            : const Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () async {
                          final enable = !shuffleModeEnabled;
                          if (enable) {
                            await widget.audioPlayer.shuffle();
                          }
                          await widget.audioPlayer.setShuffleModeEnabled(enable);
                        },
                      );
                    },
                  ),
                  // GestureDetector(
                  //    onTap: (){
                  //      log('kk');
                  //     Instances.player.setAudioSource(AudioSource.uri(Uri.parse('https://rr5---sn-42u-i5olz.googlevideo.com/videoplayback?expire=1654857014&ei=1siiYsfgJreA2roPtfi-oAg&ip=1.55.108.212&id=o-AAtE6lFs42U-GygM_oLwmZfrZu3zlRQaXxI3S1d0EuZ-&itag=251&source=youtube&requiressl=yes&mh=bJ&mm=31%2C26&mn=sn-42u-i5olz%2Csn-oguelnsy&ms=au%2Conr&mv=m&mvi=5&pl=24&initcwndbps=2477500&vprv=1&mime=audio%2Fwebm&gir=yes&clen=3684679&dur=242.081&lmt=1540865848284047&mt=1654835096&fvip=5&keepalive=yes&fexp=24001373%2C24007246&c=ANDROID&txp=5411222&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRAIgVLvFAgynnAItE92ESaeN2f_UHrIULoH3D0cLeDujIUUCIGIVOFJ32hdJQ2wXPU5HzlI6grrA61lW-Ghgsf9EFQaZ&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhALlYwEe0apGIirakqupZ-5vivOVvKxN_D-qQnS8jSUmFAiAF6SEnqqa7M3Q7ZwrVPer2w0nzi7fzUj-goVChLEvAfQ%3D%3D')));
                  //     Instances.player.play();
                  //   },
                  //   child:  Text('haha',style: AppTheme.headLine2,))
                ],
              ),
          ],
        ),
    );
  }
}
