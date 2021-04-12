import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greengrocers/userside/models/cart_item.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";
  static const RESTAURANT_ID = "restaurantIds";
  static const RESTAURANT = "restaurant";
  static const CONTACT = "contact";

  String _id;
  List _contact;
  List _restaurantId;
  String _description;
  String _userId;
  List _restaurant;
  String _status;
  int _createdAt;
  int _total;
  List<CartItemModel> _cart;

//  getters
  String get id => _id;
  List get contact => _contact;
  List get restaurant => _restaurant;
  List get restaurantIds => _restaurantId;
  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;

  // public variable
  List<CartItemModel> get cart => _cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.get(ID);
    _description = snapshot.get(DESCRIPTION);
    _total = snapshot.get(TOTAL);
    _status = snapshot.get(STATUS);
    _userId = snapshot.get(USER_ID);
    _createdAt = snapshot.get(CREATED_AT);
    _restaurantId = snapshot.get(RESTAURANT_ID);
    _cart = _convertCartItems(snapshot.get(CART)) ?? [];
    _contact = snapshot.get(CONTACT);
    _restaurant = snapshot.get(RESTAURANT);
  }
  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
