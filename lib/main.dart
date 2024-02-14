import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/setting/app_value_notifier.dart';
import 'package:flutter_application_1/setting/theme.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppValueNotifier.banTheme, //el valor del value que cambia en base al boton
      builder: (context, value, child) {
        return MaterialApp(
          theme: value ? ThemeApp.darkTheme(context) : ThemeApp.lightTheme(context) , //cambia cuando se apreta el boton
          home: SplashScreen(),
          routes: { //darle alias a las rutas
            "/dash" : (BuildContext context) => DashboardScreen(),
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