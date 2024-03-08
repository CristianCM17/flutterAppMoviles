
import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/popular_model.dart';

class ApiPopular{

  final URL = "https://api.themoviedb.org/3/movie/popular?api_key=ff24b7bbb0fc4a4369dcb8cd87fa1f48&language=es-MX&page=1";
  final dio= Dio();
  
Future<List<PopularModel>?> getPopularMovie() async {
  Response response = await dio.get(URL);

  if (response.statusCode == 200) {
    //parsear los results del primer nivel de json y convertirlo en lista
    final listMoviesMap = response.data['results']; 

    //cada iteracion se va agregar a una nueva lista que se va a retornar y se convertira en un objeto
         return listMoviesMap
          .map<PopularModel>((movie) => PopularModel.fromMap(movie))
          .toList();
  }
  return null;
}

}