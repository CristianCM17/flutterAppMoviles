import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/network/api_actors.dart';
import 'package:flutter_application_1/network/api_favorites.dart';
import 'package:flutter_application_1/network/api_genres.dart';
import 'package:flutter_application_1/network/api_video.dart';
import 'package:flutter_application_1/setting/app_value_notifier.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  ApiVideo? apiVideo;
  ApiActors? apiActors;
  ApiGenres apiGenres = ApiGenres();

    bool isFavorite = false;
    final ApiFavorites apiFavorites = ApiFavorites();
    Key favoriteKey = UniqueKey();

  @override
  void initState() {
    apiVideo = ApiVideo();
    apiActors = ApiActors();
    super.initState();
  }

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIsFavorite();
  }

  @override
  Widget build(BuildContext context) {
    //recibir el objeto correspondiente a la pelicula mostrada
    final popularModel =
        ModalRoute.of(context)!.settings.arguments as PopularModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white),
            tooltip: 'Agregar a favoritos',
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.black),
        child: ListView(
          children: [
            FutureBuilder(
              future: apiVideo!.getOficialVideo(popularModel.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Indicador de carga mientras se espera la respuesta de la API
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Mostrar mensaje de error si falla la obtención de datos
                } else if (snapshot.hasData) {
                  // Si se ha obtenido un VideoModel válido, crea el controlador de YouTube
                  YoutubePlayerController _controller = YoutubePlayerController(
                    initialVideoId: snapshot.data!.key!,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: true,
                    ),
                  );

                  // Construye el reproductor de YouTube
                  return YoutubePlayer(
                      controller: _controller,
                      bottomActions: [
                        ProgressBar(isExpanded: true,)
                      ],
                      showVideoProgressIndicator: false,
                      progressIndicatorColor: Colors.red,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.redAccent,
                      ),);
                } else {
                  // Si no hay datos disponibles (puede ocurrir durante la inicialización)
                  return Container(
                    child: Text("Esta pelicula no tiene un trailer Oficial",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'K2D',
                          fontWeight: FontWeight.w500,
                        )),
                  ); // o cualquier otro widget que desees mostrar
                }
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity, //poner el 100% del ancho del padre
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 5, bottom: 0),
                      child: Container(
                        child: Text(
                          'Pelicula',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'K2D',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      popularModel.title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'K2D',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          popularModel.releaseDate!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'K2D',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                        Flexible(
                          child: FutureBuilder<List<String>?>(
                            future: apiGenres.getGenres(popularModel.id as int),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                List<String>? genres = snapshot.data;
                                if (genres != null && genres.isNotEmpty) {
                                  return SizedBox(
                                    height:
                                        30.0, // Altura del ListView horizontal
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: genres.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          padding: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff9b9b9b),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: Text(
                                            genres[index],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontFamily: 'K2D',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const Text(
                                    'No se encontraron géneros para esta película.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              } else {
                                return const Text(
                                  'No se encontraron géneros para esta película.',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 8.0),
                      child: RatingStars(
                        value: popularModel.voteAverage!,
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                        ),
                        starCount: 10,
                        starSize: 20,
                        valueLabelColor: const Color(0xff9b9b9b),
                        valueLabelTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        valueLabelRadius: 10,
                        maxValue: 10,
                        starSpacing: 2,
                        maxValueVisibility: true,
                        valueLabelVisibility: true,
                        animationDuration: Duration(milliseconds: 1000),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: Colors.yellow,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        popularModel.overview!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: 'K2D',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future:
                          apiActors!.getActorsMovie(popularModel.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Indicador de carga mientras se espera la respuesta de la API
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Mostrar mensaje de error si falla la obtención de datos
                        } else if (snapshot.hasData) {
                          return Container(
                            margin: EdgeInsets.only(top: 10),
                            child: FlutterCarousel(
                              options: CarouselOptions(
                                showIndicator: false,
                                slideIndicator: CircularSlideIndicator(),
                                autoPlay: true,
                              ),
                              items: snapshot.data!.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    if (i.profilePath != null) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${i.profilePath}',
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          i.name!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'K2D',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      );
                                    }
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'images/user_actor.webp',
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        i.name!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'K2D',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        } else {
                          // Si no hay datos disponibles (puede ocurrir durante la inicialización)
                          return Center(
                            child: Text("Creo no hay internet o algo"),
                          ); // o cualquier otro widget que desees mostrar
                        }
                      },
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
    void _checkIsFavorite() async {
    final popularModel =
        ModalRoute.of(context)!.settings.arguments as PopularModel;
    try {
      final favoriteMovies = await apiFavorites.getFavoriteMovies();
      setState(() {
        isFavorite =
            favoriteMovies.any((movie) => movie['id'] == popularModel.id);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _toggleFavorite() async {
    final popularModel =
        ModalRoute.of(context)!.settings.arguments as PopularModel;
    try {
      if (isFavorite) {
        await apiFavorites.removeFromFavorites(popularModel.id!).then((value) => AppValueNotifier.banfavorites.value =
                                          !AppValueNotifier.banfavorites.value);
      } else {
        await apiFavorites.addToFavorites(popularModel.id!).then((value) => AppValueNotifier.banfavorites.value =
                                          !AppValueNotifier.banfavorites.value);
      }

      _checkIsFavorite();

      setState(() {
        favoriteKey = UniqueKey();
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
