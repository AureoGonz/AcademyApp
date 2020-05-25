import 'package:academyapp/services/firestore_query.dart';
import 'package:academyapp/widgets/video_player/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TemaScreen extends StatelessWidget {
  final String idTema;
  final String idCurso;
  final String tituloTema;
  static final FirestoreQueryService fqs = FirestoreQueryService();
  static final ScrollController _scrollController = ScrollController();

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
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: fqs.getItemsContent(idCurso, idTema),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  List<DocumentSnapshot> docs = snapshot.data.documents;
                  docs.sort((a, b) => a['indice'] - b['indice']);
                  List<Widget> temas = docs
                      .map((e) => itemTema(e.data, context))
                      .toList();
                  return ListView(
                    children: temas,
                    controller: _scrollController,
                  );
                }),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(onPressed: () {
        fqs.getItemsContent(idCurso, idTema).forEach((element) {
          element.documents.forEach((e) {
            print(e.data);
          });
        });
      }),
    );
  }

  Widget itemTema(Map<String, dynamic> item, BuildContext context) {
    switch (item['tipo']) {
      case 0:
        return ListTile(title: Text('item no soportad'));
      case 1:
        return Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16, left: 16),
          child: MarkdownBody(
              data: item['data'],
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                  .copyWith(
                      textAlign: WrapAlignment.spaceBetween,
                      p: TextStyle(fontSize: 16))),
        );
      case 2:
        return Video(ruta: item['data']);
      default:
        return ListTile(title: Text('item no soportad'));
    }
  }
}
