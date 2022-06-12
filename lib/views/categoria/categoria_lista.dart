import 'package:flutter/material.dart';

class CategoriaListaView extends StatefulWidget {
  const CategoriaListaView({Key? key}) : super(key: key);

  @override
  _CategoriaListaViewState createState() => _CategoriaListaViewState();
}

class _CategoriaListaViewState extends State<CategoriaListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
      ),
    );
  }
}
