import 'package:flutter/material.dart';
import 'package:greengrocers/ParallexEffect/scrollable_exhibition_bottom_sheet.dart';
import 'package:greengrocers/userside/models/restaurant.dart';
import 'package:greengrocers/userside/screens/Tabbar2.dart';
import 'package:provider/provider.dart';
import 'package:greengrocers/userside/helpers/order.dart';
import 'package:greengrocers/userside/models/cart_item.dart';
import 'package:greengrocers/userside/helpers/style.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/userside/widgets/custom_text.dart';
import 'package:uuid/uuid.dart';
import 'package:greengrocers/userside/widgets/BaseketProducts.dart';
import 'package:greengrocers/userside/Animation/FadeAnimation.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantScreen extends StatefulWidget {
  final RestaurantModel restaurantModel;
  const RestaurantScreen({Key key, this.restaurantModel}) : super(key: key);
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}
class _RestaurantScreenState extends State<RestaurantScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final key=GlobalKey<ScaffoldState>();
    bool value=_controller.isCompleted;
    return MaterialApp(
        home: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom:60.0),
            child: GestureDetector(
              child: FloatingActionButton(
                child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _controller),
                elevation: 5,
                backgroundColor: Colors.green, //0xFF162A49
                foregroundColor: Colors.white,
                onPressed: () async {
                  if (_controller.isDismissed)
                    {
                      value=true;
                      _controller.forward();
                      print("dismiss");
                    }

                  else if (_controller.isCompleted)
                    {
                      _controller.reverse();
                      value=false;
                      print("completed");
                    }

                },
              ),
            ),
          ),
          body: SizedBox.expand(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: widget.restaurantModel.image,
                              height: 250,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            height: 250.0,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors: [
                                      Colors.black.withOpacity(.8),
                                      Colors.black.withOpacity(.2),
                                    ]
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FadeAnimation(1, Text("${widget.restaurantModel.name}",
                                  textAlign: TextAlign.center, style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),)),
                                SizedBox(height: 30,),
                                FadeAnimation(1.3, Container(
                                  padding: EdgeInsets.symmetric(vertical: 3),
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.search, color: Colors.grey,),
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                        hintText: "Search for groceries ..."
                                    ),
                                  ),
                                )),
                                SizedBox(height: 30,)
                              ],
                            ),
                          ),
                        ],
                      ),
                      FadeAnimation(1, Container(height: 500.0,
                        child: HomeTopTabs(0xff228B22, widget.restaurantModel.name,key),)),
                    ],
                  ),
                ),
                ScrollableExhibitionSheet(controller:_controller,tween: _tween),
              ],
            ),
          ),
          bottomSheet: (_controller.isCompleted || value==false)?Container(
          height: 70,
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
                              color: Colors.grey,
                              fontSize: 22,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: " \$${user.userModel.totalCartPrice}",
                          style: TextStyle(
                              color: primary,
                              fontSize: 22,
                              fontWeight: FontWeight.normal)),
                    ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: primary),
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
                                                for (CartItemModel cartItem
                                                in user.userModel.cart) {
                                                  bool value =
                                                  await user.removeFromCart(
                                                      cartItem: cartItem);
                                                  if (value) {
                                                    user.reloadUserModel();
                                                    print("Item added to cart");
                                                    _key.currentState.showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                "Removed from Cart!")));
                                                  } else {
                                                    print("ITEM WAS NOT REMOVED");
                                                  }
                                                }
                                                _key.currentState.showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            "Order created!")));
                                                Navigator.pop(context);
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
          ):null
        )
    );
  }
}
