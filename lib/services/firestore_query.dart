import 'package:academyapp/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreQueryService {
  static final Firestore fs = Firestore.instance;
  static final User user = User();
  static final batch = fs.batch();

  static final FirestoreQueryService _instance =
      FirestoreQueryService._internal();

  factory FirestoreQueryService() => _instance;

  FirestoreQueryService._internal();

  static FirestoreQueryService get instance => _instance;

  Stream<QuerySnapshot> allCursos() {
    return fs
        .collection('cursos')
        .where('visible', isEqualTo: true)
        .snapshots();
  }

  Future<QuerySnapshot> getUserData(String email) async {
    return fs
        .collection('user_details')
        .where('email', isEqualTo: email)
        .limit(1)
        .getDocuments();
  }

  Stream<QuerySnapshot> allMisCursos() {
    if (user.cursos.length == 0) return new Stream.empty();
    return fs
        .collection('cursos')
        .where('visible', isEqualTo: true)
        .where(FieldPath.documentId, whereIn: user.cursos)
        .snapshots();
  }

  Future<void> addCursoUser(String idCurso) async {
    user.cursos.add(idCurso);
    fs.collection('user_details').document(user.id).updateData({
      'cursos': FieldValue.arrayUnion([idCurso])
    }).whenComplete(() {
      makeSubscription(idCurso);
      batch.updateData(fs.collection('cursos').document(idCurso),
          {'subs': FieldValue.increment(1)});
    });
  }

  makeSubscription(String idCurso) {
    fs
        .collection('user_details')
        .document(user.id)
        .collection('cursos')
        .document(idCurso)
        .setData({'completado': false});
    fs
        .collection('cursos')
        .document(idCurso)
        .collection('contenido')
        .snapshots()
        .listen((qs) {
      qs.documents.forEach((element) {
        print(element.data);
        fs
            .collection('user_details')
            .document(user.id)
            .collection('cursos')
            .document(idCurso)
            .updateData({
          'contenido': FieldValue.arrayUnion([element.data])
        }).whenComplete(() {
          print('completado');
        });
      });
    });
  }

  Stream<DocumentSnapshot> getContentCurso(String idCurso) {
    print('getcontent');
    return fs
        .collection('user_details')
        .document(user.id)
        .collection('cursos')
        .document(idCurso)
        .get()
        .asStream();
  }

  Stream<QuerySnapshot> getItemsContent(String idCurso, String idTema) {
    return fs
        .collection('cursos')
        .document(idCurso)
        .collection('contenido')
        .document(idTema)
        .collection('items')
        .snapshots();
  }
}
