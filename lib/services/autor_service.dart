import 'dart:collection';
import 'dart:convert';
import 'package:biblioteca/models/autor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AutorService extends ChangeNotifier {
  List<Autor> _autores = [];

  UnmodifiableListView<Autor> get autores =>
      UnmodifiableListView(_autores);

  AutorService() {
    _buscarAutores();
  }

  _buscarAutores() async {
    String uri = 'https://biblioteca-lucas.herokuapp.com/api/autores';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaAutores = json;

      listaAutores.forEach((autor) {
        Autor at = Autor(autor["id"].toString(), autor["nome"]);
        _autores.add(at);
      });
      notifyListeners();
    }
  }

  Future<List<Autor?>?> getAll() async {
    List<Autor> aut = [];
    String uri = 'https://biblioteca-lucas.herokuapp.com/api/autores';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaautores = json;

      listaautores.forEach((autor) {
        Autor at = Autor(autor["id"].toString(), autor["nome"]);
        aut.add(at);
      });

    }
    return aut;
  }

  Future<http.Response> cadastrarAutor(String nome) async{
    final http.Response response = await http.post(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/autor'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final autor = json;
      print(autor["nome"]);
      Autor aut = Autor(autor["id"].toString(), autor["nome"]);
      _autores.add(aut);
      notifyListeners();
    }

    return response;
  }

  Future<http.Response> deletarAutor(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/autor/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    _autores.removeWhere((element) => element.id == id);
    notifyListeners();
    return response;
  }

  Future<http.Response> editarAutor(String id, String nome) async{
    final http.Response response = await http.put(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/autor'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'nome': nome,
      }),
    );

    _autores.forEach((element) {
      if (element.id == id) {
        element.nome = nome;
        notifyListeners();
      }
    });

    return response;
  }


}