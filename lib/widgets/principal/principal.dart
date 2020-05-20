import 'package:academyapp/widgets/principal/drawer.dart';
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
  Widget optionButton = MainSearchButton();

  @override
  void initState() {
    optionButton = MainSearchButton();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _auth.signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MainDrawer(),
      appBar: AppBar(leading: null, title: Text('Principal'), actions: <Widget>[
        optionButton,
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
        children: <Widget>[
          Center(
            child: Text('1'),
          ),
          Center(
            child: Text('2'),
          ),
          Center(
            child: Text('3'),
          )
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
          child: TabBar(tabs: [
        Tab(
          icon: IconButton(
              icon: Icon(
                Icons.home,
              ),
              onPressed: () {
                _tabController.animateTo(0);
                setState(() {
                  optionButton = MainSearchButton();
                });
              },
              tooltip: 'Cursos'),
        ),
        Tab(
          icon: IconButton(
              icon: Icon(
                Icons.class_,
              ),
              onPressed: () {
                _tabController.animateTo(1);
                setState(() {
                  optionButton = MainSearchButton2();
                });
              },
              tooltip: 'Mis Cursos'),
        ),
        Tab(
          icon: IconButton(
              icon: Icon(
                Icons.assessment,
              ),
              onPressed: () {
                _tabController.animateTo(2);
                setState(() {
                  optionButton = Container();
                });
              },
              tooltip: 'Skills'),
        )
      ], controller: _tabController)),
    );
  }
}

class MainSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.search), onPressed: () {});
  }
}

class MainSearchButton2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.send), onPressed: () {});
  }
}
