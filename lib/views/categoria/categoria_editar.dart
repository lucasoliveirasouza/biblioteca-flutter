import 'package:biblioteca/componentes/form_field_padrao.dart';
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
              FormFieldPadrao(
                controle: descricao,
                title: "Nome",
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
                                    "Edição de categoria", value.toString(),
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
