import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  Widget build(BuildContext context) {
    //recibir el objeto correspondiente a la pelicula mostrada
    final popularModel = ModalRoute.of(context)!.settings.arguments as PopularModel;
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(color: Color(0xFFD9D9D9))),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image:NetworkImage('https://image.tmdb.org/t/p/w500/${popularModel.backdropPath}'),
                fit: BoxFit.fill, //llenar completamente el contenedor
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: double.infinity, //poner el 100% del ancho del padre
              height: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,top:5,bottom: 0),
                      child: Container(
                        child: Text(
                          'Pelicula',
                          style: TextStyle(
                            color: Colors.black,
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
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'K2D',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      popularModel.releaseDate!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'K2D',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0,top: 8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD60303),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: Colors.white.withOpacity(0),
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Text(
                            'Promedio\n${popularModel.voteAverage}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontFamily: 'K2D',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(popularModel.overview!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontFamily: 'K2D',
                        fontWeight: FontWeight.w500,    
                      ),
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
