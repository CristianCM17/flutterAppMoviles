import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/popular_model.dart';

class ApiFavorites {
  final String apiKey = 'fd5039cfc59f36d773e26d865bdff53f';
  final String sessionId = '70256946d94f2c0d91c3f8d3cafdd373e39aceed';
  final String authorizedRequestToken =
      '63e83f7decbf60c5e8b6c086d8c443147527306e';

  Future<List<Map<String, dynamic>>> getFavoriteMovies() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.themoviedb.org/3/account/21105275/favorite/movies',
        queryParameters: {
          'api_key': apiKey,
          'session_id': sessionId,
        },
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> favoriteMovies =
            List<Map<String, dynamic>>.from(response.data['results']);
        return favoriteMovies;
      } else {
        throw Exception('Failed to retrieve favorite movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> addToFavorites(int movieId) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://api.themoviedb.org/3/account/21105275/favorite',
        queryParameters: {
          'api_key': apiKey,
          'session_id': sessionId,
        },
        data: {
          'media_type': 'movie',
          'media_id': movieId,
          'favorite': true,
        },
      );

      if (response.statusCode == 200) {
        print('Película agregada a favoritos');
      } else {
        print('Error al agregar a favoritos');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> removeFromFavorites(int movieId) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://api.themoviedb.org/3/account/21105275/favorite',
        queryParameters: {
          'api_key': apiKey,
          'session_id': sessionId,
        },
        data: {
          'media_type': 'movie',
          'media_id': movieId,
          'favorite': false,
        },
      );

      if (response.statusCode == 200) {
        print('Película eliminada de favoritos');
      } else {
        throw Exception('Error al eliminar la película de favoritos');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<PopularModel?> getMovieDetails(int movieId) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=fc94b66bb0314813cf7af53dd2cba49d&language=es-MX',
      );

      if (response.statusCode == 200) {
        return PopularModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve movie details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}