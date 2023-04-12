import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:medicamina/states.dart';

class MedicaminaAppWidget extends StatelessWidget {
  const MedicaminaAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Modular.get<MedicaminaThemeState>().setDarkMode(false);

    return MaterialApp.router(
      title: 'medicamina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: false).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange)),
      darkTheme: ThemeData.dark(useMaterial3: false).copyWith(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 88, 88, 88),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 88, 88, 88),
        ),
      ),
      themeMode: Modular.get<MedicaminaThemeState>().getThemeMode(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension 
  }
}