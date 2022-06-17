import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/services/editora_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditoraListaView extends StatefulWidget {
  const EditoraListaView({Key? key}) : super(key: key);

  @override
  _EditoraListaViewState createState() => _EditoraListaViewState();
}

class _EditoraListaViewState extends State<EditoraListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editoras"),
      ),
      body: Consumer<EditoraService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.editoras.length,
            itemBuilder: (BuildContext contexto, int editora) {
              final List<Editora> lista = repositorio.editoras;
              return Card(
                child: ListTile(
                  title: Center(child: Text(lista[editora].nome)),
                  onTap: (){
                    //Get.to(()=> CategoriaLivrosView(categoria: lista[categoria]));
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
