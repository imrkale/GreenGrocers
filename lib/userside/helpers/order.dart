import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/models/order.dart';

class OrderServices {
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder(
      {String userId,
      String id,
      String description,
      String status,
      List<CartItemModel> cart,
      int totalPrice}) {
    List<Map> convertedCart = [];
    List<String> restaurantIds = [];
    List<String> restaurantname = [];
    List<String> contact = [];

    for (CartItemModel item in cart) {
      convertedCart.add(item.toMap());
      _firestore
          .collection('Stores')
          .where("id", isEqualTo: item.restaurantId)
          .get()
          .then((result) {
        for (DocumentSnapshot product in result.docs) {
          print("hhhhhhhhhhhhhhhhhhhhhhhhhhhh");
          contact.add(product.get('contact'));
          print(contact);
          print("kkkkkkkkkkkkkkkkkkkkkkkkkkk");
        }
      });
      contact.add("9423533919");
      restaurantIds.add(item.restaurantId);
      restaurantname.add(item.restaurant);
    }

    _firestore.collection(collection).doc(userId).collection("orders").doc(id).set({
      "userId": userId,
      "id": id,
      "restaurantIds": restaurantIds,
      "restaurant": restaurantname,
      "cart": convertedCart,
      "total": totalPrice+50,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status,
      "contact": contact,
    });
  }


  Future<List<OrderModel>> getUserOrders({String userId}) async => _firestore
          .collection(collection)
          .doc(userId)
          .collection("orders")
          .orderBy('createdAt',descending: true)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}
