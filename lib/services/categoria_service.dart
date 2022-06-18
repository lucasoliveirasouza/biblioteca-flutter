import 'dart:collection';
import 'dart:convert';

import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/models/livro.dart';
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
        Categoria c = Categoria(categoria["id"].toString(), categoria["descricao"]);
        _categorias.add(c);
      });
      notifyListeners();
    }
  }

  Future<List<Categoria?>?> getAll() async {
    List<Categoria> cts = [];
    String uri = 'https://biblioteca-lucas.herokuapp.com/api/categorias';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaCategorias = json;

      listaCategorias.forEach((categoria) {
        Categoria c = Categoria(categoria["id"].toString(), categoria["descricao"]);
        cts.add(c);
      });

    }
    return cts;
  }

  Future<List<Livro>> getLivros(Categoria categoria) async {
    List<Livro> lv = [];
    String uri = 'https://biblioteca-lucas.herokuapp.com/api/categoria/${categoria.id}/livros';
    final response = await http
        .get(Uri.parse(uri), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaLivros = json;

      listaLivros.forEach((livro) {
        Livro l = Livro(livro["id"], livro["titulo"],livro["ano"], livro["isbn"], livro["imagem"]);

        Categoria c = Categoria(livro["categoria"]["id"].toString(), livro["categoria"]["descricao"]);
        l.setCategoria(c);

        Editora e = Editora(livro["editora"]["id"].toString(), livro["editora"]["nome"]);
        l.setEditora(e);

        Autor a = Autor(livro["autor"]["id"].toString(), livro["autor"]["nome"]);
        l.setAutor(a);

        lv.add(l);
      });
    }
    return lv;
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

    _categorias.clear();
    _buscarCategorias();
    notifyListeners();

    return response;
  }

  Future<http.Response> deletarCategoria(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/categoria/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    _categorias.clear();
    _buscarCategorias();
    notifyListeners();
    return response;
  }

  Future<http.Response> editarCategoria(String id, String descricao) async{
    final http.Response response = await http.put(
      Uri.parse('https://biblioteca-lucas.herokuapp.com/api/categoria'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'descricao': descricao,
      }),
    );

    _categorias.clear();
    _buscarCategorias();
    notifyListeners();

    return response;
  }


}