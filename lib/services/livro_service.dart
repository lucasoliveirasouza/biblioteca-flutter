import 'dart:collection';
import 'dart:convert';
import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LivroService extends ChangeNotifier {
  List<Livro> _livros = [];
  final storage = new FlutterSecureStorage();

  UnmodifiableListView<Livro> get livros => UnmodifiableListView(_livros);

  LivroService() {
    _buscarLivros();
  }

  _buscarLivros() async {
    String? value = await storage.read(key: "token");
    String uri = '${servidor1}api/livros';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaLivros = json;

      listaLivros.forEach((livro) {
        Livro l = Livro(livro["id"], livro["titulo"], livro["ano"],
            livro["isbn"], livro["imagem"]);

        Categoria c = Categoria(livro["categoria"]["id"].toString(),
            livro["categoria"]["descricao"]);
        l.setCategoria(c);

        Editora e = Editora(
            livro["editora"]["id"].toString(), livro["editora"]["nome"]);
        l.setEditora(e);

        Autor a =
            Autor(livro["autor"]["id"].toString(), livro["autor"]["nome"]);
        l.setAutor(a);

        _livros.add(l);
      });
      notifyListeners();
    }
  }

  Future<String> cadastrarLivro(Livro livro, String id_categoria,
      String id_autor, String id_editora) async {
    String? value = await storage.read(key: "token");
    final http.Response response = await http.post(
      Uri.parse(
          "${servidor1}api/livro/${id_categoria}/${id_autor}/${id_editora}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: jsonEncode(<String, String>{
        "ano": livro.ano.toString(),
        "imagem": livro.imagem,
        "isbn": livro.isbn,
        "titulo": livro.titulo,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final livro = json;

      print(livro["titulo"]);

      Livro lv = Livro(livro["id"], livro["titulo"], livro["ano"],
          livro["isbn"], livro["imagem"]);

      Categoria c = Categoria(
          livro["categoria"]["id"].toString(), livro["categoria"]["descricao"]);
      lv.setCategoria(c);

      Editora e =
          Editora(livro["editora"]["id"].toString(), livro["editora"]["nome"]);
      lv.setEditora(e);

      Autor a = Autor(livro["autor"]["id"].toString(), livro["autor"]["nome"]);
      lv.setAutor(a);

      _livros.add(lv);
      notifyListeners();

      return "Cadatrado com sucesso";
    } else {
      return "Não foi possível realizar o cadastro";
    }
  }

  Future<String> editarLivro(Livro livro, String id_categoria, String id_autor,
      String id_editora) async {
    String? value = await storage.read(key: "token");
    final http.Response response = await http.put(
      Uri.parse(
          "${servidor1}api/livro/${id_categoria}/${id_autor}/${id_editora}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: jsonEncode(<String, String>{
        'id': livro.id.toString(),
        "ano": livro.ano.toString(),
        "imagem": livro.imagem,
        "isbn": livro.isbn,
        "titulo": livro.titulo,
      }),
    );

    if (response.statusCode == 200) {
      _livros.forEach((element) {
        if (element.id == livro.id) {
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            final livro = json;
            element.titulo = livro["titulo"];
            element.ano = livro["ano"];
            element.isbn = livro["isbn"];
            element.imagem = livro["imagem"];
            element.categoria.id = livro["categoria"]["id"].toString();
            element.categoria.descricao = livro["categoria"]["descricao"];
            element.editora.id = livro["editora"]["id"].toString();
            element.editora.nome = livro["editora"]["nome"];
            element.autor.id = livro["autor"]["id"].toString();
            element.autor.nome = livro["autor"]["nome"];
            notifyListeners();
          }
        }
      });
      return "Editado com sucesso";
    } else {
      return "Não foi possível editar";
    }
  }

  Future<http.Response> deletarLivro(String id_livro) async {
    String? value = await storage.read(key: "token");
    final http.Response response = await http.delete(
      Uri.parse(
          "${servidor1}api/livro/${id_livro}/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
    );

    if (response.statusCode == 200) {
      _livros.removeWhere((element) => element.id.toString() == id_livro);
      notifyListeners();
    }else{

    }


    return response;
  }
}
