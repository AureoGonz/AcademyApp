import 'package:academyapp/entities/user.dart';
import 'package:academyapp/services/firestore_query.dart';
import 'package:academyapp/widgets/curso/item_tema.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:transparent_image/transparent_image.dart'
    show kTransparentImage;

class CursoScreen extends StatelessWidget {
  final DocumentSnapshot curso;

  const CursoScreen({Key key, @required this.curso}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreQueryService fqs = FirestoreQueryService();
    User user = User();
    List<Widget> _panel;
    if (user.cursos.contains(curso.documentID))
      _panel = [
        StreamBuilder(
            stream: fqs.getContentCurso(curso.documentID),
            builder: (builder, snapshot) {
              if (!snapshot.hasData)
                return SliverList(
                    delegate: SliverChildListDelegate([
                  Center(
                    child: Text('No hay datos en el curso'),
                  )
                ]));
              List<Map<String, dynamic>> contenido =
                  List.from(snapshot.data['contenido']);
              contenido.sort((a, b) => a['indice'] - b['indice']);
              contenido.retainWhere((e) => e['enLista']);
              print(contenido);
              List<Widget> temas =
                  contenido.map((e) => ItemListaTema(tema: e, idCurso: curso.documentID,)).toList();
              return SliverList(delegate: SliverChildListDelegate(temas));
            })
      ];
    else
      _panel = [
        SliverList(
            delegate: SliverChildListDelegate(
          [
            ButtonBar(
              buttonMinWidth: double.maxFinite,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    fqs.addCursoUser(curso.documentID).whenComplete(() {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => CursoScreen(curso: curso)));
                    });
                  },
                  child: Text('Inscribirse'),
                )
              ],
            ),
          ],
        )),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, right: 16, left: 16),
              child: MarkdownBody(
                data: curso.data['descripcion'][index],
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                    .copyWith(
                        textAlign: WrapAlignment.spaceBetween,
                        p: TextStyle(fontSize: 16)),
              ),
            );
          }, childCount: curso.data['descripcion'].length),
        ),
      ];
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 300.00,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
              centerTitle: true,
              title: Text(
                curso.data['title'],
                style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.35)),
              ),
              background: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: curso.data['thumbnail'],
                width: double.infinity,
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.brightness_medium,
                  ),
                  onPressed: () {})
            ],
          ),
          ..._panel
        ],
      ),
    );
  }
}
