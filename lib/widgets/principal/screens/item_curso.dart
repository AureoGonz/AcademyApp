import 'package:academyapp/widgets/curso/curso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart'
    show kTransparentImage;

class ItemListaCurso extends StatelessWidget {
  final DocumentSnapshot curso;

  const ItemListaCurso({Key key, @required this.curso}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(top: 5, bottom: 5),
          leading: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: curso.data['thumbnail'],
            width: 96,
          ),
          title: Text(
            curso.data['title'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CursoScreen(curso: curso)));
          },
        ),
        Divider()
      ],
    );
  }
}
