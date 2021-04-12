import 'package:flutter/material.dart';
import 'package:greengrocers/userside/CheckoutPage/checkout.dart';
import 'package:greengrocers/userside/helpers/order.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:greengrocers/userside/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh ${user.name}");
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Shopping Cart"),

      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : (user.userModel.cart.length)>0?ListView.builder(
              itemCount: user.userModel.cart.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: red.withOpacity(0.2),
                              offset: Offset(3, 2),
                              blurRadius: 30)
                        ]),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Image.network(
                            user.userModel.cart[index].image,
                            height: 120,
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: user.userModel.cart[index].name +
                                          "\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          "\$${user.userModel.cart[index].price} \n\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                  TextSpan(
                                      text: "Quantity: ",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  TextSpan(
                                      text: user.userModel.cart[index].quantity
                                          .toString(),
                                      style: TextStyle(
                                          color: primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ]),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: red,
                                  ),
                                  onPressed: () async {
                                    app.changeLoading();
                                    bool value = await user.removeFromCart(
                                        cartItem: user.userModel.cart[index]);
                                    if (value) {
                                      user.reloadUserModel();
                                      print("Item removed from cart");
                                      _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Removed from Cart!")));
                                      app.changeLoading();
                                      return;
                                    } else {
                                      print("ITEM WAS NOT REMOVED");
                                      app.changeLoading();
                                    }
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }):Padding(
                padding: const EdgeInsets.only(bottom:15.0,left: 15.0,right: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Your Basket is empty, go and explore! We have what you need"
                      ,style: TextStyle(fontSize: 25.0,color: Colors.grey.shade600,wordSpacing: 1.5
                            ,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                    ),
                    Image.asset("images/basket-empty.png",height: MediaQuery.of(context).size.height/2,),
                  ],
                ),
              ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 70,
          decoration: BoxDecoration(color:Colors.green.shade50,borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Total: ",
                        style: TextStyle(
                            color: grey,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " \$${user.userModel.totalCartPrice}",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.normal)),
                  ]),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Colors.lightGreen),
                  child: FlatButton(
                      onPressed: () {
                        if (user.userModel.totalCartPrice == 0) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)), //this right here
                                  child: Container(
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Your cart is empty',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                          return;
                        }
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'You will be charged \$${user.userModel.totalCartPrice} upon delivery!',
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () async {
                                              // var uuid = Uuid();
                                              // String id = uuid.v4();
                                              // _orderServices.createOrder(
                                              //     userId: user.user.uid,
                                              //     id: id,
                                              //     description:
                                              //         "Some random description",
                                              //     status: "complete",
                                              //     totalPrice: user
                                              //         .userModel.totalCartPrice,
                                              //     cart: user.userModel.cart);
                                              // for (CartItemModel cartItem
                                              //     in user.userModel.cart) {
                                              //   bool value =
                                              //       await user.removeFromCart(
                                              //           cartItem: cartItem);
                                              //   if (value) {
                                              //     user.reloadUserModel();
                                              //     print("Item added to cart");
                                              //     _key.currentState.showSnackBar(
                                              //         SnackBar(
                                              //             content: Text(
                                              //                 "Removed from Cart!")));
                                              //   } else {
                                              //     print("ITEM WAS NOT REMOVED");
                                              //   }
                                              // }
                                              // await _key.currentState.showSnackBar(
                                              //     SnackBar(
                                              //         content: Text(
                                              //             "Order created!")));
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (BuildContext context) => Checkout()));
                                            },
                                            child: Text(
                                              "Accept",
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            color: const Color(0xFF1BC0C5),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Reject",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: red),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: CustomText(
                        text: "Check out",
                        size: 20,
                        color: white,
                        weight: FontWeight.normal,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


















