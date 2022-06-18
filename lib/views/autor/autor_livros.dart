import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/services/autor_service.dart';
import 'package:biblioteca/services/livro_service.dart';
import 'package:biblioteca/views/autor/autor_editar.dart';
import 'package:biblioteca/views/livro/livro_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AutorLivrosView extends StatefulWidget {
  Autor autor;
   AutorLivrosView({Key? key, required this.autor}) : super(key: key);

  @override
  _AutorLivrosViewState createState() => _AutorLivrosViewState();
}

class _AutorLivrosViewState extends State<AutorLivrosView> {

  @override
  Widget build(BuildContext context) {

    Future<List<Livro>> futureList =
    Provider.of<AutorService>(context, listen: false)
        .getLivros(widget.autor);

    Autor autor = widget.autor;
    Provider.of<AutorService>(context).autores.forEach((element) {
      if(element.id == widget.autor.id){
        autor = element;
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(autor.nome),
        actions: [
          PopupMenuButton(
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                if(value=="editar"){
                  Get.to(()=> AutorEditarView(autor: widget.autor));
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

  deletar(){
    Get.defaultDialog(
      title: "Deseja deletar essa categoria?",
      titleStyle: TextStyle(color: Colors.green),
      middleTextStyle: TextStyle(color: Colors.white),
      onConfirm: () {
        Provider.of<AutorService>(context, listen: false)
            .deletarAutor(widget.autor.id.toString());
        Get.close(0);
        Get.back();
        Get.snackbar("Excluir autor", "Autor excluída com sucesso",backgroundColor: Colors.green.shade100);
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
