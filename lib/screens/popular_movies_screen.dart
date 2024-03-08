
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/network/api_popular.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {

  ApiPopular? apiPopular;

  @override
  void initState() {
    apiPopular = ApiPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder( 
        future: apiPopular!.getPopularMovie(), //el futuro que ejecutara
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot){
          if (snapshot.hasData) {
             return GridView.builder(
              itemCount: snapshot.data!.length,
              //comportamiento
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //cuantas columnas quieres
                crossAxisCount: 2,
                childAspectRatio: .7,
                mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      //vamos a el detail mandando argumentos
                      Navigator.pushNamed(context, "/detail", arguments: snapshot.data![index]);
                    },
                    child: ClipRRect( //para esquinas redondeadas
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage( 
                        placeholder: const AssetImage('images/cargando.gif'), //que se muestre el cargando antes de que se muestre la imagen
                        image: NetworkImage('https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}'),   
                      ),
                    ),
                  );
                },
             );
          }else{
            if (snapshot.hasError) {
              return Container(
                child: Text("Ocurrio un error :("),
              );
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }


        }
        ),
    );
  }
}