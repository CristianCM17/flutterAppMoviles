import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/actors_model.dart';


class ApiActors{

 
  final dio= Dio();
  
Future<List<ActorsModel>?> getActorsMovie(String idMovie) async {
  Response response = await dio.get("https://api.themoviedb.org/3/movie/${idMovie}/credits?api_key=ff24b7bbb0fc4a4369dcb8cd87fa1f48&language=es-MX");

  if (response.statusCode == 200) {
    //parsear los results del primer nivel de json y convertirlo en lista
    final listActorsMap = response.data['cast']; 

    //cada iteracion se va agregar a una nueva lista que se va a retornar y se convertira en un objeto
         return listActorsMap
          .map<ActorsModel>((actor) => ActorsModel.fromMap(actor))
          .toList();
  }
  return null;
}

}