import 'package:flutter/material.dart';
import 'package:food_app/pages/HomePage.dart';
import 'package:food_app/registro.dart';
import 'package:food_app/login.dart';
import 'package:food_app/pages/lista.dart';
import 'package:food_app/pages/perfil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F5F3),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/registro': (context) => const RegistroView(),
        '/inicio': (context) => HomePage(),
        '/listaUsuarios': (context) => ListaUsuarios(),
        '/perfil': (context) => PerfilPage(),
      },
    );
  }
}