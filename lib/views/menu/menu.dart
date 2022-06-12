import 'package:biblioteca/views/categoria/categoria_lista.dart';
import 'package:biblioteca/views/livro/livro_lista.dart';
import 'package:biblioteca/views/sobre/sobre.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int _paginaAtual = 0;

  final List<Widget> _telas = [
    LivroListaView(),
    CategoriaListaView(),
    SobreView(),
  ];

  void mudarAba(int indice) {
    setState(() {
      _paginaAtual = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_paginaAtual],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _paginaAtual,
        onTap: mudarAba,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Livros"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Categorias"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_on),
              label: "Sobre"
          ),
        ],
      ),
    );
  }
}
