import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieItem extends StatefulWidget {
  // final VideoPlayerController vpc;
  final String ruta;
  final bool externo;
  final bool looping;

  const ChewieItem({Key key, @required this.ruta, this.looping, this.externo})
      : super(key: key);

  @override
  _ChewieItemState createState() => _ChewieItemState();
}

class _ChewieItemState extends State<ChewieItem> {
  ChewieController cc;
  VideoPlayerController vpc;

  @override
  void initState() {
    super.initState();
    print(widget.ruta);
    vpc = VideoPlayerController.network(widget.ruta);
    cc = ChewieController(
      allowFullScreen: true,
      videoPlayerController: vpc,
      aspectRatio: 16/9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage){
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: cc,
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    vpc.dispose();
    cc.dispose();
  }
}
