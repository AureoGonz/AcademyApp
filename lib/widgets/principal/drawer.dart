import 'package:academyapp/entities/user.dart';
import 'package:academyapp/services/preferences.dart';
import 'package:academyapp/widgets/sesion/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawer createState() => _MainDrawer();
}

class _MainDrawer extends State<MainDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              child: FlutterLogo(
                size: 42.0,
              ),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            title: Text('Cambiar tema'),
            trailing: Icon(Icons.brightness_medium),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              title: Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              trailing: Icon(
                Icons.highlight_off,
                color: Colors.red,
              ),
              onTap: () {
                _auth.signOut();
                Preferencias.setLoginFields('', '');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ))
        ],
      ),
    );
  }
}
