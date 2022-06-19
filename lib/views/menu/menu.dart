import 'package:biblioteca/views/livro/livro_lista.dart';
import 'package:biblioteca/views/sobre/sobre.dart';
import 'package:flutter/material.dart';


import 'geral.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int _paginaAtual = 0;

  final List<Widget> _telas = [
    LivroListaView(),
    GeralView(),
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
              icon: Image.asset(
                "assets/images/book.png",
                width: 23,
                height: 23,
              ),
              activeIcon: Image.asset(
                "assets/images/bookclick.png",
                width: 28,
                height: 28,
              ),
              label: "Livros"
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/books.png",
                width: 25,
                height: 25,
              ),
              activeIcon: Image.asset(
                "assets/images/booksclick.png",
                width: 28,
                height: 28,
              ),
              label: "Geral"
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/about.png",
                width: 22,
                height: 22,
              ),
              activeIcon: Image.asset(
                "assets/images/aboutclick.png",
                width: 25,
                height: 25,
              ),
              label: "Sobre"
          ),
        ],
      ),
    );
  }
}
