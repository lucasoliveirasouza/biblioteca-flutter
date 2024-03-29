import 'package:biblioteca/componentes/form_field_padrao.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoriaCadatrarView extends StatefulWidget {
  CategoriaCadatrarView({Key? key}) : super(key: key);

  @override
  _CategoriaCadatrarViewState createState() => _CategoriaCadatrarViewState();
}

class _CategoriaCadatrarViewState extends State<CategoriaCadatrarView> {
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
                          .cadastrarCategoria(descricao.text)
                          .then((value) => {
                                Get.snackbar(
                                    "Cadastro de categoria", value.toString(),
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
