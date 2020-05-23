import 'package:academyapp/services/firestore_query.dart';
import 'package:academyapp/widgets/principal/screens/item_curso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaMisCursos extends StatelessWidget {
  final FirestoreQueryService fqs = FirestoreQueryService();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Expanded(
            child: StreamBuilder(
                stream: fqs.allMisCursos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text('No hay cursos'),
                    );
                  List<DocumentSnapshot> docs = snapshot.data.documents;
                  List<Widget> cursos =
                      docs.map((e) => ItemListaCurso(curso: e)).toList();
                  return ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      ...cursos,
                    ],
                  );
                }))
      ],
    ));
  }
}
