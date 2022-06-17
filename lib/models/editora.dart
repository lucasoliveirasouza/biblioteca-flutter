class Editora {
  late String _id;
  late String _nome;

  Editora(this._id, this._nome);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Map<String, dynamic> toJson() => {'id': id, 'nome': _nome};

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}
