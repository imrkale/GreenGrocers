import 'package:flutter/material.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:greengrocers/userside/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:greengrocers/global.dart';
class BasketProd extends StatefulWidget {

  BasketProd(this._controller,this._tween);
  AnimationController _controller;
  Tween<Offset> _tween;
  @override
  _BasketProdState createState() => _BasketProdState();
}

class _BasketProdState extends State<BasketProd> {
  final _key = GlobalKey<ScaffoldState>();
  Color lightGreen = Color(0xFF95E08E);
  Color lightBlueIsh = Color(0xFF33BBB5);
  Color darkGreen = Color(0xFF00AA12);
  Color backgroundColor = Color(0xFFEFEEF5);
  Color lighterBlueColor = Color(0xFF71B9EB).withOpacity(0.5);
  bool library = true;
  bool services = false;
  bool lottery = false;
  Widget tab;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: SlideTransition(
          position: widget._tween.animate(widget._controller),
          child: DraggableScrollableSheet(

            initialChildSize: 0.4,
            maxChildSize: 0.6,
            minChildSize: 0.0,
            builder: (BuildContext buildContext,ScrollController scrollController)
            {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.white],
                      stops: [0.3, 1],
                      begin: const FractionalOffset(0.5,0.2),
                      end: const FractionalOffset(1, 1),
// center: Alignment(0.0, 1),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                    ),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20.0,
                      ),
                    ]
                ),
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: user.userModel.cart.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
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
                            ),
                          ),
                          Container(height: 1.0,color: Colors.white,width: 150.0,)
                        ],
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }

}
