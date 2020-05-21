import 'package:academyapp/entities/user.dart';
import 'package:academyapp/services/firebase_auth.dart';
import 'package:academyapp/services/firestore_query.dart';
import 'package:academyapp/services/preferences.dart';
import 'package:academyapp/widgets/principal/principal.dart';
import 'package:academyapp/widgets/sesion/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  FirebaseAuthService fas = new FirebaseAuthService();
  FirestoreQueryService fqs = FirestoreQueryService.instance;

  @override
  void initState() {
    Preferencias.loadLoginFields().then((value) {
      if (value[0] == '' && value[1] == '')
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (build) => LoginScreen()));
      else {
        fas.handleAuth(value[0], value[1], _scaffoldKey).then((val) {
          if (val != null)
            fqs.getUserData(value[0]).then((value) {
              if (value.documents.length == 1) {
                User user = User();
                print(user.name);
                user.fromSnapshot(value.documents[0]);
                print(user.name);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              }
            });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'AcademyApp',
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 35),
            ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
