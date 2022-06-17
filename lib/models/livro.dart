import 'package:biblioteca/models/editora.dart';

import 'categoria.dart';

class Livro {
  late int _id;
  late String _titulo;
  late String _autor;
  late String _editora;
  late int _ano;
  late String _isbn;
  late String _imagem;

  late Categoria _categoria;



  Livro(this._id, this._titulo, this._autor, this._editora, this._ano,
      this._isbn, this._imagem);


  Categoria get categoria => _categoria;

  void setCategoria(Categoria value) {
    _categoria = value;
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

  String get editora => _editora;

  set editora(String value) {
    _editora = value;
  }

  String get autor => _autor;

  set autor(String value) {
    _autor = value;
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
