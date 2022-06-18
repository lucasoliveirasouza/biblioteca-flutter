import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:biblioteca/views/categoria/categoria_cadastrar.dart';
import 'package:biblioteca/views/categoria/categoria_editar.dart';
import 'package:biblioteca/views/categoria/categoria_livros.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoriaListaView extends StatefulWidget {
  const CategoriaListaView({Key? key}) : super(key: key);

  @override
  _CategoriaListaViewState createState() => _CategoriaListaViewState();
}

class _CategoriaListaViewState extends State<CategoriaListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => CategoriaCadatrarView());
            },
          )
        ],
      ),
      body: Consumer<CategoriaService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.categorias.length,
            itemBuilder: (BuildContext contexto, int categoria) {
              final List<Categoria> lista = repositorio.categorias;
              final item = lista[categoria].descricao;
              return Dismissible(
                key: Key(item),
                child: Card(
                  child: ListTile(
                    title: Center(child: Text(lista[categoria].descricao)),
                    onTap: () {
                      Get.to(() =>
                          CategoriaLivrosView(categoria: lista[categoria]));
                    },
                  ),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Deletar"),
                        content: const Text(
                            "Deseja realmente deletar essa categoria?"),
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
                onDismissed: (direction) {
                  Provider.of<CategoriaService>(context, listen: false)
                      .deletarCategoria(lista[categoria].id.toString());
                  Get.snackbar(
                    "Excluir autor",
                    "Categoria ${lista[categoria].descricao} excluída",
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

  deletar() {
    Get.defaultDialog(
      title: "Deseja deletar essa categoria?",
      titleStyle: TextStyle(color: Colors.green),
      middleTextStyle: TextStyle(color: Colors.white),
      onConfirm: () {
        Navigator.of(context).pop(false);
      },
      onCancel: () {
        Navigator.of(context).pop(false);
      },
      textConfirm: "Confirmar",
      textCancel: "Cancelar",
      cancelTextColor: Colors.green,
      confirmTextColor: Colors.white,
      buttonColor: Colors.green,
      radius: 1,
      content: Column(
        children: [],
      ),
    );
  }
}
