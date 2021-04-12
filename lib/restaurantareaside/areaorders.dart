import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:greengrocers/userside/widgets/loading.dart';
import 'package:provider/provider.dart';

class AreaOrderWidget extends StatefulWidget {
  final List<CartItemModel> cartItemModel;
  final cityname;
  AreaOrderWidget({this.cartItemModel,this.cityname});
  @override
  _AreaOrderWidgetState createState() => _AreaOrderWidgetState();
}

class _AreaOrderWidgetState extends State<AreaOrderWidget> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Shopping Cart"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : ListView.builder(
          itemCount: widget.cartItemModel.length,
          itemBuilder: (_, index) {
            return widget.cartItemModel[index].areaname.elementAt(1)?Padding(
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
                        widget.cartItemModel[index].image,
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
                                  text: widget.cartItemModel[index].name +
                                      "\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                  "\$${widget.cartItemModel[index].price} \n\n",
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
                                  text: widget.cartItemModel[index].quantity
                                      .toString(),
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(text: widget.cartItemModel[index].restaurant.toString(),
                                  style: TextStyle(color: primary,fontSize: 16,fontWeight: FontWeight.w400))
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
                                    cartItem: widget.cartItemModel[index]);
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
            ):null;
          }),
    );
  }


}