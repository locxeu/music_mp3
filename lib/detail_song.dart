import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DetailSong extends StatefulWidget {
  DetailSong(
      {Key? key,
      required this.songModel,
      required this.audioPlayer,
      required this.index})
      : super(key: key);
  final List<SongModel> songModel;
  final AudioPlayer audioPlayer;
  int index;
  @override
  State<DetailSong> createState() => _DetailSongState();
}

class _DetailSongState extends State<DetailSong>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _isPlaying = false;
  bool _isRandomSong = false;
  bool _isRepeat = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = const Duration();
  Duration _position = const Duration();
  String position = '0';
  String duration = '0';
  Timer? timer;

  playSong(String? uri) {
    print('play song');
    try {
      widget.audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      widget.audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      print('error');
    }
    if (mounted) {
      widget.audioPlayer.durationStream.listen((d) {
        if (!mounted) {
          return;
        }
        setState(() {
          _duration = d!;
          duration = _duration.toString().split('.')[0];
        });
      });
    }
    streamPosition();
  }

  streamPosition() async {
    widget.audioPlayer.positionStream.listen((p) async {
      if (!mounted) {
        return;
      }
      setState(() {
        _position = p;
        position = _position.toString().split('.')[0];
      });
      if (position == duration) {
        if (_isRepeat) {
          widget.audioPlayer.setLoopMode(LoopMode.one);
          return;
        }
      }
    });
  }

  toNextSong() {
    setState(() {
      widget.audioPlayer.seekToNext();
    });
    // setState(() {
    //   widget.index = widget.index + 1;
    // });
    // widget.audioPlayer.pause();
    // widget.audioPlayer.setAudioSource(
    //     AudioSource.uri(Uri.parse(widget.songModel[widget.index].uri!)));
    // widget.audioPlayer.play();
  }

  playRandomSong() {
    setState(() {
      widget.index = Random().nextInt(widget.songModel.length);
    });
    widget.audioPlayer.pause();
    widget.audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(widget.songModel[widget.index].uri!)));
    widget.audioPlayer.play();
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }

  checkToNextSong() {
    if (position == duration) {
      print('next');
      toNextSong();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    playSong(widget.songModel[widget.index].uri);
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => checkToNextSong());
    _controller = AnimationController(
      duration: const Duration(minutes: 6),
      vsync: this,
    );
    if (mounted) {
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
    // widget.audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('hasNext ${widget.audioPlayer.hasNext}');
    print('hasPrevious ${widget.audioPlayer.hasPrevious}');
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon((Icons.arrow_back_ios))),
                  const Text(
                    'Now Playing',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.alarm)
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 5.0).animate(_controller),
                child: QueryArtworkWidget(
                    id: widget.songModel[widget.index].id,
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
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.blue,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.songModel[widget.index].displayNameWOExt,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.songModel[widget.index].artist ?? 'unknown',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  Text(_position.toString().split('.')[0]),
                  Expanded(
                      child: Slider(
                    min: const Duration(microseconds: 0).inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changeToSeconds(value.toInt());
                        value = value;
                      });
                    },
                  )),
                  Text(duration),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          _isRepeat = !_isRepeat;

                          print('_isRepeat $_isRepeat');
                        });
                      },
                      child: Image.asset(
                        'assets/images/loop_icon.png',
                        color: _isRepeat ? Colors.blue : Colors.black,
                      )),
                  StreamBuilder<SequenceState?>(
                    stream: widget.audioPlayer.sequenceStateStream,
                    builder: (context, snapshot) => IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: widget.audioPlayer.hasPrevious
                          ? widget.audioPlayer.seekToPrevious
                          : null,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (_isPlaying) {
                            print('pause');
                            widget.audioPlayer.pause();
                          } else {
                            widget.audioPlayer.play();
                          }
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: _isPlaying
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow)),
                  StreamBuilder<SequenceState?>(
                    stream: widget.audioPlayer.sequenceStateStream,
                    builder: (context, snapshot) => IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: widget.audioPlayer.hasNext
                          ? widget.audioPlayer.seekToNext
                          : null,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     if (_isRandomSong) {
                  //       playRandomSong();
                  //     } else {
                  //       toNextSong();
                  //     }
                  //   },
                  //   icon: Icon(Icons.skip_next),
                  // ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isRandomSong = !_isRandomSong;
                      });
                    },
                    child: Image.asset(
                      'assets/images/random_icon.png',
                      width: 24,
                      color: _isRandomSong ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
