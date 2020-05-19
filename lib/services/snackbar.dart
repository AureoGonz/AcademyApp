import 'package:flutter/material.dart';

class SnackBarNotifier {
  static void showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey,
      {String msg: 'No hay internet', Duration dur: const Duration(days: 1)}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: dur,
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey,
    ));
  }
}
