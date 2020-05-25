import 'package:academyapp/widgets/video_player/chewie.dart';
import 'package:flutter/material.dart';

class Video extends StatelessWidget {
  final String ruta;
  final bool externo;

  const Video({Key key, @required this.ruta, this.externo = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChewieItem(
        ruta: ruta,
        externo: externo,
        looping: false,
      ),
    );
  }
}