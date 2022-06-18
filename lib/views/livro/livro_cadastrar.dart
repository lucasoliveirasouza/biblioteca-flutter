import 'package:biblioteca/componentes/dropdown_padrao.dart';
import 'package:biblioteca/componentes/form_field_padrao.dart';
import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/services/autor_service.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:biblioteca/services/editora_service.dart';
import 'package:biblioteca/services/livro_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LivroCadastrarView extends StatefulWidget {
  LivroCadastrarView({Key? key}) : super(key: key);

  @override
  _LivroCadastrarViewState createState() => _LivroCadastrarViewState();
}

class _LivroCadastrarViewState extends State<LivroCadastrarView> {
  final titulo = TextEditingController();
  final isbn = TextEditingController();
  final ano = TextEditingController();
  final imagem = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String categoriaId = "";
  String editoraId = "";
  String autorId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Livro"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(right: 20, top: 20, left: 20),
          child: ListView(
            children: [
              FormFieldPadrao(
                controle: titulo,
                title: "Título",
              ),
              SizedBox(
                height: 15,
              ),
              DropdownPadrao<Autor>(
                nome: "Autor",
                future: AutorService().getAll(),
                onSelect: (value) {
                  autorId = value;
                },
                initialValue: autorId,
                child: 'nome',
                value: 'id',
              ),
              SizedBox(
                height: 15,
              ),
              DropdownPadrao<Editora>(
                nome: "Editora",
                future: EditoraService().getAll(),
                onSelect: (value) {
                  editoraId = value;
                },
                initialValue: editoraId,
                child: 'nome',
                value: 'id',
              ),
              SizedBox(
                height: 15,
              ),
              FormFieldPadrao(
                controle: ano,
                title: "Ano",
              ),
              SizedBox(
                height: 15,
              ),
              FormFieldPadrao(
                controle: isbn,
                title: "ISBN",
              ),
              SizedBox(
                height: 15,
              ),
              DropdownPadrao<Categoria>(
                nome: "Categoria",
                future: CategoriaService().getAll(),
                onSelect: (value) {
                  categoriaId = value;
                },
                initialValue: categoriaId,
                child: 'descricao',
                value: 'id',
              ),
              SizedBox(
                height: 15,
              ),
              FormFieldPadrao(
                controle: imagem,
                title: "Link da capa",
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Livro livro = Livro(0, titulo.text, int.parse(ano.text),
                          isbn.text, imagem.text);
                      Provider.of<LivroService>(context, listen: false)
                          .cadastrarLivro(
                              livro, categoriaId, autorId, editoraId)
                          .then((value) => {
                                Get.snackbar(
                                    "Cadastro de livro", value.toString(),
                                    backgroundColor: Colors.green.shade50)
                              });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
