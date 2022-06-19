import 'package:biblioteca/componentes/form_field_padrao.dart';
import 'package:biblioteca/services/auth_service.dart';
import 'package:biblioteca/views/auth/cadastrar_usuario.dart';
import 'package:biblioteca/views/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usuario = TextEditingController();
  final senha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 210),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Biblioteca",
                style: TextStyle(
                  fontSize: 40,
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
                  AuthService().logar(usuario.text, senha.text);
                  Get.to(() => MenuView());
                },
                child: Text("Entrar"),
              ),
            ),
            SizedBox(
              height: 180,
            ),

            Divider(
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 70,
              ),
              child: Row(
                children: [
                  Text(
                    "Não tem uma conta?",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(()=> CadastrarUsuarioView());
                    },
                    child: Text(
                      "Cadastre-se.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
