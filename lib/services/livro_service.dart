import 'dart:collection';
import 'dart:convert';

import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LivroService extends ChangeNotifier {
  List<Livro> _livros = [];

  UnmodifiableListView<Livro> get livros => UnmodifiableListView(_livros);

  LivroService() {
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
        Livro l = Livro(livro["id"], livro["titulo"], livro["ano"], livro["isbn"], livro["imagem"]);

        Categoria c = Categoria(livro["categoria"]["id"].toString(), livro["categoria"]["descricao"]);
        l.setCategoria(c);

        Editora e = Editora(livro["editora"]["id"].toString(), livro["editora"]["nome"]);
        l.setEditora(e);

        Autor a = Autor(livro["autor"]["id"].toString(), livro["autor"]["nome"]);
        l.setAutor(a);

        _livros.add(l);
      });
      notifyListeners();
    }
  }

  Future<http.Response> cadastrarLivro(Livro livro, String id_categoria,String id_autor, String id_editora) async{
    print("https://biblioteca-lucas.herokuapp.com//api/livro/${id_categoria}/${id_autor}/${id_editora}");
    final http.Response response = await http.post(
      Uri.parse("https://biblioteca-lucas.herokuapp.com//api/livro/${id_categoria}/${id_autor}/${id_editora}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "ano": livro.ano.toString(),
        "imagem": livro.imagem,
        "isbn": livro.isbn,
        "titulo": livro.titulo,
      }),
    );

    _livros.clear();
    _buscarLivros();
    notifyListeners();

    return response;
  }

  Future<http.Response> editarLivro(Livro livro, String id_categoria,String id_autor,String id_editora) async{
  print("https://biblioteca-lucas.herokuapp.com/api/livro/${id_categoria}/${id_autor}/${id_editora}");
    final http.Response response = await http.put(
      Uri.parse("https://biblioteca-lucas.herokuapp.com/api/livro/${id_categoria}/${id_autor}/${id_editora}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': livro.id.toString(),
        "ano": livro.ano.toString(),
        "imagem": livro.imagem,
        "isbn": livro.isbn,
        "titulo": livro.titulo,
      }),
    );

    _livros.clear();
    _buscarLivros();
    notifyListeners();

    return response;
  }

  Future<http.Response> deletarLivro(String id_livro) async {
    print("https://biblioteca-lucas.herokuapp.com/api/livro/${id_livro}");
    final http.Response response = await http.delete(
      Uri.parse("https://biblioteca-lucas.herokuapp.com/api/livro/${id_livro}/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    _livros.clear();
    _buscarLivros();
    notifyListeners();
    return response;
  }
}
