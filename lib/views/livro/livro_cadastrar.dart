import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LivroCadastrarView extends StatefulWidget {
  LivroCadastrarView({Key? key}) : super(key: key);

  @override
  _LivroCadastrarViewState createState() => _LivroCadastrarViewState();
}

class _LivroCadastrarViewState extends State<LivroCadastrarView> {
  final titulo = TextEditingController();
  final autor = TextEditingController();
  final editora = TextEditingController();
  final isbn = TextEditingController();
  final ano = TextEditingController();
  final imagem = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
              TextFormField(
                controller: autor,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("Autor"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe o autor do livro";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: editora,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("Editora"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe a editora do livro";
                  }
                  return null;
                },
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
                      //Provider.of<CategoriaService>(context, listen: false).cadastrarCategoria(descricao.text);
                      Get.back();
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