import 'package:biblioteca/models/categoria.dart';
import 'package:biblioteca/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaListaView extends StatefulWidget {
  const CategoriaListaView({Key? key}) : super(key: key);

  @override
  _CategoriaListaViewState createState() => _CategoriaListaViewState();
}

class _CategoriaListaViewState extends State<CategoriaListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
      ),
      body: Consumer<CategoriaService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.categorias.length,
            itemBuilder: (BuildContext contexto, int categoria) {
              final List<Categoria> lista = repositorio.categorias;
              return Card(
                child: ListTile(
                  title: Text(lista[categoria].descricao),

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
