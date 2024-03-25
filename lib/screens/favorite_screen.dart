import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/network/api_favorites.dart';

class FavoritesMoviesScreen extends StatefulWidget {
  const FavoritesMoviesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesMoviesScreen> createState() => _FavoritesMoviesScreenState();
}

class _FavoritesMoviesScreenState extends State<FavoritesMoviesScreen> {
  final ApiFavorites apiFavorites = ApiFavorites();
  late Future<List<Map<String, dynamic>>> _favoriteMoviesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovies();
  }

  Future<void> _loadFavoriteMovies() async {
    setState(() {
      _favoriteMoviesFuture = apiFavorites.getFavoriteMovies();
    });
  }

  Future<void> _updateFavoriteMovies() async {
    _loadFavoriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Películas Favoritas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'K2D',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
      body: RefreshIndicator(
        onRefresh: _loadFavoriteMovies,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _favoriteMoviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                'No hay películas favoritas añadidas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'K2D',
                  fontWeight: FontWeight.w500,
                ),
              ));
            } else {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    final movieId = snapshot.data![index]['id'] as int;
                    final movieDetailsFuture =
                        apiFavorites.getMovieDetails(movieId);
                    return FutureBuilder<PopularModel?>(
                      future: movieDetailsFuture,
                      builder: (context, movieSnapshot) {
                        if (movieSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (movieSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${movieSnapshot.error}'));
                        } else if (movieSnapshot.hasData) {
                          final movieDetails = movieSnapshot.data!;
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                  context, "/detail",
                                  arguments: movieDetails);
                              if (result != null && result is bool && result) {
                                Navigator.pop(context);
                                _updateFavoriteMovies();
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage('images/load.gif'),
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text(
                                  'No se encontraron películas favoritas'));
                        }
                      },
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
