import 'package:academyapp/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
            child: Center(
          child: Text('No está suscrito'),
        )),
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
                const EdgeInsets.only(top: 16, bottom: 8, left: 32, right: 8),
            child: Text(curso.data['title'],
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ..._panel
        ],
      ),
    );
  }
}
