import 'dart:collection';
import 'dart:convert';

import 'package:biblioteca/models/categoria.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CategoriaService extends ChangeNotifier {
  List<Categoria> _categorias = [];

  UnmodifiableListView<Categoria> get categorias =>
      UnmodifiableListView(_categorias);

  CategoriaService() {
    _buscarCategorias();
  }

  _buscarCategorias() async {
    String uri = 'https://biblioteca-lucas.herokuapp.com/api/categorias';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaCategorias = json;

      listaCategorias.forEach((categoria) {
        Categoria c = Categoria(categoria["id"], categoria["descricao"]);
        _categorias.add(c);
      });
      notifyListeners();
    }
  }
}