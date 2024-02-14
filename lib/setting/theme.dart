import 'package:flutter/material.dart';


//hacer nuestros propios temas en base a los dos existentes
class ThemeApp{
  static ThemeData lightTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith( //cambiar la estructura del themeLight
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color.fromARGB(255, 255, 0, 0)
      )
    );
  }

  static ThemeData darkTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith( //cambiar la estructura del themeLight
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: const Color.fromARGB(255, 18, 84, 18) //cambiar el color primario
      )
    );
  }

}