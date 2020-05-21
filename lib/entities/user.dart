import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String name;
  String lastName;
  String email;
  String id;
  List<String> cursos;

  FirebaseUser user;

  static final User _instance = User._internal();
  
  factory User() => _instance;
  
  User._internal();
  
  static User get instance => _instance;

  fromSnapshot(DocumentSnapshot document) {
    name = document.data['name'];
    lastName = document.data['lastName'];
    email = document.data['email'];
    cursos = List.from(document.data['cursos']);
    id = document.documentID;
  }
}