import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:biblioteca/views/categoria/categoria_editar.dart';
import 'package:biblioteca/views/livro/livro_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoriaLivrosView extends StatefulWidget {
  Categoria categoria;

  CategoriaLivrosView({Key? key, required this.categoria}) : super(key: key);

  @override
  _CategoriaLivrosViewState createState() => _CategoriaLivrosViewState();
}

class _CategoriaLivrosViewState extends State<CategoriaLivrosView> {
  @override
  Widget build(BuildContext context) {
    Future<List<Livro>> futureList =
        Provider.of<CategoriaService>(context, listen: false)
            .getLivros(widget.categoria);

    Categoria categoria = widget.categoria;
    Provider.of<CategoriaService>(context).categorias.forEach((element) {
      if(element.id == widget.categoria.id){
        categoria = element;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(categoria.descricao),
        actions: [
          PopupMenuButton(
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                if(value=="editar"){
                  Get.to(()=> CategoriaEditarView(categoria: categoria));
                }else if(value == "deletar"){
                  deletar();

                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Editar",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      )
                    ],
                  ),
                  value: "editar",
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Deletar",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      )
                    ],
                  ),
                  value: "deletar",
                ),
              ])
        ],
      ),
        body: Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: FutureBuilder(
                future: futureList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Livro>> snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {

                        return Card(
                          child: ListTile(
                            leading: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(snapshot.data![index].imagem),
                          ),
                            title: Text(snapshot.data![index].titulo),
                            subtitle: Text(snapshot.data![index].autor.nome),
                            onTap: () {
                              Get.to(()=> LivroDetalhesView(livro: snapshot.data![index]));

                            },
                          ),
                        );
                      }));
                }
                ),
        ),
    );
  }

  deletar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Deletar"),
          content: const Text("Deseja realmente deletar essa categoria?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Provider.of<CategoriaService>(context, listen: false)
                    .deletarCategoria(widget.categoria.id.toString());
                Navigator.of(context).pop();
                Get.back();
                Get.snackbar("Excluir categoria", "Categoria excluída com sucesso",backgroundColor: Colors.green.shade100,);
              },
              child: Text(
                "Deletar",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}
