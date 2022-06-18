
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
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  "Autores",
                ),
                subtitle: Text("Todos autores disponíveis"),
                onTap: (){
                  Get.to(()=> AutorListaView());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                    "Categoria",
                ),
                subtitle: Text("Todas categorias disponíveis"),
                onTap: (){
                  Get.to(()=> CategoriaListaView());
                },

              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Editora",
                ),
                subtitle: Text("Todas editoras disponíveis"),
                onTap: (){
                  Get.to(()=> EditoraListaView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
