import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/services/editora_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditoraEditarView extends StatefulWidget {
  Editora editora;
  EditoraEditarView({Key? key, required this.editora}) : super(key: key);

  @override
  _EditoraEditarViewState createState() => _EditoraEditarViewState();
}

class _EditoraEditarViewState extends State<EditoraEditarView> {
  final nome = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    nome.text = widget.editora.nome;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar editora"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(right: 20, top: 20, left: 20),
          child: ListView(
            children: [
              TextFormField(
                controller: nome,
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
                    return "Informe o nome da editora";
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
                      Provider.of<EditoraService>(context, listen: false)
                          .editarEditora(
                          widget.editora.id.toString(), nome.text).then((value) => {
                        Get.snackbar(
                            "Edição de editora", value.toString(),
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
