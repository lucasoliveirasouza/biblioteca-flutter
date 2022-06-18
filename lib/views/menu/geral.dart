
import 'package:biblioteca/componentes/card_item.dart';
import 'package:biblioteca/views/autor/autor_lista.dart';
import 'package:biblioteca/views/categoria/categoria_lista.dart';
import 'package:biblioteca/views/editora/editora_lista.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GeralView extends StatefulWidget {
  const GeralView({Key? key}) : super(key: key);

  @override
  _GeralViewState createState() => _GeralViewState();
}

class _GeralViewState extends State<GeralView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Itens Gerais"),
      ),
      body:Container(
    child: GridView.count(
    primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        CardItem(
          image: "autor.png",
          title: "Autores",
          onTap: () {
            Get.to(()=> AutorListaView());
          },
        ),
        CardItem(
          image: "categoria.png",
          title: "Categorias",
          onTap: () {
            Get.to(()=> CategoriaListaView());
          },
        ),
        CardItem(
          image: "editora.png",
          title: "Editoras",
          onTap: () {
            Get.to(()=> EditoraListaView());
          },
        ),

      ],
    )),
    );
  }
}
