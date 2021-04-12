import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greengrocers/userside/helpers/screen_navigation.dart';
import 'package:greengrocers/userside/provider/product.dart';
import 'package:greengrocers/userside/screens/details.dart';
import 'package:greengrocers/userside/mq.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greengrocers/userside/provider/app.dart';
import 'package:greengrocers/userside/provider/user.dart';
import 'package:greengrocers/global.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:greengrocers/userside/widgets/buyproduct.dart';
import '../helpers/style.dart';
import 'custom_text.dart';
import 'loading.dart';

class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Container(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider.products.length,
          itemBuilder: (_, index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
                child: GestureDetector(
                  onTap: () {
                    changeScreen(
                        _,
                        Details(
                          product: productProvider.products[index],
                        ));
                  },
                  child: LayoutBuilder(
                    builder: (_, Constraints) {
                      return Container(
                        height: 220,
                        width: 200,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(-2, -1),
                                  blurRadius: 5),
                            ]),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: Loading(),
                                  )),
                                  Hero(
                                    tag: productProvider.products[index].image,
                                    child: Center(
                                      child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: productProvider
                                            .products[index].image,
                                        height: 100,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                    Text(
                                        productProvider.products[index].name ??
                                            "id null",style: TextStyle(fontSize: 20.0,
                                        fontWeight: FontWeight.bold,color: Colors.black,
                                        fontFamily: 'Dosis',letterSpacing: 0.5),)
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
//                                  setState(() {
//                                    productProvider.products[index].liked = !productProvider.products[index].liked;
//                                  });
//                                  productProvider.likeDislikeProduct(userId: user.userModel.id, product: productProvider.products[index], liked: productProvider.products[index].liked);
                                    },
                                    child: Container(),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text("Rich in proteins",style: TextStyle(fontSize: 15.0,
                                      fontWeight: FontWeight.w500,color: Colors.blueGrey,
                                      fontFamily: 'Dosis'),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CustomText(
                                    text:
                                        "\$${productProvider.products[index].price / 100}",
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            //RawMaterialButton(
                            //   shape: CircleBorder(),
                            //   fillColor: Colors.green,
                            //   onPressed: () {
                            //     showModalBottomSheet(
                            //       //this builder should return a widget
                            //       context: context,
                            //       builder: (context) => BuyProduct(
                            //           productProvider.products[index]),
                            //     );
                            //   },
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          if (quantity != 1) {
                                            setState(() {
                                              quantity -= 1;
                                            });
                                          }
                                        }),
                                    GestureDetector(
                                      onTap: () async {
                                        print("All set loading");
                                        app.changeLoading();
                                        bool value = await user.addToCard(
                                            product: productProvider.products[index], quantity: quantity);
                                        if (value) {
                                          print("Item added to cart");
                                         Fluttertoast.showToast(msg: "Added to basket!",toastLength: Toast.LENGTH_SHORT);
                                          user.reloadUserModel();
                                          app.changeLoading();
                                          return;
                                        } else {
                                          print("Item NOT added to cart");
                                        }
                                        print("lOADING SET TO FALSE");
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(5.0)),
                                        child: app.isLoading
                                            ? Loading()
                                            : Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                          child: CustomText(
                                            text: "Add $quantity",
                                            color: white,
                                            size: 12,
                                            weight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          size: 20,
                                          color:Colors.green,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            quantity += 1;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            //)
                          ],
                        ),
                      );
                    },
                  ),
                ));
          }),
    );
  }
}
