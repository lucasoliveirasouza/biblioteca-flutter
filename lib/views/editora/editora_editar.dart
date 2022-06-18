import 'package:biblioteca/models/editora.dart';
import 'package:biblioteca/services/editora_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditoraEditar extends StatefulWidget {
  Editora editora;
  EditoraEditar({Key? key, required this.editora}) : super(key: key);

  @override
  _EditoraEditarState createState() => _EditoraEditarState();
}

class _EditoraEditarState extends State<EditoraEditar> {
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
                          widget.editora.id.toString(), nome.text);
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
