import 'package:academyapp/widgets/tema/tema.dart';
import 'package:flutter/material.dart';

class ItemListaTema extends StatelessWidget {
  final Map<String, dynamic> tema;
  final String idCurso;

  const ItemListaTema({Key key, @required this.tema, @required this.idCurso})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tema['tipo'] == 2)
      return ExpansionTile(
        initiallyExpanded: true,
        title: Text(tema['titulo']),
        children: List.from(tema['items'])
            .map((e) => ListTile(
                  title: Text(e['titulo']),
                  onTap: () {
                    print(e['ref']);
                  },
                ))
            .toList(),
      );
    return ListTile(
      title: Text(tema['titulo']),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TemaScreen(
                idTema: tema['id'],
                idCurso: idCurso,
                tituloTema: tema['titulo'])));
      },
    );
  }
}
