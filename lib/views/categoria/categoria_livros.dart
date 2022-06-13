import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/models/livro.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:biblioteca/views/livro/livro_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoriaLivrosView extends StatefulWidget {
  Categoria categoria;

  CategoriaLivrosView({Key? key, required this.categoria}) : super(key: key);

  @override
  _CategoriaLivrosViewState createState() => _CategoriaLivrosViewState();
}

class _CategoriaLivrosViewState extends State<CategoriaLivrosView> {
  @override
  Widget build(BuildContext context) {
    Future<List<Livro>> futureList =
        Provider.of<CategoriaService>(context, listen: false)
            .getLivros(widget.categoria);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria.descricao),
      ),
        body: Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: FutureBuilder(
                future: futureList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Livro>> snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {

                        return Card(
                          child: ListTile(
                            leading: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(snapshot.data![index].imagem),
                          ),
                            title: Text(snapshot.data![index].titulo),
                            subtitle: Text(snapshot.data![index].autor),
                            onTap: () {
                              Get.to(()=> LivroDetalhesView(livro: snapshot.data![index]));
                            },
                          ),
                        );
                      }));
                }
                ),
        ),
    );
  }
}
