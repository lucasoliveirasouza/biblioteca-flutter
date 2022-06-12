import 'dart:collection';
import 'dart:convert';

import 'package:biblioteca/models/livro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LivroService extends ChangeNotifier {
  List<Livro> _livros = [];

  UnmodifiableListView<Livro> get livros => UnmodifiableListView(_livros);

  CategoriaService() {
    _buscarLivros();
  }

  _buscarLivros() async {
    String uri = 'https://biblioteca-lucas.herokuapp.com/api/livros';
    final response = await http
        .get(Uri.parse(uri), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaLivros = json;

      listaLivros.forEach((livro) {
        Livro l = Livro(livro["id"], livro["titulo"], livro["autor"],
            livro["editora"], livro["ano"], livro["isbn"], livro["imagem"]);

        _livros.add(l);
      });
      notifyListeners();
    }
  }

  Future<http.Response> cadastrarCategoria(String descricao) async{
    final http.Response response = await http.post(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/categoria'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'descricao': descricao,
      }),
    );

    _categorias.add(Categoria(0, descricao));
    notifyListeners();

    return response;
  }
}
