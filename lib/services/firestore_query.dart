import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreQueryService {
  static final Firestore fs = Firestore.instance;

  static final FirestoreQueryService _instance =
      FirestoreQueryService._internal();

  factory FirestoreQueryService() => _instance;

  FirestoreQueryService._internal();

  static FirestoreQueryService get instance => _instance;

  Stream<QuerySnapshot> allCursos() {
    return fs.collection('cursos').where('visible', isEqualTo: true).snapshots();
  }

  Future<QuerySnapshot> getUserData(String email) async {
    return fs.collection('user_details').where('email', isEqualTo: email).limit(1).getDocuments();
  }
}
