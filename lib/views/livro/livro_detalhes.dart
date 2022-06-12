import 'package:biblioteca/componentes/row_table.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              onSelected: (value) {},
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
}
