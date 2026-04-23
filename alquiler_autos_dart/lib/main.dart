import 'package:flutter/material.dart';
import 'package:flutter_application_9_alquilerautos/views/detalle_auto.dart';
import 'package:flutter_application_9_alquilerautos/views/menu_Principal.dart';
import 'package:flutter_application_9_alquilerautos/views/register_screen.dart';
import 'package:flutter_application_9_alquilerautos/widgets/menu_drawer_perfil.dart';
import 'views/Login_Screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alquiler Autos',
      home: Scaffold(body: LoginScreen(),
      ),
      routes: {
        '/LoginScreen': (constex)=> LoginScreen(),
        '/RegisterScreen': (constex)=> RegisterScreen(),
        '/MenuPrincipal': (constex)=> MenuPrincipal(),
        '/MenuDrawerPerfil': (constex)=> MenuDrawerPerfil(),
        
        

      },
    );
  }
}