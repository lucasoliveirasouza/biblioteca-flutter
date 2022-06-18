import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/services/autor_service.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.autor.nome),
        actions: [
          PopupMenuButton(
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                if(value=="editar"){
                  //Get.to(()=> CategoriaEditarView(categoria: widget.categoria));
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
