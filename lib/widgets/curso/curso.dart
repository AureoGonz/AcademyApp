import 'package:academyapp/entities/user.dart';
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
    User user = User();
    List<Widget> _panel;
    if (user.cursos.contains(curso.documentID))
      _panel = [
        Expanded(
            child: Center(
          child: Text('Está suscrito'),
        ))
      ];
    else
      _panel = [
        Expanded(
            child: ListView.builder(
                itemCount: curso.data['descripcion'].length,
                itemBuilder: (contex, index) {
                  // return Text(curso.data['descripcion'][index]);
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16, left: 16),
                    child: MarkdownBody(
                      data: curso.data['descripcion'][index],
                      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                          .copyWith(textAlign: WrapAlignment.spaceBetween, p: TextStyle(fontSize: 16)),
                    ),
                  );
                })),
        ButtonBar(
          buttonMinWidth: double.maxFinite,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              child: Text('Inscribirse'),
            )
          ],
        ),
      ];
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[Icon(Icons.brightness_medium)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: curso.data['thumbnail'],
            width: double.infinity,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
            child: Text(curso.data['title'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ..._panel
        ],
      ),
    );
  }
}
