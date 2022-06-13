import 'package:biblioteca/componentes/row_table.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/services/livro_service.dart';
import 'package:biblioteca/views/livro/livro_editar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LivroDetalhesView extends StatefulWidget {
  Livro livro;

  LivroDetalhesView({Key? key, required this.livro}) : super(key: key);

  @override
  _LivroDetalhesViewState createState() => _LivroDetalhesViewState();
}

class _LivroDetalhesViewState extends State<LivroDetalhesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro.titulo),
        actions: [
          PopupMenuButton(
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                if(value=="editar"){
                  Get.to(()=> LivroEditarView(livro: widget.livro));
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
        padding: EdgeInsets.only(left: 25,right: 25, top: 10,),
        child: ListView(
          children: [
            SizedBox(
              child: Image.network(widget.livro.imagem),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "Informações Gerais:",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RowTable(
              title: "Autor:",
              valor: widget.livro.autor,
            ),
            SizedBox(
              height: 3,
            ),
            RowTable(
              title: "Categoria:",
              valor: widget.livro.categoria.descricao,
            ),
            SizedBox(
              height: 3,
            ),
            RowTable(
              title: "ISBN:",
              valor: widget.livro.isbn,
            ),
            SizedBox(
              height: 3,
            ),
            RowTable(
              title: "Editora:",
              valor: widget.livro.editora,
            ),
            SizedBox(
              height: 3,
            ),
            RowTable(
              title: "Ano:",
              valor: widget.livro.ano.toString(),
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  deletar(){
    Get.defaultDialog(
        title: "Deseja excluir?",
        titleStyle: TextStyle(color: Colors.green),
        middleTextStyle: TextStyle(color: Colors.white),
        onConfirm: () {
          Livro livro = Livro(widget.livro.id, widget.livro.titulo, widget.livro.autor, widget.livro.editora, widget.livro.ano, widget.livro.isbn, widget.livro.imagem);

          Provider.of<LivroService>(context, listen: false).deletarLivro(livro,widget.livro.categoria);
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
