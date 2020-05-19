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

    @override
  void initState() {
    Preferencias.loadLoginFields().then((value){
      if(value[0]==''&&value[0]=='')
      Navigator.of(context).push(MaterialPageRoute(builder: (build)=>LoginScreen()));
      else
      Navigator.of(context).push(MaterialPageRoute(builder: (build)=>MainScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('AcademyApp', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 35),),
        SizedBox(height: 40,),
        CircularProgressIndicator()
      ],
    ),),);
  }
}
