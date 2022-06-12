
class Categoria{
  late String _id;
  late String _descricao;

  Categoria(this._id, this._descricao);

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'descricao': _descricao
  };
}