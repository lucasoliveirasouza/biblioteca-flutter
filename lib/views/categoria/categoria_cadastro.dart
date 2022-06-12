import 'package:biblioteca/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoriaCadatroView extends StatefulWidget {
  CategoriaCadatroView({Key? key}) : super(key: key);

  @override
  _CategoriaCadatroViewState createState() => _CategoriaCadatroViewState();
}

class _CategoriaCadatroViewState extends State<CategoriaCadatroView> {
  final descricao = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Categoria"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(right: 20, top: 20, left: 20),
          child: ListView(
            children: [
              TextFormField(
                controller: descricao,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("Nome"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe o nome da categoria";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(right: 50, left: 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Provider.of<CategoriaService>(context, listen: false).cadastrarCategoria(descricao.text);
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