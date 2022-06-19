
import 'package:biblioteca/services/auth_service.dart';
import 'package:biblioteca/services/autor_service.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:biblioteca/services/editora_service.dart';
import 'package:biblioteca/services/livro_service.dart';
import 'package:biblioteca/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CategoriaService()),
      ChangeNotifierProvider(create: (context) => LivroService()),
      ChangeNotifierProvider(create: (context) => EditoraService()),
      ChangeNotifierProvider(create: (context) => AutorService()),
      ChangeNotifierProvider(create: (context) => AuthService()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginView(),
    );
  }
}
