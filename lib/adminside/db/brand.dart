import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'Stores';
  String areaname = "Hadapsar";
  String cityname = "Pune";
//restaurants
  void createBrand(Map<String, dynamic> data) {
    var id = Uuid();
    String brandId = id.v1();
    data["id"] = brandId;
    _firestore.collection(ref).doc(brandId).set(data);
  }

  Future<List<DocumentSnapshot>> getBrands() async => _firestore
      .collection(ref)
      .where("areaname", arrayContains: areaname)

      .get()
      .then((result) {
        return result.docs;
      });

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(ref)
          .where('brand', isEqualTo: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });
}
