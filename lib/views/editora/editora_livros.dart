import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/services/editora_service.dart';
import 'package:biblioteca/views/editora/editora_editar.dart';
import 'package:biblioteca/views/livro/livro_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditoraLivrosView extends StatefulWidget {
  Editora editora;
  EditoraLivrosView({Key? key, required this.editora}) : super(key: key);

  @override
  _EditoraLivrosViewState createState() => _EditoraLivrosViewState();
}

class _EditoraLivrosViewState extends State<EditoraLivrosView> {


  @override
  Widget build(BuildContext context) {
    Future<List<Livro>> futureList =
    Provider.of<EditoraService>(context, listen: false)
        .getLivros(widget.editora);

    Editora editora = widget.editora;
    Provider.of<EditoraService>(context).editoras.forEach((element) {
      if(element.id == widget.editora.id){
        editora = element;
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(editora.nome),
        actions: [
          PopupMenuButton(
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                if(value=="editar"){
                  Get.to(()=> EditoraEditarView(editora: editora));
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
        Provider.of<EditoraService>(context, listen: false)
            .deletarEditora(widget.editora.id.toString());
        Get.close(0);
        Get.back();
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
