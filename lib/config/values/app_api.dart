class AppApi {

  String urlSearch = 'aHR0cHM6Ly93d3cueW91dHViZS5jb20vcmVzdWx0cz9zZWFyY2hfcXVlcnk9';
  String urlBase = 'aHR0cHM6Ly93d3cueW91dHViZS5jb20=';
  String urlVideo = "aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj0=";
  static final AppApi _instance = AppApi._internal();

  factory AppApi(){
    return _instance;
  }

  AppApi._internal();
}