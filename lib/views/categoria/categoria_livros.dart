import 'package:biblioteca/models/categoria.dart';
import 'package:flutter/material.dart';

class CategoriaLivrosView extends StatefulWidget {
  Categoria categoria;
  CategoriaLivrosView({Key? key, required this.categoria}) : super(key: key);

  @override
  _CategoriaLivrosViewState createState() => _CategoriaLivrosViewState();
}

class _CategoriaLivrosViewState extends State<CategoriaLivrosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria.descricao),
      ),
    );
  }
}
