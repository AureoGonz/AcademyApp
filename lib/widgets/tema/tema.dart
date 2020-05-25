import 'package:academyapp/services/firestore_query.dart';
import 'package:flutter/material.dart';

class TemaScreen extends StatelessWidget {
  final String idTema;
  final String idCurso;
  final String tituloTema;
  static final FirestoreQueryService fqs = FirestoreQueryService();

  const TemaScreen(
      {Key key,
      @required this.idTema,
      @required this.idCurso,
      @required this.tituloTema})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloTema),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.brightness_medium), onPressed: () {})
        ],
      ),
      body: Center(
        child: Text(tituloTema),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        fqs.getItemsContent(idCurso, idTema).forEach((element) {
          print(element);
        });
      }),
    );
  }
}
