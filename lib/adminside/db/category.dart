import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'categories';

  void createCategory(Map<String, dynamic> data) {
    var id = Uuid();
    String categoryId = id.v1();
    data["id"] = categoryId;

    _firestore.collection(ref).doc(categoryId).set(data);
  }

  Future<List<DocumentSnapshot>> getCategories() =>
      _firestore.collection(ref).get().then((snaps) {
        return snaps.docs;
      });

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(ref)
          .where('category', isEqualTo: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });
}
