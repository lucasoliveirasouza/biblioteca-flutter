import 'package:biblioteca/componentes/dropdown_autor.dart';
import 'package:biblioteca/componentes/dropdown_categoria.dart';
import 'package:biblioteca/componentes/dropdown_editora.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/services/autor_service.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:biblioteca/services/editora_service.dart';
import 'package:biblioteca/services/livro_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LivroEditarView extends StatefulWidget {
  Livro livro;

  LivroEditarView({Key? key, required this.livro}) : super(key: key);

  @override
  _LivroEditarViewState createState() => _LivroEditarViewState();
}

class _LivroEditarViewState extends State<LivroEditarView> {
  final titulo = TextEditingController();
  final isbn = TextEditingController();
  final ano = TextEditingController();
  final imagem = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String categoriaId = "";
  String editoraId = "";
  String autorId = "";
  String id_categoria = "";
  String id_editora = "";
  String id_autor = "";

  @override
  Widget build(BuildContext context) {
    titulo.text = widget.livro.titulo;

    isbn.text = widget.livro.isbn;
    imagem.text = widget.livro.imagem;
    ano.text = widget.livro.ano.toString();
    categoriaId = widget.livro.categoria.id;
    editoraId = widget.livro.editora.id;
    autorId = widget.livro.autor.id;
    id_categoria = widget.livro.categoria.id;
    id_editora = widget.livro.editora.id;
    id_autor = widget.livro.autor.id;

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Livro"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(right: 20, top: 20, left: 20),
          child: ListView(
            children: [
              TextFormField(
                controller: titulo,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("Título"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe o título do livro";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropdownAutor(
                decoration: InputDecoration(
                    labelText: "Autor",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(new Radius.circular(10)),
                    )),
                future: AutorService().getAll(),
                onSelect: (value) {
                  autorId = value;
                  id_autor = autorId;
                },
                initialValue: autorId,
                child: 'nome',
                value: 'id',
              ),
              SizedBox(
                height: 15,
              ),
              DropdownEditora(
                decoration: InputDecoration(
                    labelText: "Editora",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(new Radius.circular(10)),
                    )),
                future: EditoraService().getAll(),
                onSelect: (value) {
                  editoraId = value;
                  id_editora = editoraId;
                },
                initialValue: editoraId,
                child: 'nome',
                value: 'id',
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: ano,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("Ano"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe o ano do livro";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: isbn,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("ISBN"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe o ISBN do livro";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropdownCategoria(
                decoration: InputDecoration(
                    labelText: "Categoria",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(new Radius.circular(10)),
                    )),
                future: CategoriaService().getAll(),
                onSelect: (value) {
                  categoriaId = value;
                  id_categoria = categoriaId;
                },
                initialValue: categoriaId,
                child: 'descricao',
                value: 'id',
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: imagem,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("Link da capa"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe o link da imagem do livro";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Livro livro = Livro(widget.livro.id, titulo.text,
                          int.parse(ano.text), isbn.text, imagem.text);

                      Provider.of<LivroService>(context, listen: false)
                          .editarLivro(
                              livro, id_categoria, id_autor, id_editora)
                          .then((value) => {
                                Get.snackbar(
                                    "Edição de livro", value.toString(),
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
