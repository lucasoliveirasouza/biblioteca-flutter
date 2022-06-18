

import 'package:biblioteca/models/editora.dart';
import 'package:flutter/material.dart';

class DropdownEditora extends StatefulWidget {
  Future<List<Editora?>?> future;
  String initialValue;
  String child;
  List<String>? childList = [];
  String value;
  ValueChanged? onTap;
  Function(String)? onSelect;
  InputDecoration? decoration;

  DropdownEditora(
      {Key? key,
        required this.future,
        required this.initialValue,
        required this.child,
        required this.value,
        this.onSelect,
        this.decoration,
        this.onTap,
        this.childList})
      : super(key: key);

  @override
  State<DropdownEditora> createState() => _DropdownEditoraState();
}

class _DropdownEditoraState
    extends State<DropdownEditora> {
  @override
  dynamic get(String propriedade) {}

  Widget build(BuildContext context) {

    return FutureBuilder<List<Editora?>?>(
      future: widget.future as Future<List<Editora?>?>,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Sem dados');
        }
        if (snapshot.hasData) {
          if (widget.initialValue.isEmpty) {
            if (snapshot.data!.length > 0) {
              widget.initialValue = snapshot.data![0]?.toJson()[widget.value];
            } else {
              return Text('Não encontramos nenhum registro');
            }
          }
          return DropdownButtonFormField<String>(
            decoration: widget.decoration,
            icon: Icon(null),
            value: widget.initialValue,
            items: snapshot.data?.map((e) {
              String childListText = "";
              int cont = 0;
              widget.childList?.forEach((element) {
                String separador =
                (cont < widget.childList!.length.toInt() ? " >>> " : '');
                childListText += e?.toJson()[element] + separador;
                cont++;
              });

              return DropdownMenuItem<String>(
                child: widget.childList?.isEmpty ?? true
                    ? Text(e?.toJson()[widget.child])
                    : Text(childListText),
                value: e?.toJson()[widget.value],
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                widget.initialValue = value!;
                widget.onSelect!(value);
              });
            },
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}