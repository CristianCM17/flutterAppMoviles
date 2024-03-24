import 'package:dio/dio.dart';


class ApiGenres{

 
 final Dio dio = Dio();

  Future<List<String>?> getGenres(int movieId) async {
    final URL =
        "https://api.themoviedb.org/3/movie/$movieId?api_key=fd5039cfc59f36d773e26d865bdff53f&language=es-MX";

    try {
      Response response = await dio.get(URL);
      if (response.statusCode == 200) {
        final List<dynamic> genres = response.data['genres'];
        List<String> genreNames =
            genres.map((genre) => genre['name'].toString()).toList();
        return genreNames;
      }
    } catch (e) {
      print("Error al obtener los géneros: $e");
    }
    return null;
  }

}