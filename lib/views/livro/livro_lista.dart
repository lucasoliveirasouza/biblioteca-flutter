import 'package:flutter/material.dart';

class LivroListaView extends StatefulWidget {
  const LivroListaView({Key? key}) : super(key: key);

  @override
  _LivroListaViewState createState() => _LivroListaViewState();
}

class _LivroListaViewState extends State<LivroListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Livros"),
      ),
    );
  }
}
