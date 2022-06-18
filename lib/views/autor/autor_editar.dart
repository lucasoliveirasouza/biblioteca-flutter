import 'package:biblioteca/componentes/form_field_padrao.dart';
import 'package:biblioteca/models/autor.dart';
import 'package:biblioteca/services/autor_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AutorEditarView extends StatefulWidget {
  Autor autor;
  AutorEditarView({Key? key, required this.autor}) : super(key: key);

  @override
  _AutorEditarViewState createState() => _AutorEditarViewState();
}

class _AutorEditarViewState extends State<AutorEditarView> {
  final nome = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    nome.text = widget.autor.nome;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar autor"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(right: 20, top: 20, left: 20),
          child: ListView(
            children: [
              FormFieldPadrao(
                controle: nome,
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
                      Provider.of<AutorService>(context, listen: false)
                          .editarAutor(
                          widget.autor.id.toString(), nome.text)
                          .then((value) => {
                        Get.snackbar(
                                    "Edição de autor", value.toString(),
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
