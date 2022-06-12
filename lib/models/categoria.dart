
class Categoria{
  late int _id;
  late String _descricao;

  Categoria(this._id, this._descricao);

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}