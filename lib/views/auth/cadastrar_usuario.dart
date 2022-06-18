import 'package:biblioteca/componentes/form_field_padrao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastrarUsuarioView extends StatefulWidget {
  const CadastrarUsuarioView({Key? key}) : super(key: key);

  @override
  _CadastrarUsuarioViewState createState() => _CadastrarUsuarioViewState();
}

class _CadastrarUsuarioViewState extends State<CadastrarUsuarioView> {
  final usuario = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmarSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 210),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Registre-se",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            FormFieldPadrao(
              controle: usuario,
              title: "Usuário",
            ),
            SizedBox(
              height: 20,
            ),
            FormFieldPadrao(
              controle: senha,
              title: "Senha",
              obscure: true,
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 55,
              child: ElevatedButton(
                onPressed: (){
                  //Get.to(() => MenuView());
                },
                child: Text("Cadastrar"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Realizar login.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
