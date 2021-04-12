import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/models/payment_card.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";
  static const PAY_CARD="pay_card";

  String _name;
  String _email;
  String _id;
  String _stripeId;
  int _priceSum = 0;

//  getters
  String get name => _name;
  String get email => _email;
  String get uid => _id;
  String get stripeId => _stripeId;

//  public variable
  List<CartItemModel> cart;
  List<PaymentCard> pay_card;

  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.get(NAME);
    _email = snapshot.get(EMAIL);
    _id = snapshot.get(ID);
    _stripeId = snapshot.get(STRIPE_ID);
    cart = _convertCartItems(snapshot.get(CART)) ?? [];
    pay_card=_convertPaymentCard(snapshot.get(PAY_CARD))??[];
    totalCartPrice = snapshot.get(CART) == null
        ? 0
        : getTotalPrice(cart: snapshot.get(CART));

  }

  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }

    int total = _priceSum;

    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");

    return total;
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
  List<PaymentCard> _convertPaymentCard(List card) {
    List<PaymentCard> convertedCard = [];
    for (Map cardItem in card) {
      convertedCard.add(PaymentCard.fromMap(cardItem));
    }
    return convertedCard;
  }
}
