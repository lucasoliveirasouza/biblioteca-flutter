import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/services/editora_service.dart';
import 'package:biblioteca/views/editora/editora_cadastrar.dart';
import 'package:biblioteca/views/editora/editora_livros.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => EditoraCadastrarView());
            },
          )
        ],
      ),
      body: Consumer<EditoraService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.editoras.length,
            itemBuilder: (BuildContext contexto, int editora) {
              final List<Editora> lista = repositorio.editoras;
              final item = lista[editora].nome;
              return Dismissible(
                key: Key(item),
                child: Card(
                  child: ListTile(
                    title: Center(child: Text(lista[editora].nome)),
                    onTap: (){
                      Get.to(()=> EditoraLivrosView(editora: lista[editora]));
                    },
                  ),
                ),
                onDismissed: (direction) {
                  Provider.of<EditoraService>(context, listen: false)
                      .deletarEditora(lista[editora].id.toString());
                  Get.snackbar(
                    "Excluir autor",
                    "Editora ${lista[editora].nome} excluída",
                    backgroundColor: Colors.green.shade100,
                  );
                },
                background: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment(-0.9, 0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
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
