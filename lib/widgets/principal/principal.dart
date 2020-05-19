import 'package:academyapp/services/preferences.dart';
import 'package:academyapp/widgets/sesion/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Principal')),
      body: Center(child: FloatingActionButton(onPressed: (){
        _auth.signOut();
        Preferencias.setLoginFields('', '');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
      })),
    );
  }
}