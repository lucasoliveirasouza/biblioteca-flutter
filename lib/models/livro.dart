import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/models/editora.dart';

import 'categoria.dart';

class Livro {
  late int _id;
  late String _titulo;

  late int _ano;
  late String _isbn;
  late String _imagem;

  late Editora _editora;
  late Autor _autor;
  late Categoria _categoria;

  Livro(this._id, this._titulo, this._ano,
      this._isbn, this._imagem);


  Categoria get categoria => _categoria;

  void setCategoria(Categoria value) {
    _categoria = value;
  }

  Autor get autor => _autor;

  void setAutor(Autor value) {
    _autor = value;
  }

  Editora get editora => _editora;

  void setEditora(Editora value) {
    _editora = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

  String get isbn => _isbn;

  set isbn(String value) {
    _isbn = value;
  }

  int get ano => _ano;

  set ano(int value) {
    _ano = value;
  }


  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
