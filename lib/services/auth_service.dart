import 'dart:convert';
import 'package:biblioteca/views/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:biblioteca/services/categoria_service.dart';

class AuthService extends ChangeNotifier{

  String _token = "";
  AuthService() {
    _authCheck();
  }

  _authCheck() {

    _token = "";
  }

  Future<String> logar(String usuario, String senha) async{
    final http.Response response = await http.post(
      Uri.parse("https://biblioteca-luc.herokuapp.com/api/auth/signin"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "password": senha,
        "username": usuario
      }),
    );
    if (response.statusCode == 200) {
      _token = jsonDecode(response.body)["accessToken"];
      final storage = new FlutterSecureStorage();
      await storage.write(key: "token", value: _token);
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CategoriaService())
        ],

      );
      Get.to(() => MenuView());
      return "Seja bem-vindo";
    }else{
      return "Existe algum erro com suas credenciais";
    }
  }

  String getToken(){
    return _token;
  }

  Future<String> registrar(String usuario,String email, String senha) async {
    final http.Response response = await http.post(
      Uri.parse("https://biblioteca-luc.herokuapp.com/api/auth/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": senha,
        "username": usuario
      }),
    );
    return jsonDecode(response.body)["message"] ?? "Não foi possível realizar o cadastro";
  }


}
