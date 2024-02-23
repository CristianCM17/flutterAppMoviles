import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/setting/app_value_notifier.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), backgroundColor: Colors.blue),
      drawer: Drawer( //menu de hamburguesa
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
            DayNightSwitcher(
              isDarkModeEnabled: AppValueNotifier.banTheme.value, //trae el valor del value notifier
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
