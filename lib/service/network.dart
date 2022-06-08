
import 'package:dio/dio.dart';
import 'package:music_mp3_app/config/logger.dart';

class NetworkCall{
  Dio dio = Dio();

  Future<dynamic> post(Map<String, dynamic> body, String url, bool isFormData) async {

    print("Link: $url");
    print("Body: $body");

    try {
      FormData _formData = FormData.fromMap(body);

      final response = await dio.post(url,
          data: isFormData == true ? _formData : body);

      print("Response: ${response.data}");

      return response.data;
    } on DioError catch (error) {
      throw dioErrorHandle(error);
    }
  }
  
  Future<dynamic> get( String url) async {

    print("Link: $url");

    try {

      final response = await dio.get(url,
         );

      print("Response: ${response.data}");

      return response.data;
    } on DioError catch (error) {
      throw dioErrorHandle(error);
    }
  }

  factory NetworkCall(){
    return NetworkCall._internal();
  }

  NetworkCall._internal();
}

NetworkCall networkCall = NetworkCall();

Map<String, dynamic> dioErrorHandle(DioError error) {
  UtilLogger.log("ERROR", error);

  print("Error: ${error.response?.data}");

  switch (error.type) {
    case DioErrorType.response:
      return error.response?.data;
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return {"success": false, "code": "request_time_out"};

    default:
      return {"success": false, "code": "connect_to_server_fail"};
  }
}