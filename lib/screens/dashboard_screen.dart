import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/setting/app_value_notifier.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), backgroundColor: Colors.blue),
      drawer: Drawer(
        //menu de hamburguesa
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=65')),
              accountName: Text('Cristian David Cardoso'),
              accountEmail: Text('Cristian@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone), //elementos de lado izquiero y derecho
              title: Text("Practica 1"),
              subtitle: Text("Aqui esta la descripcion"),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              leading: Icon(Icons.shop), //elementos de lado izquiero y derecho
              title: Text("Mi despensa"),
              subtitle: Text("Relacion de productos que no voy a usar"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, "/despensa"),
            ),
            ListTile(
              leading: Icon(Icons.close), //elementos de lado izquiero y derecho
              title: Text("Salir"),
              subtitle: Text("hasta luego"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {
                Navigator.pop(context), //sacar el contextto del stack
                Navigator.pop(context)
              },
            ),
            ListTile(
              leading: Icon(Icons.close), //elementos de lado izquiero y derecho
              title: Text("Movies App"),
              subtitle: Text("Consulta de peliculas populares"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {Navigator.pushNamed(context, "/movies")},
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text("Mi despensa en Firebase "),
              subtitle: Text("Relacion de productos que no voy a usar"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, "/products"),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Mis peliculas favoritas"),
              subtitle: Text("Peliculas :)"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, "/favorites"),
            ),
            ListTile(
              leading: Icon(Icons
                  .app_registration_rounded), //elementos de lado izquiero y derecho
              title: Text("Registrar"),
              subtitle: Text("Registrar Usuario"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {Navigator.pushNamed(context, "/register")},
            ),
            ListTile(
              leading: Icon(Icons
                  .map_outlined), //elementos de lado izquiero y derecho
              title: Text("Ir a mapa"),
              subtitle: Text("Checar Mapa"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {Navigator.pushNamed(context, "/mapa")},
            ),
            DayNightSwitcher(
              isDarkModeEnabled: AppValueNotifier
                  .banTheme.value, //trae el valor del value notifier
              onStateChanged: (isDarkModeEnabled) {
                AppValueNotifier.banTheme.value = isDarkModeEnabled;
              },
            ),
          ],
        ),
      ),
    );
  }
}
