
import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/videos_model.dart';

class ApiVideo{

final dio= Dio();

Future<VideoModel?> getOficialVideo(String idVideo) async {
  Response response = await dio.get("https://api.themoviedb.org/3/movie/${idVideo}/videos?api_key=fd5039cfc59f36d773e26d865bdff53f");

  if (response.statusCode == 200) {
    final jsonList = response.data['results'];

    for (var json in jsonList) {
      if (json['name'] == "Official Trailer") {
        return VideoModel.fromMap(json);
      }
    }
  }
  return null;
}
}