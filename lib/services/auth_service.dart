import 'dart:convert';

import 'package:biblioteca/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{

  AuthService() {
    _authCheck();
  }

  _authCheck() {

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
    print(jsonDecode(response.body));
    return "Sucesso";
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
    print(jsonDecode(response.body)["message"]);
    return "sucesso";
  }


}
