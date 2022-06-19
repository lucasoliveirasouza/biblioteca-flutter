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

  Future<String> registrar(String usuario,String email, String senha) async {
    final http.Response response = await http.post(
      Uri.parse('${servidor1}api/autor'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nome': usuario,
      }),
    );
    return "sucesso";
  }


}
