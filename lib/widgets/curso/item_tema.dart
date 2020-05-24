import 'package:flutter/material.dart';

class ItemListaTema extends StatelessWidget {
  final Map<String, dynamic> tema;

  const ItemListaTema({Key key, @required this.tema}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tema['tipo'] == 2)
      return ExpansionTile(
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
        print(tema['id']);
      },
    );
  }
}
