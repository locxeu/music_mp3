import 'package:just_audio/just_audio.dart';

class Instances{
  static  AudioPlayer player =AudioPlayer();
  static  Duration currentPosition =Duration.zero;

  static final Instances _instances = Instances._internal();
  factory Instances() {
    return _instances;
  }

  Instances._internal();
}