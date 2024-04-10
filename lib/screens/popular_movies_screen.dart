import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/network/api_popular.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({Key? key}) : super(key: key);

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  ApiPopular? apiPopular;
  int _selectedIndex = 0;

  @override
  void initState() {
    apiPopular = ApiPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _selectedIndex == 0 ? _buildPopularMovies() : SizedBox(), // Cambiando el contenido a mostrar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.center_focus_strong),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPopularMovies() {
    return FutureBuilder<List<PopularModel>?>(
      future: apiPopular!.getPopularMovie(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .7,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, "/detail", arguments: snapshot.data![index]);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('images/cargando.gif'),
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}'),
                  ),
                ),
              );
            },
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text("Ocurrió un error :("),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        // Si se selecciona el segundo elemento del BottomNavigationBar, navegar a la ruta /favorites
        Navigator.pushNamed(context, "/favorites").then((_) {
          // Después de regresar de la ruta /favorites, volver al índice 0 del BottomNavigationBar
          setState(() {
            _selectedIndex = 0;
          });
        });
      }
    });
  }
}