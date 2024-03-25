import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Register_Screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/despensa_screen.dart';
import 'package:flutter_application_1/screens/detail_movie_screen.dart';
import 'package:flutter_application_1/screens/favorite_screen.dart';
import 'package:flutter_application_1/screens/onBoarding_screen.dart';
import 'package:flutter_application_1/screens/popular_movies_screen.dart';
import 'package:flutter_application_1/screens/products_firebase_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/setting/app_value_notifier.dart';
import 'package:flutter_application_1/setting/theme.dart';



void main() async {
  //integracion con firebase
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyCvILr4r1MPu4HfDn72LRD9NGY-3fY8gd4", // paste your api key here
      appId:
          "com.example.flutter_application_1", //paste your app id here
      messagingSenderId: "483027289801", //paste your messagingSenderId here
      projectId: "pmsn-bbc53", //paste your project id here
    ),
  );

  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppValueNotifier.banTheme, //el valor del value que cambia en base al boton
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value ? ThemeApp.darkTheme(context) : ThemeApp.lightTheme(context) , //cambia cuando se apreta el boton
          home: SplashScreen(),
          routes: { //darle alias a las rutas
            "/dash" : (BuildContext context) => DashboardScreen(),
            "/despensa" : (BuildContext context) => DespensaScreen(),
            "/onboard" : (BuildContext context) => OnBoardingScreen(),
            "/movies" : (BuildContext context) => PopularMoviesScreen(),
            "/detail" : (BuildContext context) => DetailMovieScreen(),
            "/register" : (BuildContext context) => PickImage(),
            "/products" : (BuildContext context) => ProductsFirebaseScreen(), 
            "/favorites" : (BuildContext context) => FavoritesMoviesScreen()
          },
        );
      }
    );
  }
}


/*
  int contador = 0; //Al agregar variables aqui tendremos que quitar "const del constructor de la parte de arriba"

  @override
  Widget build(BuildContext context) {
    //int contador = 0; Cada vez que se de un clic en la interfaz esta variable volvera a valer 0.
    return MaterialApp(
      //Inicio del cuerpo de la interfaz
      home: Scaffold(
        appBar: AppBar(
          title: Text("Practica 1",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(), //Barra de navegacion lateral
        floatingActionButton: FloatingActionButton(//Boton flotante en el fondo
          onPressed: () {
            contador++;
            print(contador);
          },
          child: Icon(Icons.ads_click), //Elemento hijo del boton flotante
          backgroundColor: Colors.red,
        ),
        body: Center(child: Image.network("https://celaya.tecnm.mx/wp-content/uploads/2021/02/cropped-FAV.png", height: 250,))
      ),
    );
  }
}*/