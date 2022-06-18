import 'dart:collection';
import 'dart:convert';
import 'package:biblioteca/models/editora.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditoraService extends ChangeNotifier {
  List<Editora> _editoras = [];

  UnmodifiableListView<Editora> get editoras =>
      UnmodifiableListView(_editoras);

  EditoraService() {
    _buscarEditoras();
  }

  _buscarEditoras() async {
    String uri = 'https://biblioteca-lucas.herokuapp.com/api/editoras';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaEditoras = json;

      listaEditoras.forEach((editora) {
        Editora ed = Editora(editora["id"].toString(), editora["nome"]);
        _editoras.add(ed);
      });
      notifyListeners();
    }
  }

  Future<List<Editora?>?> getAll() async {
    List<Editora> edt = [];
    String uri = 'https://biblioteca-lucas.herokuapp.com/api/editoras';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaEditoras = json;

      listaEditoras.forEach((editora) {
        Editora ed = Editora(editora["id"].toString(), editora["nome"]);
        edt.add(ed);
      });

    }
    return edt
    ;
  }

  Future<http.Response> cadastrarEditora(String nome) async{
    final http.Response response = await http.post(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/editora'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
      }),
    );

    _editoras.clear();
    _buscarEditoras();
    notifyListeners();

    return response;
  }

  Future<http.Response> deletarEditora(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/editora/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    _editoras.clear();
    _buscarEditoras();
    notifyListeners();
    return response;
  }

  Future<http.Response> editarEditora(String id, String nome) async{
    final http.Response response = await http.put(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/editora'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'nome': nome,
      }),
    );

    _editoras.clear();
    _buscarEditoras();
    notifyListeners();

    return response;
  }


}