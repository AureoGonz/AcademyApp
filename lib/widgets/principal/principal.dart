import 'package:academyapp/entities/user.dart';
import 'package:academyapp/services/firestore_query.dart';
import 'package:academyapp/services/preferences.dart';
import 'package:academyapp/widgets/principal/drawer.dart';
import 'package:academyapp/widgets/principal/screens/cursos.dart';
import 'package:academyapp/widgets/principal/screens/mis_cursos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  FocusNode mainFocusNode = FocusNode();
  FocusNode myFocusNode = FocusNode();
  Widget headerOption;

  FirestoreQueryService fqs = FirestoreQueryService.instance;
  User user = User();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    mainFocusNode.dispose();
    myFocusNode.dispose();
    _auth.signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MainDrawer(),
      appBar: AppBar(
          leading: null,
          title: headerOption ?? mainSearchText(context),
          actions: <Widget>[
            IconButton(
                icon: CircleAvatar(
                  child: FlutterLogo(
                    size: 27.0,
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openEndDrawer();
                }),
          ]),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ListCursos(),
          new ListaMisCursos(),
          Center(
            child: Text('3'),
          )
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
          child: TabBar(
        tabs: [
          Tab(
            child: Text('Cursos'),
            icon: Icon(Icons.class_),
          ),
          Tab(child: Text('Mis cursos'), icon: Icon(Icons.widgets)),
          Tab(
            child: Text('Habilidades'),
            icon: Icon(
              Icons.assessment,
            ),
          )
        ],
        controller: _tabController,
        onTap: (i) {
          setState(() {
            switch (i) {
              case 0:
                headerOption = mainSearchText(context);
                break;
              case 1:
                headerOption = mySearchText(context);
                break;
              default:
                headerOption = Text('Habilidades');
                break;
            }
          });
        },
      )),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Preferencias.loadEmailUser().then((value) => giveUser(value));
        setState(() {
          
        });
      }),
    );
  }

  Widget mainSearchText(BuildContext context) {
    return TextField(
      focusNode: mainFocusNode,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        print('desde 1');
      },
      onSubmitted: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      decoration: InputDecoration(
          hintText: 'Buscar cursos',
          suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
              })),
    );
  }

  Widget mySearchText(BuildContext context) {
    return TextFormField(
      focusNode: myFocusNode,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        print('desde 2');
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      decoration: InputDecoration(
          hintText: 'Buscar en mis cursos',
          suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
              })),
    );
  }

  void giveUser(String email) {
    print(user.id);
  }
}
