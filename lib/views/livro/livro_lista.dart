import 'package:biblioteca/views/livro/livro_cadastrar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => LivroCadastrarView());
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
