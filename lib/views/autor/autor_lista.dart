import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/services/autor_service.dart';
import 'package:biblioteca/views/autor/autor_cadastrar_editar.dart';
import 'package:biblioteca/views/autor/autor_livros.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AutorListaView extends StatefulWidget {
   AutorListaView({Key? key}) : super(key: key);

  @override
  _AutorListaViewState createState() => _AutorListaViewState();
}

class _AutorListaViewState extends State<AutorListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autores"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => AutorCadastrarEditarView());
            },
          )
        ],
      ),
      body: Consumer<AutorService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.autores.length,
            itemBuilder: (BuildContext contexto, int autor) {
              final List<Autor> lista = repositorio.autores;
              return Card(
                child: ListTile(
                  title: Center(child: Text(lista[autor].nome)),
                  onTap: (){
                    Get.to(()=> AutorLivrosView(autor: lista[autor]));
                  },
                ),
              );
            },
            separatorBuilder: (_, __) => Container(),
            padding: EdgeInsets.all(16),
          );
        },
      ),
    );
  }
}
