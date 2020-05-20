import 'package:firebase_auth/firebase_auth.dart';

class User {
  String name;
  String lastName;
  String email;
  String id;
  List<String> cursos;
  FirebaseUser user;

  static final User _instance = User._internal();
  
  factory User()=> _instance;
  
  User._internal(){
  }
  
  static User get instance => _instance;
}