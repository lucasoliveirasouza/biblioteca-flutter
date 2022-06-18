import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/services/autor_service.dart';
import 'package:biblioteca/views/autor/autor_cadastrar.dart';
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
              Get.to(() => AutorCadastrarView());
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
              final item = lista[autor].nome;
              return Dismissible(
                key: Key(item),
                child: Card(
                  child: ListTile(
                    title: Center(child: Text(lista[autor].nome)),
                    onTap: () {
                      Get.to(() => AutorLivrosView(autor: lista[autor]));
                    },
                  ),
                ),
                onDismissed: (direction) {
                  Provider.of<AutorService>(context, listen: false)
                      .deletarAutor(lista[autor].id.toString());
                  Get.snackbar(
                    "Excluir autor",
                    "Autor ${lista[autor].nome} excluído",
                    backgroundColor: Colors.green.shade100,
                  );
                },
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Deletar"),
                        content: const Text(
                            "Deseja realmente deletar esse autor?"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Deletar",style: TextStyle(color: Colors.red),)),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancelar"),
                          ),
                        ],
                      );
                    },
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
