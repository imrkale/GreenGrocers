import 'package:flutter/material.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/helpers/order.dart';
import 'package:uuid/uuid.dart';

class Transaction_Successful extends StatefulWidget {
  @override
  _Transaction_SuccessfulState createState() => _Transaction_SuccessfulState();
}



class _Transaction_SuccessfulState extends State<Transaction_Successful> {
  OrderServices _orderServices = OrderServices();
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);
    createOrder(context,user,_orderServices);
    clearCart(context,user,_orderServices);
    return AnimatedButton(
        text: 'Success Dialog',
        color: Colors.green,
        pressEvent: () {
          AwesomeDialog(
              context: context,
              animType: AnimType.LEFTSLIDE,
              headerAnimationLoop: false,
              dialogType: DialogType.SUCCES,
              title: 'Transaction Successful',
              desc:
              'Order for ${user.userModel.email} has been created',
              btnOkOnPress: () {
                debugPrint('OnClick');
              },
              btnOkIcon: Icons.check_circle,
              onDissmissCallback: () {
                debugPrint('Dialog Dismiss from callback');
              })
            ..show();
        },
      );
  }

  void createOrder(BuildContext context, UserProvider user, OrderServices orderServices)
  {
    var uuid = Uuid();
    String id = uuid.v4();
    _orderServices.createOrder(
        userId: user.user.uid,
        id: id,
        description:
        "Some random description",
        status: "complete",
        totalPrice: user
            .userModel.totalCartPrice,
        cart: user.userModel.cart);
  }
}

void clearCart(BuildContext context, UserProvider user,OrderServices _orderServices )async
{
  for (CartItemModel cartItem
  in user.userModel.cart) {
    bool value =
        await user.removeFromCart(
        cartItem: cartItem);
    if (value) {
      user.reloadUserModel();
      print("Item added to cart");
    } else {
      print("ITEM WAS NOT REMOVED");
    }
  }
}
