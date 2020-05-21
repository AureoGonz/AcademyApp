import 'package:academyapp/services/firestore_query.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListCursos extends StatelessWidget {
  final FirestoreQueryService fqs = FirestoreQueryService();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: fqs.allCursos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text('No hay cursos'),
                    );
                  List<DocumentSnapshot> docs = snapshot.data.documents;
                  List<Widget> cursos = docs
                      .map((e) => ListTile(title: Text(e.data['title'])))
                      .toList();
                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...cursos,
                    ],
                  );
                }))
      ],
    ));
  }
}
