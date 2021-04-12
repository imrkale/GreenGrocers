import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/models/payment_card.dart';
import 'package:greengrocers/userside/models/user.dart';

class UserServices {
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateUserData(Map<String, dynamic> values) {
    _firestore.collection(collection).doc(values['id']).update(values);
  }

  void addToCart({String userId, CartItemModel cartItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void addCard({String userId, PaymentCard cardItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cardItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "pay_card": FieldValue.arrayUnion([cardItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}
