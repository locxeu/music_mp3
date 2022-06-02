class Images {
  static const String help = 'assets/images/types/help.svg';
  static const String failure = 'assets/images/types/failure.svg';
  static const String success = 'assets/images/types/success.svg';
  static const String warning = 'assets/images/types/warning.svg';
  static const String back = 'assets/images/back.svg';
  static const String bubbles = 'assets/images/bubbles.svg';


//Relax Playist
  static const String coffe = 'assets/images/relax/coffe.jpg';
  static const String meditation = 'assets/images/relax/meditation.jpg';
  static const String piano = 'assets/images/relax/piano.jpg';

//Bottom Bar
  static const String home = 'assets/images/bottom_bar/home.svg';
  static const String lib = 'assets/images/bottom_bar/library.svg';
  static const String search = 'assets/images/bottom_bar/search.svg';
  static const String sdcard = 'assets/images/bottom_bar/sd-card.svg';

  static final Images _instance = Images._internal();

  factory Images(){
    return _instance;
  }

  Images._internal();
}