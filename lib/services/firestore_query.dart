class FirestoreQueryService {
  static final FirestoreQueryService _instance = FirestoreQueryService._internal();
  
  factory FirestoreQueryService()=> _instance;
  
  FirestoreQueryService._internal();
  
  static FirestoreQueryService get instance => _instance;

  
}