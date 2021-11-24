import 'package:flutter/material.dart';
import 'package:flutter_examen_elias_2/agregar.dart';
import 'package:flutter_examen_elias_2/editar.dart';
import 'package:flutter_examen_elias_2/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => PrincipalPage(),
        '/create': (context) => AgregarPage(),
        '/update': (context) => EditarPage(),
      },
      home: PrincipalPage(),
    );
  }
}
