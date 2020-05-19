import 'package:academyapp/services/preferences.dart';
import 'package:academyapp/services/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirebaseAuthSevice {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Future<FirebaseUser> handleAuth(String email, String password,
      GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      this.user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      Preferencias.setLoginFields(email, password).then((value) => null);
      return this.user;
    } on PlatformException catch (e) {
      Preferencias.setLoginFields('', '').then((value) => null);
      switch (e.code) {
        case 'ERROR_WRONG_PASSWORD':
          SnackBarNotifier.showSnackBar(_scaffoldKey,
              msg: 'Contraseña incorrecta', dur: Duration(seconds: 2));
          break;
        case 'ERROR_USER_NOT_FOUND':
          SnackBarNotifier.showSnackBar(_scaffoldKey,
              msg: 'El usuario no existe', dur: Duration(seconds: 2));
          break;
        default:
          SnackBarNotifier.showSnackBar(_scaffoldKey,
              msg: 'Algo salío mal, contacte al programador',
              dur: Duration(seconds: 2));
          break;
      }
      return null;
    }
  }

  Future<FirebaseUser> handleSesion(String email, String password) async{
    this.user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      return this.user;
  }
}
