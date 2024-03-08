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
    return Center(
      child: Text(popularModel.title!),
    );
  }
}