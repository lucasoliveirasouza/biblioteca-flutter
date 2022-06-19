import 'dart:collection';
import 'dart:convert';
import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/util/constantes.dart';
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
    String uri = '${servidor1}api/autores';
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
    String uri = '${servidor1}api/autores';
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

  Future<List<Livro>> getLivros(Autor autor) async {
    List<Livro> lv = [];
    String uri = '${servidor1}api/autor/${autor.id}/livros';
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

  Future<String> cadastrarAutor(String nome) async{
    final http.Response response = await http.post(
      Uri.parse('${servidor1}api/autor'),
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
      Autor aut = Autor(autor["id"].toString(), autor["nome"]);
      _autores.add(aut);
      notifyListeners();

      return "Cadatrado com sucesso";
    }else{
      return "Não foi possível realizar o cadastro";
    }


  }

  Future<String> editarAutor(String id, String nome) async{
    final http.Response response = await http.put(
      Uri.parse('${servidor1}api/autor'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'nome': nome,
      }),
    );

    if (response.statusCode == 200) {
      _autores.forEach((element) {
        if (element.id == id) {
          element.nome = nome;
          notifyListeners();
        }
      });
      return "Editado com sucesso";
    }else{
      return "Não foi possível editar";
    }
  }

  Future<http.Response> deletarAutor(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('${servidor1}api/autor/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    _autores.removeWhere((element) => element.id == id);
    notifyListeners();
    return response;
  }


}