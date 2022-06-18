import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoriaEditarView extends StatefulWidget {
  Categoria categoria;

  CategoriaEditarView({Key? key, required this.categoria}) : super(key: key);

  @override
  _CategoriaEditarViewState createState() => _CategoriaEditarViewState();
}

class _CategoriaEditarViewState extends State<CategoriaEditarView> {
  final descricao = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    descricao.text = widget.categoria.descricao;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Categoria"),
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
                      Provider.of<CategoriaService>(context, listen: false)
                          .editarCategoria(
                              widget.categoria.id.toString(), descricao.text)
                          .then((value) => {
                                Get.snackbar(
                                    "Edição de autor", value.toString(),
                                    backgroundColor: Colors.green.shade50)
                              });
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
