import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/services/livro_service.dart';
import 'package:biblioteca/views/livro/livro_cadastrar.dart';
import 'package:biblioteca/views/livro/livro_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/image.dart' as img;

class LivroListaView extends StatefulWidget {
  const LivroListaView({Key? key}) : super(key: key);

  @override
  _LivroListaViewState createState() => _LivroListaViewState();
}

class _LivroListaViewState extends State<LivroListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Livros"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => LivroCadastrarView());
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Consumer<LivroService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.livros.length,
            itemBuilder: (BuildContext contexto, int livro) {
              final List<Livro> lista = repositorio.livros;
              return Card(
                child: ListTile(
                  title: Text(
                    lista[livro].titulo,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(lista[livro].autor),
                  leading: SizedBox(
                    height: 50,
                    width: 50,
                    child: img.Image.network(lista[livro].imagem),
                  ),
                  onTap: () {
                    Get.to(()=> LivroDetalhesView(livro: lista[livro]));
                  },
                ),
              );
            },
            separatorBuilder: (_, __) => Container(),
            padding: EdgeInsets.all(16),
          );
        },
      ),
    );
  }
}
