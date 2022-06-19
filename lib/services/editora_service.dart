import 'dart:collection';
import 'dart:convert';
import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/util/constantes.dart';
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
    String uri = '${servidor1}api/editoras';
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
    String uri = '${servidor1}api/editoras';
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
    return edt;
  }

  Future<List<Livro>> getLivros(Editora editora) async {
    List<Livro> lv = [];
    String uri = '${servidor1}api/editora/${editora.id}/livros';
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

  Future<String> cadastrarEditora(String nome) async{
    final http.Response response = await http.post(
      Uri.parse('${servidor1}api/editora'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final editora = json;
      print(editora["nome"]);
      Editora edit = Editora(editora["id"].toString(), editora["nome"]);
      _editoras.add(edit);
      notifyListeners();
      return "Cadatrado com sucesso";
    }else{
      return "Não foi possível realizar o cadastro";
    }
  }

  Future<String> editarEditora(String id, String nome) async{
    final http.Response response = await http.put(
      Uri.parse('${servidor1}api/editora'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'nome': nome,
      }),
    );

    if (response.statusCode == 200) {
      _editoras.forEach((element) {
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

  Future<http.Response> deletarEditora(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('${servidor1}api/editora/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    _editoras.removeWhere((element) => element.id == id);
    notifyListeners();
    return response;
  }

}